import { FastifyInstance } from 'fastify';
import resultRoutes from './result.route';

export default async (fastify: FastifyInstance) => {

    for (const route of resultRoutes)
        fastify.route(route);

};
