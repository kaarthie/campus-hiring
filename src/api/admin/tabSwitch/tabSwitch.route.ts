import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { addNewTabCount } from "./tabSwitch.controller";
import { jwtVerification } from "../../../preHandlers/preAuth";

const tabSwitchRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  {
    url: "/addTabCount",
    handler: addNewTabCount,
    preHandler: [jwtVerification],
    method: API_METHODS.POST,
  },
];

export default tabSwitchRoutes;
