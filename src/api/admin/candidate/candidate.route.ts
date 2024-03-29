import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { addNewCandidate, candidateStatus } from "./candidate.controller";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";

const candidateRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  {
    url: "/addNew",
    handler: addNewCandidate,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
  {
    url: "/testStatus/:driveId",
    handler: candidateStatus,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
];

export default candidateRoutes;
