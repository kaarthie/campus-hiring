import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";
import {
  deactivateSlug,
  deleteSlug,
  generatePdfSlug,
  getDriveSlugDetails,
  getQuestions,
  showQuestions,
} from "./pdf.controller";

const pdfRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  {
    url: "/questions",
    handler: getQuestions,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/driveSlug",
    handler: getDriveSlugDetails,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/generatePdfSlug",
    handler: generatePdfSlug,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.POST,
  },
  {
    url: "/deleteSlug",
    handler: deleteSlug,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.DELETE,
  },
  {
    url: "/deactivateSlug",
    handler: deactivateSlug,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.PUT,
  },
  {
    url: "/showQuestions",
    handler: showQuestions,
    preHandler: [jwtAdminVerification],
    method: API_METHODS.GET,
  },
];

export default pdfRoutes;
