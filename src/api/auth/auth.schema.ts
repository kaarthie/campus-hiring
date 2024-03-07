export const verifyCandidateSchema =
{
    description: 'Api to create a candidate',
    tags: ['candidates'],
    summary: 'Api to create a candidate',
    body: {
        type: "object",
        required: ["accessToken"],
        properties: {
            accessToken: { type: 'string' }
        },
    },
    response: {
        200: {
            description: 'Successful response',
            type: 'object',
            properties: {
                token: { type: 'string' },
                status: { type: 'boolean' },
                message: { type: 'string' }
            },
        },
        '404': {
            description: 'Not found',
            type: 'object',
            properties: {
                status: { type: 'boolean' },
                message: { type: 'string' }
            }
        }
    },
}