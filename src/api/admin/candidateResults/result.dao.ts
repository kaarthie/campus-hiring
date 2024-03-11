import prisma from "../../../utils/prisma";
import redis from "../../../config/redis";
import { candidateAnswer } from "../../candidate/candidate.controller";
import { includes } from "lodash";
import { generateExcel } from "../../../utils/utils";

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
            roundId: true, // fetching candidate responses
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

    for (const candidateId in groupedResponses) {
      const candidateAnswers = groupedResponses[candidateId];
      let score = 0;

      for (const response of candidateAnswers) {
        const questionId = response.questionId;
        const answer = response.answer;
        const correctAnswer = correctAnswers.find(
          (ans) => ans.id === questionId
        );

        if (correctAnswer && correctAnswer.answer === answer) {
          score++;
        }
      }
      console.log(candidateAnswers);

      resultsToCreate.push({
        driveId: questions.driveId,
        candidateId: parseInt(candidateId),
        round: candidateAnswers[0].roundId,
        score: score,
      });
    }

    if (resultsToCreate.length > 0) {
      await prisma.results.createMany({
        data: resultsToCreate,
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

export async function driveResults(driveId) {
  try {
    const results = await prisma.results.findMany({
      where: {
        driveId: Number(driveId),
      },
      include: {
        student: {
          select: {
            name: true,
            registerNumber: true,
            branch: true,
          },
        },
        rounds: {
          select: {
            roundTotalQuestions: true,
            roundName: true,
          },
        },
      },
      orderBy: {
        score: "desc",
      },
    });
    // console.log(results);

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
    // console.log(notStartedTestCount - loginAttemptsCount);
    return {
      results: results,
      loginAttemptsCount: loginAttemptsCount,
      submittedTestCount: submittedTestCount,
      notstarted: notstarted,
    };

    // console.log(results, loginAttemptsCount, submittedTestCount);
    // return response;
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
        driveId: driveId.driveId,
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
