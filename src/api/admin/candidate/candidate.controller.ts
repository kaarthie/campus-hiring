import { FastifyRequest, FastifyReply } from "fastify";
import { candidateStatusDao, createCandidate } from "./candidate.dao";
import { ICandidateDetailsCollege } from "./candidate.interface";

export async function addNewCandidate(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const {
      driveId,
      registerNumber,
      name,
      college,
      degree,
      branch,
      dateOfBirth,
      gender,
      tenthPercentage,
      tenthYOP,
      twelthPercentage,
      twelthYOP,
      diplomaPercentage,
      diplomaYOP,
      UG_CGPA,
      UG_YOP,
      PG_CGPA,
      PG_YOP,
      arrearStatus,
      arrearCount,
      mobileNumber,
      email,
      address,
    } = request.body as ICandidateDetailsCollege;

    const response = await createCandidate({
      driveId,
      registerNumber,
      name,
      college,
      degree,
      branch,
      dateOfBirth,
      gender,
      tenthPercentage,
      tenthYOP,
      twelthPercentage,
      twelthYOP,
      diplomaPercentage,
      diplomaYOP,
      UG_CGPA,
      UG_YOP,
      PG_CGPA,
      PG_YOP,
      arrearStatus,
      arrearCount,
      mobileNumber,
      email,
      address,
    });

    reply.code(200).send({
      status: true,
      message: "Successfully created",
      data: response,
    });
  } catch (error) {
    console.log("Error in addNewCandidate: ", error);
    reply.code(500).send({
      status: false,
      message: error.message,
    });
  }
}

export async function candidateStatus(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const { driveId }: any = request.params;
    const response = await candidateStatusDao(+driveId);
    reply.code(200).send({
      status: true,
      message: "Here are the results",
      data: response,
    });
  } catch (error) {
    console.log("Error in candidateStatus() ->", error);
    reply.code(500).send({
      status: false,
      message: error.message,
    });
  }
}
