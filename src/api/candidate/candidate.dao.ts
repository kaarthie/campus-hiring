import prisma from "../../utils/prisma";
import { newCandidate } from "./candidate.interfaces";
import { shuffle } from "../../utils/utils";
import redis from "../../config/redis";
import { shuffleQuestionOptions } from "../../utils/utils";

export async function getCollegeDao() {
  try {
    const result = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        college: true,
      },
    });

    return result?.college || false;
  } catch (error) {
    throw error
  }
}

export async function campusYear(id: number) {
  try {
    const res = await prisma.campus.findFirst({
      where: {
        id: id,
      },
    });
    return res;
  } catch (error) {
    throw error
  }

}

export async function storeAnswerDao(questionId, studentId, userAnswer, round) {
  // console.log("hi", userAnswer)
  try {
    const answer = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        Answer: {
          where: {
            questionId: questionId,
            candidateId: studentId,
          },
        },
      },
    });
    console.log(
      JSON.stringify(answer) + "Answer given by student in store answer Dao"
    );
    if (answer?.Answer.length) {
      // Update existing answer
      const updatedAnswer = await prisma.answers.update({
        where: {
          answerId: answer?.Answer[0].answerId,
        },
        data: {
          answer: userAnswer,
        },
      });
      return true;
    } else {
      // Create new answer
      const newAnswer = await prisma.answers.create({
        data: {
          driveId: Number(answer?.driveId),
          questionId: questionId,
          candidateId: studentId,
          answer: userAnswer,
          roundId: +round,
        },
      });
      return true;
    }
  } catch (error) {
    throw error
  }
}

export async function loginAttempts(studentId) {
  try {
    const drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        CandidateTracking: {
          where: {
            studentId: studentId,
          },
          select: {
            loginAttempts: true,
          },
        },
      },
    });

    let driveId = drive?.driveId;
    let round = await redis.get(`driveId:${driveId}`);
    if (drive?.CandidateTracking.length)
      return {
        attempts: drive?.CandidateTracking[0].loginAttempts,
        round: round,
      };
    else return { attempts: 0, round: round };
  } catch (error) {
    throw error
  }
}

export async function driveInstructions() {
  try {
    // const instructions = await prisma.instructions.findMany();
    let instructions: String[] = [];
    let generalInstructions = [
      "No dual screens/monitors",
      "No cell phones or other secondary devices in the room or test area",
      "Click Start Test to attempt the quiz.",
      "The time will start the moment you click the Start Test button.",
      "Click on Next button to move next question. Please note that you will not be able to go back to any of the previous question after clicking Next button.",
      "Click on Submit Test button on completion of the quiz",
      "Should not switch tabs",
    ];

    const privileges = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      select: {
        RoundPrivileges: true,
      },
    });

    // if (!privileges?.RoundPrivileges?.IsPrev) {
    //   let newInstruction = "Once You answered the question and clicked the next button, you cannot switch back to the previous question."
    //   instructions = [...generalInstructions, newInstruction];
    // }
    // console.log(privileges?.RoundPrivileges?.IsSkipped);
    if (!privileges?.RoundPrivileges?.IsSkipped) {
      let newInstruction =
        "You cannot be able to skip the questions without answering them.";
      generalInstructions = [...generalInstructions, newInstruction];
      console.log("General Instructions  " + generalInstructions);
    }
    // if (privileges?.RoundPrivileges?.SubmitOnAnswered) {
    //   let newInstruction = "You can be able to submit the test only if all the questions are answered.";
    //   instructions = [...generalInstructions, newInstruction];
    // }
    return generalInstructions;
  } catch (error) {
    throw error
  }
}

export async function lastAnsweredQuestion(studentId) {
  try {
    const drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
    });
    const id = drive?.driveId;
    const round = await redis.get(`driveId:${id}`);

    const lastEntry = await prisma.answers.findFirst({
      where: {
        candidateId: studentId,
        roundId: Number(round),
      },
      orderBy: {
        answerId: "desc",
      },
    });
    if (lastEntry?.questionId) {
      // console.log("lastENtry--------->", lastEntry?.questionId)
      const questionOrderId = await prisma.candidateQuestionSet.findFirst({
        where: {
          studentId: studentId,
          questionId: lastEntry.questionId,
          round: Number(round),
        },
        select: {
          id: true,
        },
      });
      console.log(questionOrderId);
      return { questionid: lastEntry?.questionId, id: questionOrderId?.id };
    } else {
      const questionId = await prisma.candidateQuestionSet.findFirst({
        where: {
          studentId: studentId,
          id: 1,
          round: Number(round),
        },
        select: {
          questionId: true,
        },
      });
      // console.log(questionId);
      return { questionid: questionId?.questionId, id: 1 };
    }
  } catch (error) {
    throw error
  }
}

export async function getMcq(questionId) {
  try {
    let questionFormat = `question:${questionId}`;
    let questionString: any = await redis.get(questionFormat);
    const questionObj = JSON.parse(questionString);
    // let questionObj = await prisma.mcqs.findFirst({
    //   where: {
    //     id: questionId
    //   }
    // });

    if (questionObj) {
      let optionShuffledQuestion = await shuffleQuestionOptions(questionObj);
      console.log(optionShuffledQuestion + "   Shuffled");
      return {
        id: questionObj.id,
        question: questionObj.question,
        optionType: questionObj.optionType,
        topic: questionObj.topic,
        imageLink: questionObj.imageLink,
        snippet: questionObj.snippet,
        options: optionShuffledQuestion,
      };
      console.log(optionShuffledQuestion);
      // return optionShuffledQuestion;
    } else {
      return false;
    }
  } catch (error) {
    throw error
  }
}

export async function getcandidateQuestionSet(studentId) {
  try {
    const drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
    });
    const id = drive?.driveId;
    // const round = await redis.get(`driveId:${id}`);
    const round = 1;

    const driveId = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        questionSet: {
          select: {
            questionId: true,
          },
          where: {
            round: Number(round),
          },
        },
      },
    });
    console.log("question set driveId" + JSON.stringify(driveId));
    if (driveId) {
      const isQuestionSetAvailableAlready =
        await prisma.candidateQuestionSet.findFirst({
          where: {
            driveId: driveId.driveId,
            studentId: studentId,
            round: Number(round),
          },
        });
      if (isQuestionSetAvailableAlready) {
        const generateQuestionSet = await prisma.candidateQuestionSet.findMany({
          where: {
            driveId: driveId.driveId,
            studentId: studentId,
            round: Number(round),
          },
          select: {
            id: true,
            questionId: true,
          },
        });
        console.log(
          "Generate question Set " + JSON.stringify(generateQuestionSet)
        );
        const userAnswers = await prisma.answers.findMany({
          where: {
            candidateId: studentId,
            roundId: Number(round),
            questionId: {
              in: generateQuestionSet.map(
                (questionSet) => questionSet.questionId
              ),
            },
          },
          select: {
            questionId: true,
            answer: true,
          },
        });
        console.log("UserAnswers " + JSON.stringify(userAnswers));
        // Create a mapping of questionId to answer
        const answerMap = new Map<number, number | null>();
        userAnswers.forEach((answer: any) => {
          answerMap.set(answer.questionId, answer.answer);
        });
        console.log(answerMap);
        // Map answers to questionSet
        const mappedQuestionSet = generateQuestionSet.map((questionSet) => ({
          id: questionSet.id,
          questionId: questionSet.questionId,
          answer: answerMap.get(questionSet.questionId) || 0,
        }));
        return mappedQuestionSet;
      } else {
        // const id = driveId?.driveId;
        // const round = await redis.get(`driveId:${id}`);
        let shuffledQuestionSet = await shuffle(driveId.questionSet);
        console.log(shuffledQuestionSet);

        let response = await prisma.candidateQuestionSet.createMany({
          data: Object.entries<{ questionId: number }>(shuffledQuestionSet).map(
            ([key, value]) => ({
              id: Number(key),
              driveId: driveId.driveId,
              studentId: studentId,
              questionId: Number(value.questionId),
              round: Number(round),
            })
          ),
        });
        console.log(
          "Candidate question set from candidate dao" + JSON.stringify(response)
        );
        const shuffledQuestionSetArray = Object.entries(
          shuffledQuestionSet
        ).map(([key, value]) => ({
          id: key,
          questionId: (value as { questionId: number }).questionId,
        }));
        // console.log("shuffledQuestionSetArray", shuffledQuestionSetArray)
        const userAnswers = await prisma.answers.findMany({
          where: {
            candidateId: studentId,
            roundId: Number(round),
            questionId: {
              in: shuffledQuestionSetArray.map(
                (questionSet) => questionSet.questionId
              ),
            },
          },
          select: {
            questionId: true,
            answer: true,
          },
        });
        // console.log("answer", userAnswers);
        const answerMap = new Map();
        userAnswers.forEach((answer) => {
          answerMap.set(answer.questionId, answer.answer);
        });
        // console.log("userAnswers", userAnswers);
        // Map answers to questionSet
        const mappedQuestionSet = shuffledQuestionSetArray.map(
          (questionSet) => ({
            id: questionSet.id,
            questionId: questionSet.questionId,
            answer: answerMap.get(questionSet.questionId) || 0,
          })
        );
        // console.log("mappedQuestionSet", mappedQuestionSet)
        return mappedQuestionSet;
      }
    }
    return false;
  } catch (error) {
    throw error
  }
}

export async function storeCandidateTime(studentId) {
  try {
    const timeTaken: any = await redis.get(`${studentId}`);
    console.log("timeTaken from redis :", timeTaken);
    const existingCandidate = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        CandidateTracking: {
          where: {
            studentId: studentId,
          },
        },
      },
    });

    if (existingCandidate?.CandidateTracking.length) {
      const driveId = existingCandidate?.driveId;
      let round = await redis.get(`driveId:${driveId}`);
      const updateCandidate = await prisma.candidateTracking.update({
        where: {
          driveId_studentId_round: {
            studentId: studentId,
            driveId: existingCandidate.CandidateTracking[0].driveId,
            round: Number(round),
          },
        },
        data: {
          roundOneDurationTaken: timeTaken, // updaing the time Taken by the candidate
        },
      });
      // console.log("Hi", updateCandidate);
      return true;
    }
    return false;
  } catch (error) {
    throw error
  }
}

export async function submitTestDao(submitted, studentId, round, driveId) {
  try {
    const submitTest = await prisma.submitTest.upsert({
      where: {
        driveId_candidateId_round: {
          candidateId: studentId,
          driveId: Number(driveId),
          round: Number(round),
        },
      },
      update: {
        submitted: submitted,
      },
      create: {
        driveId: Number(driveId),
        candidateId: studentId,
        round: Number(round),
        submitted: submitted,
      },
    });

    return submitTest ? true : false;
  } catch (error) {
    console.log(error);
  }
}
