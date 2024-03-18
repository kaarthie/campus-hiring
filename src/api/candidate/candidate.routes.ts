import { FastifyInstance } from "fastify";
import { API_METHODS } from "../../interface/api.interface";
import { IRouteOptions } from "../../interface/fastify.interface";
import {
  campusDetails,
  candidateResponse,
  candidateInstructionsSchema,
  questionSchema,
  candidatePrivilegesSchema,
} from "./candidate.schema";
import {
  getCampusDetails,
  timeTakenByCandidate,
  getCandidateprivileges,
  candidateAnswer,
  candidateInstructions,
  getQuestion,
  submitTest,
  addNewTabCount,
  verifySlug,
} from "./candidate.controller";
import { jwtVerification } from "../../preHandlers/preAuth";
import { uploadCandidate } from "../../services/candidateGeneration";
import upload from "../../services/multerStorage";
import { preExcel } from "../../preHandlers/excel";

const candidateRoutes: IRouteOptions<{
  Params: any;
  Body: any;
  Querystring: any;
}>[] = [
  {
    url: "/campus-details",
    handler: getCampusDetails,
    schema: campusDetails,
    preHandler: [],
    method: API_METHODS.GET,
  },
  {
    url: "/drive-instructions",
    handler: candidateInstructions,
    schema: candidateInstructionsSchema,
    preHandler: [jwtVerification],
    method: API_METHODS.GET,
  },
  {
    url: "/timeTaken",
    preHandler: [jwtVerification],
    handler: timeTakenByCandidate,
    method: API_METHODS.POST,
  },
  {
    url: "/question/:id",
    preHandler: [jwtVerification],
    // schema: candidateResponse,
    handler: candidateAnswer,
    method: API_METHODS.POST,
  },
  {
    url: "/getMcq",
    preHandler: [jwtVerification],
    handler: getQuestion,
    method: API_METHODS.POST,
  },
  {
    url: "/uploadCandidateDatabase",
    preHandler: [preExcel],
    handler: uploadCandidate,
    method: API_METHODS.POST,
  },
  {
    url: "/getCandidateprivileges",
    preHandler: [jwtVerification],
    // schema: candidatePrivilegesSchema,
    handler: getCandidateprivileges,
    method: API_METHODS.GET,
  },
  {
    url: "/submit/:id",
    preHandler: [jwtVerification],
    handler: submitTest,
    method: API_METHODS.POST,
  },
  {
    url: "/addTabCount",
    handler: addNewTabCount,
    preHandler: [jwtVerification],
    method: API_METHODS.POST,
  },
  {
    url: "/slug",
    preHandler: [jwtVerification],
    handler: verifySlug,
    method: API_METHODS.POST,
  },
];

export default candidateRoutes;
