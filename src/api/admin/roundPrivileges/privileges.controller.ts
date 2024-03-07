import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { privileges, rounds } from "./privilege.interface";
import {
  addPrivilege,
  getPrivilegeDao,
  addRound,
  getRound,
} from "./privileges.dao";
import { getcandidateQuestionSet } from "../../candidate/candidate.dao";

export async function addPrivileges(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const roundId = 1;
  const { IsSkipped } = request.body as privileges;
  console.log(roundId);
  const response = await addPrivilege(IsSkipped, roundId);

  if (response) {
    reply.code(200).send({ status: true, message: "privileges added" });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "error in adding the privileges" });
  }
}

export async function getprivileges(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const roundPrivileges = await getPrivilegeDao();
  if (roundPrivileges) {
    reply.code(200).send({ status: true, roundPrivileges: roundPrivileges });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "error in getting the privileges" });
  }
}

export async function addRoundDetails(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const body = request.body as rounds;
  const response = await addRound(body);
  if (response) {
    reply.code(200).send({ status: true, message: "rounds added" });
  } else {
    reply.code(403).send({ status: false, message: "rounds not added" });
  }
}

export async function getRoundDetails(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const response = await getRound();
  if (response) {
    reply.code(200).send({ status: true, data: response });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "couldn't fetch round details" });
  }
}
