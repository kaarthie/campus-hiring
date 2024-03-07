import prisma from "../../../utils/prisma";
import { Prisma } from "@prisma/client";
const { sql } = require("@prisma/client");
import redis from "../../../config/redis";

export async function generateQuestion() {
  console.log("Inside Question set generation");
  try {
    const drivedetails = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      // include: {
      //     Rounds: true,
      // },
    });
    let driveId = drivedetails?.driveId;
    // let round = await redis.get(`driveId:${driveId}`);
    let round = 1;
    // console.log(round + " Round in start drive");
    const drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        Rounds: {
          where: {
            round: Number(round),
          },
        },
      },
    });
    console.log(JSON.stringify(drive) + " From drive");
    for (const roundDetails of drive?.Rounds) {
      if (roundDetails.roundTopics && roundDetails.roundDifficulty) {
        // console.log(roundDetails)
        const round = roundDetails.round;
        const totalQuestions = roundDetails.roundTotalQuestions;
        console.log("Total Questions " + totalQuestions);
        const topics = roundDetails.roundTopics;
        console.log("typeof topics " + typeof topics);
        const difficultLevel = roundDetails.roundDifficulty;
        console.log("typeof  difficultyLevel  " + typeof difficultLevel);
        let conditions: string[] = [];
        let query = `SELECT * FROM Mcqs WHERE`;
        if (topics) {
          const topicsArray = topics
            .split(",")
            .map((level) => `'${level.trim()}'`);
          console.log("Topics array" + topicsArray);
          conditions.push(`topic IN (${topicsArray.join(",")})`);
        }

        if (difficultLevel) {
          const levelsArray = difficultLevel
            .split(",")
            .map((level) => `'${level.trim()}'`);
          conditions.push(`difficultLevel IN (${levelsArray.join(",")})`);
        }

        if (conditions.length > 0) {
          query += ` ${conditions.join(" AND ")}`;
        }

        query += ` ORDER BY RAND() LIMIT ${totalQuestions}`;
        console.log("Query to generate questions " + query);
        const results: String[] = await prisma.$queryRaw(Prisma.raw(query));
        console.log(JSON.stringify(results) + " Results");
        for (const question of results) {
          // Store question in Redis
          // Assuming the Redis client is available as 'redis'
          await redis.set(`question:${question.id}`, JSON.stringify(question));
        }
        // console.log("Results from generatequestion " + JSON.stringify(results));
        if (results) {
          const questionSetData = results.map((question: any) => ({
            driveId: drive.driveId,
            round: round,
            questionId: Number(question.id),
          }));
          console.log(questionSetData);
          const response = await prisma.questionSet.createMany({
            data: questionSetData,
          });

          return response;
        }

        return false;
      }
    }
    return true;
  } catch (error) {
    console.log(error);
  }
}

export async function getAdminQuestionSet() {
  try {
    const questions = await prisma.drive.findFirst({
      // Also store it in the user database.
      where: {
        driveStatus: "pending",
      },
      select: {
        questionSet: {
          select: {
            questionId: true,
          },
        },
      },
    });
    if (questions) {
      const questionIds = questions.questionSet.map(
        (question) => question.questionId
      );
      const fetchedQuestions = await prisma.mcqs.findMany({
        where: {
          id: {
            in: questionIds,
          },
        },
      });
      for (const question of fetchedQuestions) {
        // Store question in Redis
        // Assuming the Redis client is available as 'redis'
        await redis.set(`question:${question.id}`, JSON.stringify(question));
      }
      return questions?.questionSet;
      // return fetchedQuestions;
    } else {
      return false;
    }
  } catch (error) {
    console.log(error);
  }
}
