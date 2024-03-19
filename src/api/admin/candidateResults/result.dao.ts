import prisma from "../../../utils/prisma";
import redis from "../../../config/redis";
import { candidateAnswer } from "../../candidate/candidate.controller";
import { includes } from "lodash";
import { generateExcel, generateExcel2 } from "../../../utils/utils";
import { Prisma } from "@prisma/client";

export async function resultDao(roundId) {
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
    const questionIds = totalQuestions.map((question) => question.questionId);
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
      (acc, response) => {
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
      const scores = {
        overall: 0,
        ds: { easy: 0, medium: 0, hard: 0 },
        sql: { easy: 0, medium: 0, hard: 0 },
        logical: { easy: 0, medium: 0, hard: 0 },
      };

      const candidateAnswers = groupedResponses[candidateId];
      for (const response of candidateAnswers) {
        const questionId = response.questionId;
        const correctAnswer = correctAnswers.find(
          (ans) => ans.id === questionId
        );

        if (correctAnswer) {
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

export async function resultDeletionDao(id) {
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
            college: true,
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
}) {
  try {
    const query = `
    SELECT 
        r.*, 
        s.name AS student_name, 
        s.registerNumber AS student_registerNumber, 
        s.branch AS student_branch,
        rd.roundTestConfig AS round_test_config,
        ts.ds,
        ts.sql,
        ts.logical,
        ts.ds_easy,
        ts.ds_medium,
        ts.ds_hard,
        ts.sql_easy,
        ts.sql_medium,
        ts.sql_hard,
        ts.logical_easy,
        ts.logical_medium,
        ts.logical_hard
    FROM 
        Results AS r
    JOIN
        round_details AS rd ON r.driveId = rd.driveId 
    JOIN 
        candidate_details_college AS s ON r.candidateId = s.studentId
    JOIN 
        topicScores AS ts ON r.candidateId = ts.candidateId
    WHERE 
        r.driveId = ${Number(driveId) || 0}
        AND ${
          Number(dsOverall)
            ? `ts.ds >= ${Number(dsOverall)}`
            : `(ts.ds_easy >= ${Number(dsE) || 0} AND ts.ds_medium >= ${
                Number(dsM) || 0
              } AND ts.ds_hard >= ${Number(dsH) || 0})`
        }
        AND ${
          Number(sqlOverall)
            ? `ts.sql >= ${Number(sqlOverall)}`
            : `(ts.sql_easy >= ${Number(sqlE) || 0} AND ts.sql_medium >= ${
                Number(sqlM) || 0
              } AND ts.sql_hard >= ${Number(sqlH) || 0})`
        }
        AND ${
          Number(logicalOverall)
            ? `ts.logical >= ${Number(logicalOverall)}`
            : `(ts.logical_easy >= ${
                Number(logicalE) || 0
              } AND ts.logical_medium >= ${
                Number(logicalM) || 0
              } AND ts.logical_hard >= ${Number(logicalH) || 0})`
        }
    ORDER BY 
        r.score DESC;
    `;

    console.log(query);

    const results: any = await prisma.$queryRaw(Prisma.raw(query));

    const notStartedTestCount = await prisma.candidateDetailsCollege.count({
      where: {
        driveId: Number(driveId),
      },
    });
    const loginAttemptsCount = await prisma.candidateTracking.count({
      where: {
        driveId: Number(driveId),
        loginAttempts: {
          gte: 1,
        },
      },
    });
    const submittedTestCount = await prisma.submitTest.count({
      where: {
        driveId: Number(driveId),
        submitted: true,
      },
    });
    console.log(loginAttemptsCount);
    let notstarted = 0;

    return {
      results: results,
      loginAttemptsCount: loginAttemptsCount,
      submittedTestCount: submittedTestCount,
      notstarted: notstarted,
      overallStudentCount: results.length,
    };

    // console.log(results, loginAttemptsCount, submittedTestCount);
    // return response;
  } catch (error) {
    console.log("Error in driveResults:", error);
  }
}
export async function filteredDownloadDao(
  driveId: number,
  score: number,
  dsOverall: number,
  dsE: number,
  dsM: number,
  dsH: number,
  sqlOverall: number,
  sqlE: number,
  sqlM: number,
  sqlH: number,
  logicalOverall: number,
  logicalE: number,
  logicalM: number,
  logicalH: number
) {
  try {
    const query = `
    SELECT 
        r.*, 
        s.name AS student_name, 
        s.registerNumber AS student_registerNumber, 
        s.email AS student_email,
        s.college AS student_college,
        s.dateOfBirth AS student_dob,
        s.gender AS student_gender,
        s.mobileNumber AS student_mobile_no,
        s.branch AS student_branch,
        ts.ds,
        ts.sql,
        ts.logical,
        ts.ds_easy,
        ts.ds_medium,
        ts.ds_hard,
        ts.sql_easy,
        ts.sql_medium,
        ts.sql_hard,
        ts.logical_easy,
        ts.logical_medium,
        ts.logical_hard
    FROM 
        Results AS r
    JOIN 
        candidate_details_college AS s ON r.candidateId = s.studentId
    JOIN 
        topicScores AS ts ON r.candidateId = ts.candidateId
    WHERE 
        r.driveId = ${Number(driveId) || 0}
        AND ${
          Number(dsOverall)
            ? `ts.ds >= ${Number(dsOverall)}`
            : `(ts.ds_easy >= ${Number(dsE) || 0} AND ts.ds_medium >= ${
                Number(dsM) || 0
              } AND ts.ds_hard >= ${Number(dsH) || 0})`
        }
        AND ${
          Number(sqlOverall)
            ? `ts.sql >= ${Number(sqlOverall)}`
            : `(ts.sql_easy >= ${Number(sqlE) || 0} AND ts.sql_medium >= ${
                Number(sqlM) || 0
              } AND ts.sql_hard >= ${Number(sqlH) || 0})`
        }
        AND ${
          Number(logicalOverall)
            ? `ts.logical >= ${Number(logicalOverall)}`
            : `(ts.logical_easy >= ${
                Number(logicalE) || 0
              } AND ts.logical_medium >= ${
                Number(logicalM) || 0
              } AND ts.logical_hard >= ${Number(logicalH) || 0})`
        }
    ORDER BY 
        r.score DESC;
    `;

    console.log(query);

    const results: any = await prisma.$queryRaw(Prisma.raw(query));

    const Result = results.map((data) => ({
      registerNumber: data?.student_registerNumber,
      score: data?.score,
      ds: data?.ds,
      sql: data?.sql,
      logical: data?.logical,
      name: data?.student_name,
      email: data?.student_email,
      college: data?.student_college,
      branch: data?.student_branch,
      gender: data?.student_gender,
      mobileNumber: data?.student_mobile_no,
      tabSwtchCount: data?.tabSwitchCount,
    }));
    console.log(Result, "CHECKL");

    const DataLink = await generateExcel2(Result, driveId);

    return {
      excelLink: DataLink || "",
    };
  } catch (error) {
    console.log("Error in driveResults:", error);
  }
}

export async function resultsWithScores(driveId, id) {
  try {
    const groupedScore = await prisma.results.groupBy({
      by: ["score"],
      _count: true,
      orderBy: {
        score: "desc",
      },
      where: {
        driveId: driveId,
      },
    } as any);
    const candidateIdsByScore = await Promise.all(
      groupedScore.map(async (result) => {
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
      entry.candidates.map((candidate) => candidate.candidateId)
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
      const candidatesWithStudents = entry.candidates.map((candidate) => {
        const student = students.find(
          (s) => s.studentId === candidate.candidateId
        );
        return {
          ...candidate,
          ...student,
        };
      });

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
