import { FastifyInstance } from "fastify";
import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";
import {
  addDrive,
  getDetails,
  addFeedback,
  removeFeedBack,
  deleteDrive,
  getCampusYears,
  startDrive,
  stopDrive,
  getUpcomingDrive,
  updateDriveHandler,
  getDriveByIdHandler,
  getCollegeName,
} from "./drive.controller";

const driveRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  {
    url: "/addDrive",
    handler: addDrive,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
  {
    url: "/details",
    handler: getDetails,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/upcomingDrive",
    handler: getUpcomingDrive,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/feedback",
    handler: addFeedback,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
  {
    url: "/feedback/:id",
    handler: removeFeedBack,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/drive/:id",
    handler: deleteDrive,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/campusYears",
    handler: getCampusYears,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/startDrive",
    handler: startDrive,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
  {
    url: "/stopDrive",
    handler: stopDrive,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/editDrive/:id",
    handler: updateDriveHandler,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/getDrive/:id",
    handler: getDriveByIdHandler,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/getCollegeName",
    handler: getCollegeName,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
];

export default driveRoutes;
