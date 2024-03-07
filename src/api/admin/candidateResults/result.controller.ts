import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import {
  resultDao,
  resultDeletionDao,
  getDrives,
  driveResults,
  resultsWithScores,
} from "./result.dao";
import { generateExcel } from "../../../utils/utils";
interface driveId {
  id: string;
}

// export async function resultGeneration(
//     request: FastifyRequest,
//     reply: FastifyReply
// ) {
//     if (result) {
//         reply.code(200).send({ status: true, results: result });
//     } else {
//         reply.code(200).send({ status: false, message: "couldn't generate results" });
//     }
// }

export async function resultDeletion(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const driveId = request.body as { driveId: number };
  const result = await resultDeletionDao(driveId);
  if (result) {
    reply
      .code(200)
      .send({ status: true, message: "Results deleted", result: result });
  } else {
    reply.code(200).send({ status: false, message: "couldn't Delete results" });
  }
}

export async function completedandPendingDrives(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const result = await getDrives();
  if (result) {
    reply.code(200).send({ status: true, data: result });
  } else {
    reply
      .code(200)
      .send({ status: false, message: "couldn't get completed drives" });
  }
}

export async function driveResult(
  request: FastifyRequest<{ Params: driveId }>,
  reply: FastifyReply
) {
  // const results = await resultDao();
  const driveId = Number(request.params.id);
  const report = await driveResults(driveId);
  // console.log(report)
  if (report) {
    reply.code(200).send({
      status: true,
      result: report?.results,
      testStartedCount: report?.loginAttemptsCount,
      testSubmittedCount: report?.submittedTestCount,
      notstarted: report?.notstarted,
    });
  } else {
    reply.code(200).send({
      status: false,
      message: "couldn't get completed drives and results",
    });
  }
}

export async function filteredResult(
  request: FastifyRequest<{ Params: { driveId; id } }>,
  reply: FastifyReply
) {
  try {
    const driveId = Number(request.params.driveId);
    const rankId = Number(request.params.id);
    const Results = await resultsWithScores(driveId, rankId);
    // const generatedFile = await generateExcel();
    reply.status(200).send(Results);
  } catch (err) {
    console.log(err);
    reply.status(403).send(err);
  }
}
