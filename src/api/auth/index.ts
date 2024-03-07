import { FastifyInstance } from 'fastify';
import authRoutes from './auth.route';

export default async (fastify: FastifyInstance) => {

    for (const authRoute of authRoutes) {
        // if (Array.isArray(candidateRoute)) {
        //     candidateRoute.preHandler = [...candidateRoute];
        // }
        fastify.route(authRoute);
    }
};
