import { FastifyReply, FastifyRequest } from "fastify";
import { createSlugDao } from "./slug.dao";

export async function createSlug(request: FastifyRequest, reply: FastifyReply) {
  try {
    const driveId: number = Number((request.params as any).driveId);
    const response = await createSlugDao(driveId);
    reply.code(200).send({ status: true, data: response });
  } catch (error) {
    console.log("Error in createSlug() ->", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}
