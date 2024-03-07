import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { memberId } from "./team.interface";
import {
  getMembers,
  addMember,
  deleteMember,
  updateTeamMember,
} from "./team.dao";

export async function getRecruitmentTeamMembers(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const members = await getMembers();
  if (members) {
    reply.code(200).send({ status: true, members: members });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "error in getting the team members" });
  }
}

export async function addTeamMember(
  request: FastifyRequest,
  reply: FastifyReply
) {
  let { name, email, position } = request.body as {
    name: string;
    email: string;
    position: String;
  };
  const pattern = /@codingmart\.com$/;

  if (pattern.test(`${email}`)) {
    const response = await addMember(name, email, position);
    if (response.success) {
      reply.code(200).send({ status: true, message: "Team Member added" });
    } else if (response.message == "User with the same email already exists.") {
      reply.code(200).send({
        status: false,
        message: "User with the same email already exists.",
      });
    } else {
      reply
        .code(403)
        .send({ status: false, message: "Error in adding a Team Member" });
    }
  } else {
    reply.code(200).send({
      status: false,
      message: "user email Doesn't belong to codingmart domain",
    });
  }
}

export async function updateMember(
  request: FastifyRequest<{ Params: memberId }>,
  reply: FastifyReply
) {
  const memberId = Number(request.params.id);
  let { name, email, position } = request.body as {
    name: string;
    email: string;
    position: String;
  };
  const pattern = /@codingmart\.com$/;
  if (pattern.test(`${email}`)) {
    const response = await updateTeamMember(memberId, name, email, position);
    console.log(response);
    if (response.success) {
      reply.code(200).send({ status: true, message: "Team Member updated" });
    } else if (response.message == "User with the same email already exists.") {
      reply.code(200).send({
        status: false,
        message: "User with the same email already exists.",
      });
    } else {
      reply
        .code(403)
        .send({ status: false, message: "Error in updating a Team Member" });
    }
  } else {
    reply.code(200).send({
      status: false,
      message: "user email Doesn't belong to codingmart domain",
    });
  }
}

export async function removeTeamMember(
  request: FastifyRequest<{ Params: memberId }>,
  reply: FastifyReply
) {
  const memberId = Number(request.params.id);
  const response = await deleteMember(memberId);
  if (response) {
    reply.code(200).send({ status: true, message: "Team Member Deleted" });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "Error in deleting a Team Member" });
  }
}
