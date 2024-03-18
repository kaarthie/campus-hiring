import { FastifyInstance } from 'fastify';
import slugRoutes from './slug.route';

export default async (fastify: FastifyInstance) => {

    for (const slug of slugRoutes)
        fastify.route(slug);

};
