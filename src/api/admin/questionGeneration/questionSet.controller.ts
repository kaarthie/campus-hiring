import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { getAdminQuestionSet, generateQuestion } from "./questionSet.dao";

export async function generateQuestionSet(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const questionSet = await generateQuestion();
    if (questionSet) {
      reply.code(200).send({
        status: true,
        questionSet: "Question set Created",
        data: questionSet,
      });
    } else {
      reply
        .code(200)
        .send({ status: false, message: "No questions set available" });
    }
  } catch (error) {
    console.log("Error in generateQuestionSet: ", error);
    reply.code(500).send({status: false, message: error.message})
  }
}
export async function getQuestionSet(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const questionSet = await getAdminQuestionSet();
    if (questionSet) {
      reply.code(200).send({ status: true, questionSet: questionSet });
    } else {
      reply
        .code(200)
        .send({ status: false, message: "No questions set available" });
    }
  } catch (error) {
    console.log("Error in getQuestionSet: ", error);
    reply.code(500).send({status: false, message: error.message})
  }
}
