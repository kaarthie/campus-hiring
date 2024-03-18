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
  updateDriveStatusCompleted,
  getDrive,
  updateDrive,
  getDriveById,
} from "./drive.dao";
import {
  campusParams,
  addFeedback,
  driveId,
  newDrive,
  startRound,
} from "./drive.interface";
import {
  generateQuestion,
  getQuestionDetails,
} from "../questionGeneration/questionSet.dao";
import redis from "../../../config/redis";
import { resultDao } from "../candidateResults/result.dao";
import { uploadCandidate } from "../../../services/candidateGeneration";
import { collectStream, transformDriveResponse } from "../../../utils/utils";

export async function getDetails(request: FastifyRequest, reply: FastifyReply) {
  try {
    const response = await getDriveDetails();
    if (response) {
      reply.code(200).send({ status: true, data: response });
    } else {
      reply
        .code(403)
        .send({
          status: false,
          message: "error in fetching the drive details",
        });
    }
  } catch (error) {
    console.log("Error in getDetails: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function getUpcomingDrive(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const response = await getDrive();
    if (response) {
      reply.code(200).send({ status: true, data: response });
    } else {
      reply
        .code(403)
        .send({
          status: false,
          message: "error in fetching the drive details",
        });
    }
  } catch (error) {
    console.log("Error in getUpcomingDrive: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function addFeedback(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
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
        .send({
          status: false,
          message: "error in adding the feedback details",
        });
    }
  } catch (error) {
    console.log("Error in addFeedback: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function removeFeedBack(
  request: FastifyRequest<{ Params: driveId }>,
  reply: FastifyReply
) {
  try {
    const driveId = Number(request.params.id);
    const response = await deleteFeedback(driveId);
    if (response) {
      reply.code(200).send({ status: true, message: "Feedback Deleted" });
    } else {
      reply
        .code(403)
        .send({ status: false, message: "Error in deleting a Feedback" });
    }
  } catch (error) {
    console.log("Error in removeFeedback: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function addDrive(request: any, reply: FastifyReply) {
  try {
    const data = {};
    let excelExists = false;
    let fileData;
    // Iterate over each field in the form-data
    for await (const part of request.parts()) {
      if (part.file) {
        excelExists = true;
        fileData = await collectStream(part.file);
      } else {
        // If the part is a field, store its value
        data[part.fieldname] = part.value;
      }
    }

    const {
      hiringYear,
      totalQuestions,
      driveDate,
      collegeName,
      recruitmentTeam,
      jobRoles,
      duration,
      roundName,
      skip,
      questionData,
    }: any = data;
    console.log("Drive Data ", data);
    const roundData: any = JSON.parse(questionData);

    const total: any = Object.values(roundData).reduce(
      (acc: any, level: any) => {
        return (
          acc + Object.values(level).reduce((acc: any, cnt) => acc + cnt, 0)
        );
      },
      0
    );
    // Error indication - mismatching of selected number of questions and total questions
    const diff = total - totalQuestions;
    if (diff !== 0) {
      throw new Error(
        `Selected number of questions does not match Total No Questions. Please ${
          diff > 0 ? "reduce" : "add"
        } ${Math.abs(diff)} questions.`
      );
    }
    const ConvertedDriveDate = new Date(`${driveDate}`);
    let team: number | number[] = recruitmentTeam.split(",").map(Number);
    let job: string | string[] = jobRoles.split(",");

    // console.log(
    //   "From Create Drive Route",
    //   hiringYear,
    //   ConvertedDriveDate,
    //   collegeName,
    //   team,
    //   job,
    //   duration,
    //   roundName,
    //   skip,
    //   totalQuestions,
    //   questionData
    // );

    const response = await createNewDrive(
      hiringYear[0],
      ConvertedDriveDate,
      collegeName,
      team,
      job,
      duration,
      roundName,
      skip,
      totalQuestions,
      questionData
    );
    const driveId = response?.result[0].driveId;
    console.log(driveId,"id check")
    if (excelExists && driveId) {
      const excelData = await uploadCandidate(fileData,driveId);
      console.log(excelData);
    } else {
      throw new Error("Upload Students Data");
    }
    reply.code(200).send({ status: true, message: "Drive Created" });
  } catch (error) {
    console.log("Error in addDrive: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function deleteDrive(
  request: FastifyRequest<{ Params: driveId }>,
  reply: FastifyReply
) {
  try {
    const driveId = Number(request.params.id);
    const response = await deleteDriveDao(driveId);
    if (response) {
      reply.code(200).send({ status: true, message: "Drive Deleted" });
    } else {
      reply
        .code(403)
        .send({ status: false, message: "Error in deleting a Drive" });
    }
  } catch (error) {
    console.log("Error in getDrives: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function getCampusYears(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const response = await campusYears();
    if (response) {
      reply.code(200).send({ status: true, data: response });
    } else {
      reply
        .code(403)
        .send({ status: false, message: "Error in getting a campus Years" });
    }
  } catch (error) {
    console.log("Error in getCampusYears: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function startDrive(request: FastifyRequest, reply: FastifyReply) {
  try {
    const { driveId } = request.body as startRound;
    //round set
    const round = 1;
    let response = await redis.set(`driveId:${driveId}`, JSON.stringify(round));
    let res = await updateDriveStatus(driveId);
    const status = "started";
    const questionGeneration = await generateQuestion();
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
  } catch (error) {
    console.log("Error in startDrive: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function stopDrive(request: FastifyRequest, reply: FastifyReply) {
  try {
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
  } catch (error) {
    console.log("Error in stopDrive: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function updateDriveHandler(request: any, reply: FastifyReply) {
  try {
    const driveId = request.params.id // Assuming you have a parameter for identifying the drive to update
    const data: any = {}; // Initialize data object to store form data

    let excelExists = false;
    let fileData;

    // Iterate over each field in the form-data
    for await (const part of request.parts()) {
      if (part.file) {
        excelExists = true;
        fileData = await collectStream(part.file);
      } else {
        // If the part is a field, store its value
        data[part.fieldname] = part.value;
      }
    }

    // Assuming your form data contains fields similar to addDrive function
    const { hiringYear, totalQuestions, driveDate, collegeName, recruitmentTeam, jobRoles, duration, roundName, skip, questionData }: any = data;
    console.log("Edit Drive ------>>>>> ", data);
    // Your validation and processing logic here...

    // Call the update drive function with necessary parameters
    const response = await updateDrive(+driveId, hiringYear[0], driveDate, collegeName, recruitmentTeam, jobRoles, duration, roundName, skip, totalQuestions, questionData);

    // Handle uploading excel file if it exists
    if (excelExists) {
      const excelData = await uploadCandidate(fileData,driveId);
      console.log(excelData);
    }

    // Send success response
    reply.code(200).send({ status: true, message: "Drive Updated" , data : response});
  } catch (error) {
    console.log("Error in updateDriveHandler: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function getDriveByIdHandler(request: any, reply: FastifyReply) {
  try {
    const driveId = request.params.id // 
    // Call the controller function to get the drive information by ID
    const drive = await getDriveById(+driveId);

    // Send the retrieved drive information as a response
    reply.code(200).send({ status: true, data: transformDriveResponse(drive) });
  } catch (error) {
    console.log("Error in getDriveByIdHandler: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}
