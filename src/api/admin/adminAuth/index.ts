import { FastifyInstance } from "fastify";
import authRoutes from "./auth.route";

export default async (fastify: FastifyInstance) => {
  for (const authRoute of authRoutes) {
    fastify.route(authRoute);
  }
};
