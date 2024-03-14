import { FastifyInstance } from "fastify";
import tabSwitchRoutes from "./tabSwitch.route";

export default async (fastify: FastifyInstance) => {
  for (const tabSwitchRoute of tabSwitchRoutes) {
    fastify.route(tabSwitchRoute);
  }
};
