import { FastifyInstance } from "fastify";
import pdfRoutes from "./pdf.route";

export default async (fastify: FastifyInstance) => {
  for (const pdf of pdfRoutes) {
    fastify.route(pdf);
  }
};
