import { FastifyInstance, FastifyRequest, FastifyReply } from 'fastify';
import  { verify } from 'jsonwebtoken';

export const jwtAdminVerification = async (
    request: FastifyRequest,
    reply: FastifyReply,
) => {
    try {
        const token = request.headers.authorization?.replace('Bearer ', '');
        const decodedToken = verify(token, process.env.ADMIN_SECRET_KEY); // Replace with your own secret key
        if (!decodedToken) {
            reply.code(401).send({ error: 'Invalid token' });
            return;
        }
        request.admin = decodedToken;
    } catch (err) {
        reply.code(401).send({ error: 'No Token available or Token Expired' });
    }
};