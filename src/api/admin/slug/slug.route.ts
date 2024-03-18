import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";
import { createSlug } from "./slug.controller";

const driveRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  {
    url: "/createSlug/:driveId",
    handler: createSlug,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
  
  
];

export default driveRoutes;
