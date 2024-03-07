import { FastifyInstance } from 'fastify';
import questionSetRoutes from './questionSet.route';

export default async (fastify: FastifyInstance) => {

    for (const route of questionSetRoutes)
        fastify.route(route);

};
