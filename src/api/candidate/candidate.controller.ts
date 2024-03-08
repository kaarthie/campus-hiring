import { FastifyRequest, FastifyReply } from "fastify";
import {
  lastAnsweredQuestion,
  campusYear,
  submitTestDao,
  storeAnswerDao,
  driveInstructions,
  loginAttempts,
  getMcq,
  getcandidateQuestionSet,
  storeCandidateTime,
} from "./candidate.dao";
import redis from "../../config/redis";
import {
  candidateAnswer,
  answerParams,
  QueryParameters,
} from "./candidate.interfaces";
import {
  getPrivilegeDao,
  getRound,
  trackCandidateDao,
} from "../admin/roundPrivileges/privileges.dao";

export async function getCampusDetails(
  request: FastifyRequest,
  reply: FastifyReply
) {
  let campusId = 1; // updated according to the admin's requirement

  const response = await campusYear(campusId);
  // const response1 = await getCollegeDao();
  reply.code(200).send({ status: true, campusYear: response?.campusYear });
}

export async function candidateAnswer(
  request: FastifyRequest<{ Params: answerParams }>,
  reply: FastifyReply
) {
  const questionId = Number(request.params.id);
  const { answer, round, nextQuestionId } = request.body as candidateAnswer;
  const response = await storeAnswerDao(
    questionId,
    request.user.studentId,
    answer,
    round
  );
  // const storeTime = await storeCandidateTime(request.user.studentId);
  if (nextQuestionId) {
    const mcq = await getMcq(nextQuestionId);
    if (response) {
      reply
        .code(200)
        .send({ status: true, message: "Answer Stored", questionData: mcq });
    } else {
      reply.code(404).send({ status: false, message: "Couldn't store answer" });
    }
  } else {
    if (response) {
      reply.code(200).send({ status: true, message: "Answer Stored" });
    } else {
      reply.code(404).send({ status: false, message: "Couldn't store answer" });
    }
  }
}

export async function candidateInstructions(
  request: FastifyRequest<{ Params: answerParams }>,
  reply: FastifyReply
) {
  const studentId = request.user.studentId;
  const instructions = await driveInstructions();
  // console.log(instructions);
  const attempts = await loginAttempts(studentId);
  console.log(attempts);
  const loginAttemptsByCandidate = attempts.attempts;
  const round = Number(attempts.round);
  let driveObj = {};
  if (round) {
    driveObj = {
      driveStatus: true,
      // round: round
    };
  } else {
    driveObj = {
      driveStatus: false,
      // round: round
    };
  }
  console.log(driveObj);
  if (instructions || attempts) {
    reply.code(200).send({
      status: true,
      instructions: instructions,
      attempt: loginAttemptsByCandidate,
      driveStatus: driveObj?.driveStatus,
      totalAttendedQuestions: 0,
    });
  } else {
    reply.code(401).send({
      status: false,
      message: "Couldn't fetch instruction and Attempts",
    });
  }
}

export async function getQuestion(
  request: FastifyRequest,
  reply: FastifyReply
) {
  console.log("Question ID", request.body);
  const { questionid  } : any = request.body as { id: number };
  // const mcq = (await redis).get(`${questionId.questionId}`);
  console.log("Question--------", questionid);
  const mcq = await getMcq(questionid);
  if (mcq) {
    console.log(mcq);
    // const shuffledQuestion = await shuffleQuestionOptions(mcq);
    reply.code(200).send({ status: true, questionData: mcq });
  } else {
    reply.code(404).send({ status: false, message: "No questions available" });
  }
}

export async function timeTakenByCandidate(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const { time, driveId } = request.body as { time: object; driveId: Number };
  const studentId = request.user.studentId;
  // const setTime = { time: '38:59' }
  console.log(studentId, time);
  if (time) {
    await redis.set(`${studentId}`, `${time.time}`);
    let round = await redis.get(`driveId:${driveId}`);
    let driveObj = {};
    if (round) {
      driveObj = {
        driveStatus: true,
        // round: round
      };
    } else {
      driveObj = {
        driveStatus: false,
        // round: round
      };
    }
    reply.code(200).send({
      status: true,
      message: "storing time",
      driveStatus: driveObj?.driveStatus,
    });
  } else {
    reply
      .code(401)
      .send({ status: false, message: "error in storing the time" });
  }
}

export async function getCandidateprivileges(
  request: FastifyRequest,
  reply: FastifyReply
) {
  console.log("candidate request");
  const options: Intl.DateTimeFormatOptions = {
    hour12: false,
    hour: "numeric",
    minute: "numeric",
    second: "numeric",
  };
  console.log(
    "----------------------inside get candidate privileges----------------------------------"
  );
  const startTime: string = new Date().toLocaleString("en-IN", options);
  const roundPrivileges = await getPrivilegeDao();
  const roundDetails = await getRound();
  // console.log(roundDetails);
  const studentId = request.user.studentId;
  const candidateQuestionSet = await getcandidateQuestionSet(studentId);
  const response = await trackCandidateDao(startTime, studentId);
  // console.log(response);
  const lastAttemptedQuestion = await lastAnsweredQuestion(studentId);
  if (roundPrivileges || roundDetails || candidateQuestionSet || response) {
    reply.code(200).send({
      status: true,
      roundPrivileges: roundPrivileges,
      timeTakenByCandidate: response?.roundOneDurationTaken,
      roundDetails: roundDetails,
      candidateQuestionSet: candidateQuestionSet,
      lastAttemptedQuestion: lastAttemptedQuestion,
    });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "error in getting the privileges" });
  }
}

export async function submitTest(
  request: FastifyRequest<{ Params: QueryParameters }>,
  reply: FastifyReply
) {
  // const queryParams = request.query as QueryParameters;
  const booleanParam = request.params.id.trim() === "true";
  const { round, driveId } = request.body as { round: Number; driveId: Number };
  const result: any = submitTestDao(
    booleanParam,
    request.user.studentId,
    round,
    driveId
  );
  if (result) {
    reply.code(200).send({ status: true, message: "Test Submitted" });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "error in submitting the test" });
  }
}
