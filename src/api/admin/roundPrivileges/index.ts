import { FastifyInstance } from 'fastify';
import privilegeRoutes from './privileges.route';

export default async (fastify: FastifyInstance) => {

    for (const privilege of privilegeRoutes)
        fastify.route(privilege);

};
