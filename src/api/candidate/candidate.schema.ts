import { FastifySchema } from 'fastify';

export const createCandidate =
{
    description: 'Api to create a candidate',
    tags: ['candidates'],
    summary: 'Api to create a candidate',
    body: {
        type: "object",
        required: ["driveId", "candidateName", "mobileNumber", "registerNumber", "email", "college", "department"],
        properties: {
            driveId: { type: 'number' },
            candidateName: { type: 'string' },
            mobileNumber: { type: 'string' },
            registerNumber: { type: 'string' },
            email: { type: 'string' },
            college: { type: 'string' },
            department: { type: 'string' },
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

export const campusDetails =
{
    description: 'Api to get campus Details',
    tags: ['candidates'],
    summary: 'Api to get campus Details',
    response: {
        200: {
            description: 'Successful response',
            type: 'object',
            properties: {
                status: { type: 'boolean' },
                // collegeName: { type: 'object' },
                campusYear: { type: 'string' },
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
}

export const trackCandidate = {
    description: 'Api to track a candidate',
    tags: ['candidates'],
    summary: 'Api to track a candidate',
    body: {
        type: "object",
        required: ["time"],
        properties: {
            time: { type: 'string' }
        },
    },
    response: {
        200: {
            description: 'Successful response',
            type: 'object',
            properties: {
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

export const candidateResponse = {
    description: 'Api to store candidate response',
    tags: ['candidates'],
    summary: 'Api to store candidate response',
    body: {
        type: "object",
        required: ["answer", "round"],
        properties: {
            answer: { type: 'string' },
            round: { type: 'number' },
            nextQuestionId: { type: 'string' }
        },
    },
    response: {
        200: {
            description: 'Successful response',
            type: 'object',
            properties: {
                status: { type: 'boolean' },
                message: { type: 'string' },
                questionData: {
                    type: 'object',
                    properties: {
                        id: {
                            type: 'number'
                        },
                        question: {
                            type: 'string'
                        },
                        optionType: {
                            type: ['string', 'null']
                        },
                        topic: {
                            type: 'string'
                        },
                        imageLink: {
                            type: ['string', 'null']
                        },
                        snippet: {
                            type: ['string', 'null']
                        },
                        options: {
                            type: 'array',
                            properties: {
                                key: {
                                    type: 'string',
                                },
                                value: {
                                    type: 'string'
                                }
                            }
                        }
                    }
                }
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

export const candidateInstructionsSchema = {
    description: 'Api to get candidate instructions',
    tags: ['candidates'],
    summary: 'Api to get candidate instructions',
    response: {
        200: {
            description: 'Successful response',
            type: 'object',
            properties: {
                status: { type: 'boolean' },
                instructions: { type: 'array' },
                attempt: { type: 'number' },
                driveStatus: { type: 'boolean' },
                totalAttendedQuestions: { type: 'number' }
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

export const questionSchema = {
    description: 'Api to get a question',
    tags: ['candidates'],
    summary: 'Api to get question from the redis server',
    body: {
        type: "object",
        required: ["questionid"],
        properties: {
            questionid: { type: 'number' },
        },
    },
    response: {
        200: {
            description: 'Successful response',
            type: 'object',
            properties: {
                status: { type: 'boolean' },
                questionData: {
                    type: 'object',
                    properties: {
                        id: {
                            type: 'number'
                        },
                        question: {
                            type: 'string'
                        },
                        optionType: {
                            type: ['string', 'null']
                        },
                        topic: {
                            type: 'string'
                        },
                        imageLink: {
                            type: ['string', 'null']
                        },
                        snippet: {
                            type: ['string', 'null']
                        },
                        options: {
                            type: 'array',
                            properties: {
                                key: {
                                    type: 'string',
                                },
                                value: {
                                    type: 'string'
                                }
                            }
                        }
                    }
                }
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

export const candidatePrivilegesSchema = {
    description: 'Api for candidate privileges',
    tags: ['candidates'],
    summary: 'Api for candidate privileges , questionSet, lastAnsweredQuestion',
    response: {
        200: {
            description: 'Successful response',
            type: 'object',
            properties: {
                status: { type: 'boolean' },
                roundPrivileges: {
                    type: 'object',
                    properties: {
                        driveId: { type: 'number' },
                        IsSkipped: { type: 'boolean' },
                        IsPrev: { type: 'boolean' },
                        SubmitOnAnswered: { type: 'boolean' }
                    }
                },
                timeTakenByCandidate: {
                    type: 'string',
                    // properties:{

                    // }
                },
                roundDetails: {
                    type: 'object',
                    properties: {
                        driveId: { type: 'number' },
                        round: { type: 'number' },
                        roundName: { type: 'string' },
                        roundDuration: { type: 'number' },
                        roundTotalQuestions: { type: 'number' },
                        roundDifficulty: { type: 'string' },
                        roundTopics: { type: 'string' }
                    }
                },
                candidateQuestionSet: {
                    type: 'array',
                    properties: {
                        id: {
                            type: 'number'
                        },
                        questionId: {
                            type: 'number'
                        },
                        answer: {
                            type: 'string'
                        }
                    }
                },
                lastAttemptedQuestion: {
                    type: 'object',
                    properties: {
                        questionid: {
                            type: 'number'
                        },
                        id: {
                            type: 'number'
                        }
                    }
                }
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