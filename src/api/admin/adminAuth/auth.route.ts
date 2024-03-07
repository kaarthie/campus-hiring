import { FastifyInstance } from "fastify";
import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { verifyCandidate } from "./auth.controller"


const authRoutes: IRouteOptions<{
    Params: any;
    Body: any;
    Querystring: any;
}>[] = [
        {
            url: '/google',
            handler: verifyCandidate,
            preHandler: [],
            method: API_METHODS.POST,
        }
    ];

export default authRoutes;