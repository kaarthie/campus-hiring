import { FastifyRequest, FastifyReply } from "fastify";
import { createTabCount } from "./tabSwitch.dao";
// import { ItabSwitchDetailsCollege } from "./tabSwitch.interface";

export async function addNewTabCount(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const { tabCount, candidateId }: any = request.body;
    const response = await createTabCount(tabCount, candidateId);

    reply.code(200).send({
      status: true,
      message: "Successfully created",
      data: response,
    });
  } catch (error) {
    console.log("Error in addNewTabCount: ", error);
    reply.code(500).send({
      status: false,
      message: error.message,
    });
  }
}
