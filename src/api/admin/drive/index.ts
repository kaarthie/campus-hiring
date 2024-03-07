import { FastifyInstance } from 'fastify';
import driveRoutes from './drive.route';

export default async (fastify: FastifyInstance) => {

    for (const drive of driveRoutes)
        fastify.route(drive);

};
