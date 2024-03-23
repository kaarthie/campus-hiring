import prisma from "../../../utils/prisma";
import redis from "../../../config/redis";
import { candidateAnswer } from "../../candidate/candidate.controller";
import { includes } from "lodash";
import { generateExcel, generateExcel2 } from "../../../utils/utils";
import { Prisma } from "@prisma/client";

export async function resultDao(roundId: number) {
  try {
    const questions: any = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        questionSet: {
          select: {
            questionId: true,
            round: true,
          },
          where: {
            round: Number(roundId),
          },
        },
      },
    });

    if (!questions) {
      throw new Error("No pending drive found for the given round ID");
    }

    const totalQuestions = questions.questionSet;
    const questionIds = totalQuestions.map(
      (question: { questionId: any }) => question.questionId
    );
    const correctAnswers = await prisma.mcqs.findMany({
      where: {
        id: {
          in: questionIds,
        },
      },
      select: {
        id: true,
        answer: true,
        topic: true,
        difficultLevel: true,
      },
    });

    const candidateResponses: any = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      select: {
        Answer: {
          select: {
            candidateId: true,
            answer: true,
            questionId: true,
            roundId: true,
            answerId: true,
          },
          where: {
            roundId: Number(roundId),
          },
        },
      },
    });

    if (!candidateResponses || !candidateResponses.Answer.length) {
      console.log("No candidate answers found for the given round ID");
      return;
    }

    const groupedResponses = candidateResponses.Answer.reduce(
      (acc: any, response: any) => {
        const candidateId = response.candidateId;
        if (!acc[candidateId]) {
          acc[candidateId] = [];
        }
        acc[candidateId].push(response);
        return acc;
      },
      {}
    );

    const resultsToCreate: any = [];
    const topicsToCreate: any = [];
    for (const candidateId in groupedResponses) {
      const scores: any = {
        overall: 0,
        ds: { easy: 0, medium: 0, hard: 0 },
        sql: { easy: 0, medium: 0, hard: 0 },
        logical: { easy: 0, medium: 0, hard: 0 },
      };

      const candidateAnswers = groupedResponses[candidateId];
      for (const response of candidateAnswers) {
        const questionId = response.questionId;
        const correctAnswer = correctAnswers.find(
          (ans: { id: any }) => ans.id === questionId
        );

        if (correctAnswer && correctAnswer.answer === response.answer) {
          const { topic, difficultLevel }: any = correctAnswer;

          if (!scores[topic]) {
            scores[topic] = { easy: 0, medium: 0, hard: 0 };
          }

          if (!scores[topic][difficultLevel]) {
            scores[topic][difficultLevel] = 0;
          }

          scores[topic][difficultLevel]++;
          scores["overall"]++;
        }
      }

      const dsOverall = scores.ds.easy + scores.ds.medium + scores.ds.hard;
      const sqlOverall = scores.sql.easy + scores.sql.medium + scores.sql.hard;
      const logicalOverall =
        scores.logical.easy + scores.logical.medium + scores.logical.hard;

      topicsToCreate.push({
        candidateId: parseInt(candidateId),
        ds: dsOverall,
        ds_easy: scores.ds.easy,
        ds_medium: scores.ds.medium,
        ds_hard: scores.ds.hard,
        sql: sqlOverall,
        sql_easy: scores.sql.easy,
        sql_medium: scores.sql.medium,
        sql_hard: scores.sql.hard,
        logical: logicalOverall,
        logical_easy: scores.logical.easy,
        logical_medium: scores.logical.medium,
        logical_hard: scores.logical.hard,
      });

      resultsToCreate.push({
        driveId: questions.driveId,
        candidateId: parseInt(candidateId),
        round: candidateAnswers[0].roundId,
        score: scores.overall,
        tabSwitchCount: 0,
      });
    }

    if (resultsToCreate.length > 0) {
      await prisma.results.createMany({
        data: resultsToCreate,
      });
      await prisma.topicScores.createMany({
        data: topicsToCreate,
      });
    } else {
      console.log("No results to create");
    }
  } catch (error) {
    console.error("Error in resultDao:", error);
  }
}

export async function resultDeletionDao(id: any) {
  try {
    let response = await prisma.results.deleteMany({
      where: {
        drive: {
          // driveStatus: 'pending'
          driveId: id,
        },
      },
    });
    return response;
  } catch (error) {
    console.log("Error in resultDeletionDao:", error);
  }
}

export async function getDrives() {
  try {
    let response = await prisma.drive.findMany({
      where: {
        driveStatus: {
          in: ["completed", "pending"],
        },
      },
      include: {
        campus: {
          select: {
            campusYear: true,
          },
        },
        college: {
          select: {
            driveName: true,
          },
        },
      },
    });

    return response;
  } catch (error) {
    console.log("Error in getDrives:", error);
  }
}

export async function driveResults({
  driveId,
  score,
  dsOverall,
  dsE,
  dsM,
  dsH,
  sqlOverall,
  sqlE,
  sqlM,
  sqlH,
  logicalOverall,
  logicalE,
  logicalM,
  logicalH,
}: any) {
  try {
    let whereCondition: any = {};

    if (dsOverall) {
      whereCondition.ds = { gte: Number(dsOverall) };
    } else if (!dsOverall && (dsE || dsH || dsM)) {
      whereCondition.AND = [
        { ds_easy: { gte: Number(dsE || 0) } },
        { ds_medium: { gte: Number(dsM || 0) } },
        { ds_hard: { gte: Number(dsH || 0) } },
      ];
    }

    if (sqlOverall) {
      whereCondition.sql = { gte: Number(sqlOverall) };
    } else if (!sqlOverall && (sqlE || sqlH || sqlM)) {
      whereCondition.AND = [
        { sql_easy: { gte: Number(sqlE || 0) } },
        { sql_medium: { gte: Number(sqlM || 0) } },
        { sql_hard: { gte: Number(sqlH || 0) } },
      ];
    }

    if (logicalOverall) {
      whereCondition.logical = { gte: Number(logicalOverall) };
    } else if (!logicalOverall && (logicalE || logicalH || logicalM)) {
      whereCondition.AND = [
        { logical_easy: { gte: Number(logicalE || 0) } },
        { logical_medium: { gte: Number(logicalM || 0) } },
        { logical_hard: { gte: Number(logicalH || 0) } },
      ];
    }

    const results: any = await prisma.results.findMany({
      where: { driveId },
      include: {
        topicScores: {
          where: whereCondition,
        },
      },
    });

    const finalResult = [];
    results.map((data: any) => {
      if (data.topicScores.length > 0) {
        finalResult.push(data.topicScores[0]);
      }
    });

    const submittedTestCount = await prisma.submitTest.count({
      where: {
        driveId: Number(driveId),
        submitted: true,
      },
    });

    let notstarted = 0;

    return {
      results: finalResult,
      submittedTestCount: submittedTestCount,
      notstarted: notstarted,
      overallStudentCount: results.length,
    };
  } catch (error) {
    console.log("Error in driveResults:", error);
  }
}
export async function filteredDownloadDao({
  driveId,
  score,
  dsOverall,
  dsE,
  dsM,
  dsH,
  sqlOverall,
  sqlE,
  sqlM,
  sqlH,
  logicalOverall,
  logicalE,
  logicalM,
  logicalH,
}: any) {
  try {
    // const query = `
    // SELECT
    //     r.*,
    //     s.name AS student_name,
    //     tab.tabCount AS tab_count,
    //     s.registerNumber AS student_registerNumber,
    //     s.email AS student_email,
    //     s.college AS student_college,
    //     s.dateOfBirth AS student_dob,
    //     s.gender AS student_gender,
    //     s.mobileNumber AS student_mobile_no,
    //     s.branch AS student_branch,
    //     ts.ds,
    //     ts.sql,
    //     ts.logical,
    //     ts.ds_easy,
    //     ts.ds_medium,
    //     ts.ds_hard,
    //     ts.sql_easy,
    //     ts.sql_medium,
    //     ts.sql_hard,
    //     ts.logical_easy,
    //     ts.logical_medium,
    //     ts.logical_hard
    // FROM
    //     Results AS r
    // JOIN
    //     candidate_details_college AS s ON r.candidateId = s.studentId
    // JOIN
    //     topicScores AS ts ON r.candidateId = ts.candidateId
    // JOIN
    //     tabSwitch AS tab ON r.candidateId = tab.candidateId
    // WHERE
    //     r.driveId = ${Number(driveId) || 0}
    //     AND ${
    //       Number(dsOverall)
    //         ? `ts.ds >= ${Number(dsOverall)}`
    //         : `(ts.ds_easy >= ${Number(dsE) || 0} AND ts.ds_medium >= ${
    //             Number(dsM) || 0
    //           } AND ts.ds_hard >= ${Number(dsH) || 0})`
    //     }
    //     AND ${
    //       Number(sqlOverall)
    //         ? `ts.sql >= ${Number(sqlOverall)}`
    //         : `(ts.sql_easy >= ${Number(sqlE) || 0} AND ts.sql_medium >= ${
    //             Number(sqlM) || 0
    //           } AND ts.sql_hard >= ${Number(sqlH) || 0})`
    //     }
    //     AND ${
    //       Number(logicalOverall)
    //         ? `ts.logical >= ${Number(logicalOverall)}`
    //         : `(ts.logical_easy >= ${
    //             Number(logicalE) || 0
    //           } AND ts.logical_medium >= ${
    //             Number(logicalM) || 0
    //           } AND ts.logical_hard >= ${Number(logicalH) || 0})`
    //     }
    // ORDER BY
    //     r.score DESC;
    // `;

    // const results: any = await prisma.$queryRaw(Prisma.raw(query));

    let whereCondition: any = {};

    if (dsOverall) {
      whereCondition.ds = { gte: Number(dsOverall) };
    } else if (!dsOverall && (dsE || dsH || dsM)) {
      whereCondition.AND = [
        { ds_easy: { gte: Number(dsE || 0) } },
        { ds_medium: { gte: Number(dsM || 0) } },
        { ds_hard: { gte: Number(dsH || 0) } },
      ];
    }

    if (sqlOverall) {
      whereCondition.sql = { gte: Number(sqlOverall) };
    } else if (!sqlOverall && (sqlE || sqlH || sqlM)) {
      whereCondition.AND = [
        { sql_easy: { gte: Number(sqlE || 0) } },
        { sql_medium: { gte: Number(sqlM || 0) } },
        { sql_hard: { gte: Number(sqlH || 0) } },
      ];
    }

    if (logicalOverall) {
      whereCondition.logical = { gte: Number(logicalOverall) };
    } else if (!logicalOverall && (logicalE || logicalH || logicalM)) {
      whereCondition.AND = [
        { logical_easy: { gte: Number(logicalE || 0) } },
        { logical_medium: { gte: Number(logicalM || 0) } },
        { logical_hard: { gte: Number(logicalH || 0) } },
      ];
    }

    const results: any = await prisma.results.findMany({
      where: { driveId },
      include: {
        topicScores: {
          where: whereCondition,
        },
      },
    });

    const finalResult = await Promise.all(
      results.map(async (data: any) => {
        if (data.topicScores.length > 0) {
          const candidateDetails =
            await prisma.candidateDetailsCollege.findFirst({
              where: { studentId: data.topicScores[0]?.candidateId },
              include: {
                Results: { select: { score: true } },
              },
            });
          const tabSwitch = await prisma.tabSwitch.findFirst({
            where: { candidateId: data.topicScores[0]?.candidateId },
            select: { tabCount: true },
          });
          console.log(candidateDetails, tabSwitch);
          return {
            candidateDetails,
            tabSwitch,
            ...data.topicScores[0],
          };
        }
      })
    );

    const Result = [];
    finalResult.map((data: any) => {
      if (data) {
        Result.push({
          registerNumber: data?.candidateDetails?.registerNumber,
          score: data?.candidateDetails?.Results[0]?.score,
          ds: data?.ds,
          sql: data?.sql,
          logical: data?.logical,
          name: data?.candidateDetails?.name,
          email: data?.candidateDetails?.email,
          college: data?.candidateDetails?.college,
          branch: data?.candidateDetails?.branch,
          gender: data?.candidateDetails?.gender,
          mobileNumber: data?.candidateDetails?.mobileNumber,
          tabSwitchCount: data?.tabSwitch?.tabCount,
        });
      }
    });

    console.log(Result, "CHECKL");

    const DataLink = await generateExcel2(Result, driveId);

    return {
      excelLink: DataLink || "",
    };
  } catch (error) {
    console.log("Error in driveResults:", error);
  }
}

export async function resultsWithScores(driveId: any, id: number) {
  try {
    const groupedScore: any = await prisma.results.groupBy({
      by: ["score"],
      _count: true,
      orderBy: {
        score: "desc",
      },
      where: {
        driveId: driveId,
      } as any,
    });

    const candidateIdsByScore = await Promise.all(
      groupedScore.map(async (result: { score: any; _count: any }) => {
        const candidates = await prisma.results.findMany({
          where: {
            driveId: driveId.driveId,
            score: result.score,
          },
          select: {
            candidateId: true,
          },
        });

        return {
          score: result.score,
          student_count: result._count,
          candidates,
        };
      })
    );
    console.log(id);

    const candidateIds = candidateIdsByScore.flatMap((entry) =>
      entry.candidates.map(
        (candidate: { candidateId: any }) => candidate.candidateId
      )
    );

    // Fetch student details from another table
    const students = await prisma.candidateDetailsCollege.findMany({
      where: {
        studentId: {
          in: candidateIds,
        },
      },
      select: {
        studentId: true,
        registerNumber: true,
        name: true,
        email: true,
        college: true,
        branch: true,
        dateOfBirth: true,
        gender: true,
        mobileNumber: true,
      },
    });

    // Map student details into candidate objects
    const combinedData = candidateIdsByScore.map((entry) => {
      const candidatesWithStudents = entry.candidates.map(
        (candidate: { candidateId: any }) => {
          const student = students.find(
            (s: any) => s.studentId === candidate.candidateId
          );
          return {
            ...candidate,
            ...student,
          };
        }
      );

      return {
        ...entry,
        candidates: candidatesWithStudents,
      };
    });
    console.log("Combined Results " + JSON.stringify(combinedData));

    if (!id) {
      return combinedData;
    } else {
      const Result = combinedData.filter((scores) => {
        return scores.score >= id;
      });
      console.log(driveId);
      const DataLink = await generateExcel(Result, driveId);
      console.log(DataLink);
      return { FilteredCandidates: Result, ExcelLink: DataLink };
    }
  } catch (error) {
    console.log("Error in resultsWithScores:", error);
  }
}

export async function topRankScoreDao(driveId: number) {
  try {
    const topScoreData: any = await prisma.results.findFirst({
      where: { driveId: Number(driveId) },
      orderBy: {
        score: "desc",
      },
    });

    const dsScore = await prisma.candidateDetailsCollege.findMany({
      where: { driveId: Number(driveId) },
      include: {
        Results: {
          select: {
            topicScores: true,
          },
        },
      },
    });

    let topicScores = dsScore
      .map((data: any) => {
        if (data?.Results) {
          return data?.Results[0]?.topicScores[0];
        }
      })
      .filter((score: any) => score !== undefined);

    const highestScores = topicScores.reduce(
      (acc: any, curr: any) => {
        if (!acc.ds || curr.ds > acc.ds) {
          acc.ds = curr.ds;
        }
        if (!acc.sql || curr.sql > acc.sql) {
          acc.sql = curr.sql;
        }
        if (!acc.logical || curr.logical > acc.logical) {
          acc.logical = curr.logical;
        }
        return acc;
      },
      { ds: 0, sql: 0, logical: 0 }
    );

    return { score: topScoreData?.score, ...highestScores };
  } catch (error) {
    console.log("Error in topRankScoreDao() ->", error);
    throw error;
  }
}
