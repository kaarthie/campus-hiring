import { FastifyInstance } from "fastify";
import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";
import { generateQuestionSet, getQuestionSet } from "./questionSet.controller"


const questionSetRoutes: IRouteOptions<{
    Params: any;
    Body: any;
    Querystring: any;
}>[] = [
        {
            url: '/generateQuestionSet',
            handler: generateQuestionSet,
            preHandler: [jwtAdminVerification],
            method: API_METHODS.GET,
        },
        {
            url: '/getAdminQuestionSet',
            handler: getQuestionSet,
            preHandler: [jwtAdminVerification],
            method: API_METHODS.GET,
        },
    ];

export default questionSetRoutes;