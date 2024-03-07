export interface newCandidate {
    driveId: number
    candidateName: string
    mobileNumber: string
    registerNumber: string
    email: string
    college: string
    department: string
}

export interface candidateTracking {
    startTime: String,
    loginAttempts?: Number,
    roundOneDurationTaken?: Number,
    roundtwoDurationTaken?: Number
}

export interface answerParams {
    id: string;
}

export interface candidateAnswer {
    answer: string,
    round: number,
    nextQuestionId: object
}

export interface QueryParameters {
    id: string; // Assuming 'param1' is a string in the query
}