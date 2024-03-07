import fs from "fs";
import util from "util";
import { pipeline } from "stream";

import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import {
  getDriveDetails,
  deleteFeedback,
  drivefeedback,
  createNewDrive,
  deleteDriveDao,
  campusYears,
  updateDriveStatus,
  updateRoundStatus,
  updateDriveStatusCompleted
} from "./drive.dao";
import {
  campusParams,
  addFeedback,
  driveId,
  newDrive,
  startRound,
} from "./drive.interface";
import { generateQuestion } from "../questionGeneration/questionSet.dao";
import redis from "../../../config/redis";
import { resultDao } from "../candidateResults/result.dao";
import { uploadCandidate } from "../../../services/candidateGeneration";
import path from "path";
import { json } from "stream/consumers";

const pump = util.promisify(pipeline);

export async function getDetails(request: FastifyRequest, reply: FastifyReply) {
  const response = await getDriveDetails();
  if (response) {
    reply.code(200).send({ status: true, data: response });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "error in fetching the drive details" });
  }
}

export async function addFeedback(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const {
    labFacilitiesRating,
    hospitalityRating,
    internetBandwidthRating,
    studentAbilityRating,
    feedback,
    driveId,
  } = request.body as addFeedback;
  const response = await drivefeedback(
    labFacilitiesRating,
    hospitalityRating,
    internetBandwidthRating,
    studentAbilityRating,
    feedback,
    driveId
  );
  if (response) {
    reply.code(200).send({ status: true, message: "feedback added" });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "error in adding the feedback details" });
  }
}

export async function removeFeedBack(
  request: FastifyRequest<{ Params: driveId }>,
  reply: FastifyReply
) {
  const driveId = Number(request.params.id);
  const response = await deleteFeedback(driveId);
  if (response) {
    reply.code(200).send({ status: true, message: "Feedback Deleted" });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "Error in deleting a Feedback" });
  }
}

export async function addDrive(request: any, reply: FastifyReply) {
  // const data =await request.file();
  const data = {};

  // Iterate over each field in the form-data
  for await (const part of request.parts()) {
    if (part.file) {
      const fileData = await collectStream(part.file);

        // Process the Excel file without saving it
        const excelData = await uploadCandidate(fileData);
        console.log(excelData);

    } else {
      // If the part is a field, store its value
      data[part.fieldname] = part.value;
    }
  }
  // Now you have all your form-data fields and files in the 'data' object
  const {
    hiringYear,
    totalQuestions,
    driveDate,
    collegeName,
    recruitmentTeam,
    jobRoles,
    noOfRounds,
    studentData,
    duration,
    difficultyLevel,
    roundName,
    skip,
    questionTopics,
    questionData
  } : any = data;
  const roundData = {
    ds: {
      easy: 5,
      medium: 4,
      hard: 2,
    },
    logical: {
      easy: 4,
      medium: 5,
      hard: 2,
    },
    sql: {
      easy: 5,
      medium: 1,
      hard: 1,
    },
  };
  const total = Object.values(roundData).reduce((acc, level) => {
    return acc + Object.values(level).reduce((acc, cnt) => acc + cnt, 0);
  }, 0);
  const roundTotalQuestions = 30;
  const diff = total - roundTotalQuestions;
  if (diff !== 0) {
    console.error(`Overall number of questions does not match roundTotalQuestions. Please ${diff > 0 ? "reduce" : "add"} ${Math.abs(diff)} questions.`);
  } else {
    console.log("OK fine");
  }
  let difficulty = difficultyLevel;
  if (Array.isArray(difficulty)) {
    difficulty = difficulty.join(",");
  }
  let topics = questionTopics;
  if (Array.isArray(topics)) {
    topics = topics.join(",");
  }
  console.log("Topics " + typeof topics + " difficulty " + typeof difficulty);
  const ConvertedDriveDate = new Date(`${driveDate}`);
  let team : number | number[] = recruitmentTeam.split(',').map(Number);
  let job: string | string[] = jobRoles.split(',');
  
  console.log(
    "From Create Drive Route",
    hiringYear,
    ConvertedDriveDate,
    collegeName,
    team,
    job,
    studentData,
    duration,
    difficulty,
    roundName,
    skip,
    totalQuestions,
    topics
  );

  const response = await createNewDrive(
    hiringYear[0],
    ConvertedDriveDate,
    collegeName,
    team,
    job,
    studentData,
    duration,
    difficulty,
    roundName,
    skip,
    totalQuestions,
    topics
  );
  if (response) {
    reply.code(200).send({ status: true, message: "Drive Created" });
  } else {
    reply
      .code(400) // bad request code change
      .send({ status: false, message: "Error in creating a Drive" });
  }
}

export async function deleteDrive(
  request: FastifyRequest<{ Params: driveId }>,
  reply: FastifyReply
) {
  const driveId = Number(request.params.id);
  const response = await deleteDriveDao(driveId);
  if (response) {
    reply.code(200).send({ status: true, message: "Drive Deleted" });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "Error in deleting a Drive" });
  }
}

export async function getCampusYears(
  request: FastifyRequest,
  reply: FastifyReply
) {
  const response = await campusYears();
  if (response) {
    reply.code(200).send({ status: true, data: response });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "Error in getting a campus Years" });
  }
}

export async function startDrive(request: FastifyRequest, reply: FastifyReply) {
  const { driveId } = request.body as startRound;
  //round set
  const round = 1;
  let response = await redis.set(`driveId:${driveId}`, JSON.stringify(round));
  let res = await updateDriveStatus(driveId);
  const status = "started";
  const questionGeneration = await generateQuestion();
  // console.log(questionGeneration)
  let roundStatus = await updateRoundStatus(driveId, round, status);
  // console.log(roundStatus)
  if (response || res) {
    reply.code(200).send({
      status: true,
      message:
        "redis - Data added and drive status updated and QuestionSetGenerated",
      redis: response,
    });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "Error in adding a campus drive" });
  }
}

export async function stopDrive(request: FastifyRequest, reply: FastifyReply) {
  const { driveId } = request.body as startRound;
  // let roundId = await redis.get(`driveId:${driveId}`);
  let round = 1;
  const results: any = await resultDao(round);
  // console.log(results);
  let response = await redis.del(`driveId:${driveId}`);
  const status = "completed";
  let roundStatus = await updateRoundStatus(driveId, round, status);
  let updateDrive = await updateDriveStatusCompleted(driveId, round);
  if (results || response || roundStatus) {
    reply.code(200).send({
      status: true,
      message: "redis - Data deleted and drive status updated",
      results: results,
    });
  } else {
    reply
      .code(403)
      .send({ status: false, message: "Error in deleting a campus drive" });
  }
}

export async function uploadDatabase(req, rep) {
  console.log("hi");
  const data = await req.file();
  try {
    const buffer = await data.toBuffer();
    console.log("hi");
  } catch (err) {
    // fileSize limit reached!
  }
  // console.log(parts);
  // const pump = util.promisify(pipeline)
  // for await (const part of parts) {
  //     // upload and save the file
  // await pump(data.file, fs.createWriteStream(`../../files/${data.filename}`))

  // }

  return { message: "files uploaded" };
}
async function collectStream(stream) {
  let data = Buffer.alloc(0);
  for await (const chunk of stream) {
    data = Buffer.concat([data, chunk]);
  }
  return data;
}

