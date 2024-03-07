import { FastifyInstance } from "fastify";
import { API_METHODS } from "../../../interface/api.interface";
import { IRouteOptions } from "../../../interface/fastify.interface";
import { jwtVerification } from "../../../preHandlers/preAuth";
import { jwtAdminVerification } from "../../../preHandlers/preAdminAuth";
import { addPrivileges, getprivileges, addRoundDetails, getRoundDetails } from "./privileges.controller"


const privilegeRoutes: IRouteOptions<{
    Params: any;
    Body: any;
    Querystring: any;
}>[] = [
        {
            url: '/addPrivilege',
            handler: addPrivileges,
            preHandler: [jwtAdminVerification],
            method: API_METHODS.POST,
        },
        {
            url: '/getRoundPrivileges',
            handler: getprivileges,
            preHandler: [jwtVerification],
            method: API_METHODS.GET,
        },
        {
            url: '/addRoundDetails',
            handler: addRoundDetails,
            preHandler: [jwtAdminVerification],
            method: API_METHODS.POST,
        },
        {
            url: '/getRoundDetails',
            handler: getRoundDetails,
            preHandler: [jwtAdminVerification],
            method: API_METHODS.GET,
        }
    ];

export default privilegeRoutes;