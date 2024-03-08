import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { memberId } from "./team.interface";
import {
  getMembers,
  addMember,
  deleteMember,
  updateTeamMember,
} from "./team.dao";
import { getQuestionDetails } from "../questionGeneration/questionSet.dao";

export async function getRecruitmentTeamMembers(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const members = await getMembers();
    const questionDetails = await getQuestionDetails()
    if (members) {
      reply.code(200).send({ status: true, members: members, questionDetails: questionDetails });
    } else {
      reply
        .code(403)
        .send({ status: false, message: "error in getting the team members" });
    }
  } catch (error) {
    console.log("Error in getRecruitmentTeamMembers: ", error);
    reply.code(500).send({ status: false, message: error.message })
  }
}

export async function addTeamMember(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
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
  } catch (error) {
    console.log("Error in addTeamMember: ", error);
    reply.code(500).send({ status: false, message: error.message })
  }
}

export async function updateMember(
  request: FastifyRequest<{ Params: memberId }>,
  reply: FastifyReply
) {
  try {
    const memberId = Number(request.params.id);
    let { name, email, position } = request.body as {
      name: string;
      email: string;
      position: String;
    };
    const pattern = /@codingmart\.com$/;
    if (pattern.test(`${email}`)) {
      const response : any = await updateTeamMember(memberId, name, email, position);
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
      reply.code(401).send({
        status: false,
        message: "user email Doesn't belong to codingmart domain",
      });
    }
  } catch (error) {
    console.log("Error in updateMember: ", error);
    reply.code(500).send({ status: false, message: error.message })
  }
}

export async function removeTeamMember(
  request: FastifyRequest<{ Params: memberId }>,
  reply: FastifyReply
) {
  try {
    const memberId = Number(request.params.id);
    const response = await deleteMember(memberId);
    if (response) {
      reply.code(200).send({ status: true, message: "Team Member Deleted" });
    } else {
      reply
        .code(403)
        .send({ status: false, message: "Error in deleting a Team Member" });
    }
  } catch (error) {
    console.log("Error in removeTeamMember: ", error);
    reply.code(500).send({ status: false, message: error.message })
  }
}
