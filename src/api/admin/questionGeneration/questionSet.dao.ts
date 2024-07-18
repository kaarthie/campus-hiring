import prisma from "../../../utils/prisma";
import redis from "../../../config/redis";
import { shuffleArray } from "../../../utils/utils";

export async function generateQuestion() {
  try {
    console.log("fired");
    const round = 1;
    const drive: any = await prisma.drive.findFirst({
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
    for (const roundDetails of drive?.Rounds) {
      let questions: any = [];
      if (roundDetails.roundTestConfig) {
        const round = roundDetails.round;
        const questionData = JSON.parse(roundDetails.roundTestConfig);
        for (const topic in questionData) {
          const diffLevel = questionData[topic];
          for (const level in diffLevel) {
            const noOfQuestions = diffLevel[level];
            // const query = `SELECT * FROM Mcqs WHERE topic='${topic}' AND difficultLevel='${level}' ORDER BY RAND() LIMIT ${noOfQuestions}`;
            // const response: any = await prisma.$queryRaw(Prisma.raw(query));
            let previousDrive = await prisma.drive.findFirst({
              where: {
                driveDate: {
                  lt: drive?.driveDate,
                },
              },
              orderBy: {
                driveDate: "desc",
              },
            });

            let previousQuestions = await prisma.questionSet.findMany({
              where: {
                driveId: previousDrive?.driveId,
              },
            });

            let previousQuestionIds = previousQuestions.map(
              (q) => q.questionId
            );

            let fetchedQuestions;
            fetchedQuestions = await prisma.mcqs.findMany({
              where: {
                AND: [
                  { topic: topic },
                  { difficultLevel: level },
                  { id: { notIn: previousQuestionIds } },
                ],
              },
              take: noOfQuestions,
            });
            if (fetchedQuestions.length !== noOfQuestions) {
              fetchedQuestions = await prisma.mcqs.findMany({
                where: {
                  AND: [{ topic: topic }, { difficultLevel: level }],
                },
                take: noOfQuestions,
              });
            }

            shuffleArray(fetchedQuestions);
            questions.push(...fetchedQuestions);
            // questions.push(...response);
          }
        }

        for (const question of questions) {
          await redis.set(`question:${question.id}`, JSON.stringify(question));
        }
        if (questions) {
          const questionSetData = questions.map((question: any) => ({
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
    console.log("Error in generateQuestion:", error);
  }
}

export async function getQuestionDetails() {
  try {
    const mcqData = await prisma.mcqs.findMany();

    const result = mcqData.reduce((acc: any, curr: any) => {
      const { difficultLevel, topic } = curr;

      if (difficultLevel && topic) {
        if (!acc[topic]) {
          acc[topic] = {
            easy: 0,
            medium: 0,
            hard: 0,
          };
        }

        acc[topic][difficultLevel]++;
      }

      return acc;
    }, {});
    return result;
  } catch (error) {
    console.log("Error in getQuestionDetails:", error);
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
        (question: { questionId: any }) => question.questionId
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
    console.log("Error in getAdminQuestionSet:", error);
  }
}
