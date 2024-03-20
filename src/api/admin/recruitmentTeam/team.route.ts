import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";
import {
  addTeamMember,
  checkSuperAdmin,
  getRecruitmentTeamMembers,
  removeTeamMember,
  updateMember,
} from "./team.controller";

const recruitmentTeamRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  {
    url: "/teamMember",
    handler: addTeamMember,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
  {
    url: "/teamMembers",
    handler: getRecruitmentTeamMembers,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/teamMember/:id",
    handler: removeTeamMember,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/updateTeamMember/:id",
    handler: updateMember,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/checkTeamMember",
    handler: checkSuperAdmin,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
];

export default recruitmentTeamRoutes;
