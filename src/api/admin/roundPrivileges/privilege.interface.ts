export interface privileges {
    IsPrev?: Boolean,
    IsSkipped?: Boolean,
    skipQuestions?: Boolean,
    SubmitOnAnswered?: Boolean
}

export interface rounds {
    driveId: Number,
    round: Number,
    roundName?: String,
    roundDuration: Number,
    roundTotalQuestions: Number,
    roundDifficulty?: String,
    roundTopics?: String
}