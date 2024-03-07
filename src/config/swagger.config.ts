import { SwaggerOptions } from '@fastify/swagger';
import { FastifySwaggerUiOptions } from '@fastify/swagger-ui';

export const swaggerConfig: SwaggerOptions = {
    swagger: {
        info: {
            title: 'Campus Hiring Application',
            description: 'Campus Hiring Application swagger API',
            version: '0.1.0',
        },
        tags: [
            {
                name: 'candidates',
                description: 'candidates check endpoint',
            }
        ],
        externalDocs: {
            url: 'https://swagger.io',
            description: 'Find more info here',
        },
        consumes: ['application/json'],
        produces: ['application/json'],
    },
};

export const swaggerUiConfig: FastifySwaggerUiOptions = {
    routePrefix: '/campus-hiring-service',
    uiConfig: {
        docExpansion: 'list',
        deepLinking: false,
    },
    staticCSP: true,
};
