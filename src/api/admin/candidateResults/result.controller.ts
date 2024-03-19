import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import {
  resultDao,
  resultDeletionDao,
  getDrives,
  driveResults,
  resultsWithScores,
  filteredDownloadDao,
} from "./result.dao";
import { generateExcel, generateExcel2 } from "../../../utils/utils";
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
  try {
    const driveId = request.body as { driveId: number };
    const result = await resultDeletionDao(driveId);
    if (result) {
      reply
        .code(200)
        .send({ status: true, message: "Results deleted", result: result });
    } else {
      reply
        .code(404)
        .send({ status: false, message: "couldn't Delete results" });
    }
  } catch (error) {
    console.log("Error in resultDeletion: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function completedandPendingDrives(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const result = await getDrives();
    if (result) {
      reply.code(200).send({ status: true, data: result });
    } else {
      reply
        .code(404)
        .send({ status: false, message: "couldn't get completed drives" });
    }
  } catch (error) {
    console.log("Error in getDrives: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function driveResult(
  request: FastifyRequest<{ Params: driveId }>,
  reply: FastifyReply
) {
  try {
    const driveId = Number(request.params.id);
    const queryData: any = request.query;
    const report = await driveResults({
      driveId: driveId,
      score: queryData?.score,
      dsOverall: queryData["DS Overall"],
      dsE: queryData["DS Easy"],
      dsM: queryData["DS Medium"],
      dsH: queryData["DS Hard"],
      sqlOverall: queryData["SQL Overall"],
      sqlE: queryData["SQL Easy"],
      sqlM: queryData["SQL Medium"],
      sqlH: queryData["SQL Hard"],
      logicalOverall: queryData["LOGICAL Overall"],
      logicalE: queryData["LOGICAL Easy"],
      logicalM: queryData["LOGICAL Medium"],
      logicalH: queryData["LOGICAL Hard"],
    });

    if (report) {
      reply.code(200).send({
        status: true,
        count: report?.results?.length || 0,
        testStartedCount: report?.loginAttemptsCount,
        testSubmittedCount: report?.submittedTestCount,
        notstarted: report?.notstarted,
      });
    } else {
      reply.code(404).send({
        status: false,
        message: "couldn't get completed drives and results",
      });
    }
  } catch (error) {
    console.log("Error in driveResult: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function filteredDownload(
  request: FastifyRequest<{ Params: driveId }>,
  reply: FastifyReply
) {
  try {
    const driveId = Number(request.params.id);
    const queryData: any = request.query;
    const report = await filteredDownloadDao({
      driveId: driveId,
      score: queryData?.score,
      dsOverall: queryData["DS Overall"],
      dsE: queryData["DS Easy"],
      dsM: queryData["DS Medium"],
      dsH: queryData["DS Hard"],
      sqlOverall: queryData["SQL Overall"],
      sqlE: queryData["SQL Easy"],
      sqlM: queryData["SQL Medium"],
      sqlH: queryData["SQL Hard"],
      logicalOverall: queryData["LOGICAL Overall"],
      logicalE: queryData["LOGICAL Easy"],
      logicalM: queryData["LOGICAL Medium"],
      logicalH: queryData["LOGICAL Hard"],
    });
    if (report) {
      reply.code(200).send({
        status: true,
        excelLink: report?.excelLink || "",
      });
    } else {
      reply.code(404).send({
        status: false,
        message: "couldn't get completed drives and results",
      });
    }
  } catch (error) {
    console.log("Error in driveResult: ", error);
    reply.code(500).send({ status: false, message: error.message });
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
    reply.status(200).send(Results);
  } catch (error) {
    console.log("Error in filteredResult: ", error);
    reply.code(500).send({ message: error.message });
  }
}
