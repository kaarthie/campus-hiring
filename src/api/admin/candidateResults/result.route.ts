import { FastifyInstance } from "fastify";
import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";
import {
  resultDeletion,
  completedandPendingDrives,
  driveResult,
  filteredResult,
  filteredDownload,
} from "./result.controller";

const resultRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  // {
  //     url: '/generateResults',
  //     handler: resultGeneration,
  //     preHandler: [],
  //     method: API_METHODS.GET,
  // },
  {
    url: "/clearGeneratedResults",
    handler: resultDeletion,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/pendingDrives",
    handler: completedandPendingDrives,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/result/:id",
    handler: driveResult,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/resultDownload/:id",
    handler: filteredDownload,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/filteredResult/:driveId/:id",
    handler: filteredResult,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
];

export default resultRoutes;
