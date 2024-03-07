import { FastifyInstance } from 'fastify';
import recruitmentTeamRoutes from './team.route';

export default async (fastify: FastifyInstance) => {

    for (const route of recruitmentTeamRoutes)
        fastify.route(route);

};
