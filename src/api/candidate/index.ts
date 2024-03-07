import { FastifyInstance } from 'fastify';
import candidateRoutes from './candidate.routes';

export default async (fastify: FastifyInstance) => {

    for (const candidateRoute of candidateRoutes) {
        fastify.route(candidateRoute);
    }
};
