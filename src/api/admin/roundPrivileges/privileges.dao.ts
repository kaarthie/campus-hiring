import redis from "../../../config/redis";
import prisma from "../../../utils/prisma";

export async function addPrivilege(IsSkipped, roundId) {
  try {
    const drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        RoundPrivileges: {
          where: {
            round: roundId,
          },
        },
      },
    });
    console.log("hi", drive);
    if (drive?.RoundPrivileges?.length) {
      //     // // If RoundPrivileges already exist for the drive, update the existing record
      //     console.log("hi", drive);
      const updatedPrivileges = await prisma.roundPrivileges.update({
        where: {
          id: drive?.RoundPrivileges[0].id,
        },
        data: {
          // IsPrev: IsPrev,
          round: roundId,
          IsSkipped: IsSkipped,
          // SubmitOnAnswered: SubmitOnAnswered,
        },
      });

      return updatedPrivileges;
    } else {
      // If RoundPrivileges do not exist, create a new record
      const newPrivileges = await prisma.roundPrivileges.create({
        data: {
          // drive: {
          // connect: {
          driveId: Number(drive?.driveId),
          // },
          // },
          // IsPrev: IsPrev,
          IsSkipped: IsSkipped,
          round: roundId,
          // SubmitOnAnswered: SubmitOnAnswered,
        },
      });
      console.log(newPrivileges + " New privilege created");
      return newPrivileges;
    }
  } catch (error) {
    console.log(error);
  }
}

export async function getPrivilegeDao() {
  try {
    const res = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        RoundPrivileges: true,
      },
    });
    const driveId = res?.driveId;
    const round = await redis.get(`driveId:${driveId}`);
    console.log(round + " get privilege Dao");
    if (res) return res?.RoundPrivileges[Number(round) - 1];
  } catch (error) {
    console.log(error);
  }
}

export async function trackCandidateDao(startTime, studentId) {
  try {
    let drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
    });
    const driveId = drive?.driveId;
    let round = await redis.get(`driveId:${driveId}`);
    // console.log("round----------->", round);
    const existingCandidate = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        CandidateTracking: {
          where: {
            studentId: studentId,
            round: Number(round),
          },
        },
        Rounds: {
          where: {
            round: Number(round), // try to get from redis after start test clicked for respective Round
          },
          select: {
            roundDuration: true,
          },
        },
      },
    });
    // console.log("existingCandidate----------->", existingCandidate);
    if (existingCandidate?.CandidateTracking.length) {
      const driveId = drive?.driveId;
      let round = await redis.get(`driveId:${driveId}`);
      const updateCandidate = await prisma.candidateTracking.update({
        where: {
          driveId_studentId_round: {
            studentId: existingCandidate.CandidateTracking[0].studentId,
            driveId: existingCandidate.CandidateTracking[0].driveId,
            round: Number(round),
          },
        },
        data: {
          loginAttempts:
            Number(existingCandidate.CandidateTracking[0]?.loginAttempts) + 1, // updaing the login attempts () Number(existingCandidate?.loginAttempts) + 1)
        },
      });
      // console.log("update ---------->", updateCandidate);
      return updateCandidate;
    } else {
      // console.log(existingCandidate?.driveId, studentId, startTime);
      const driveId = drive?.driveId;
      let round = await redis.get(`driveId:${driveId}`);
      const roundDuration = await prisma.rounds.findFirst({
        where: {
          round: Number(round),
        },
        select: {
          roundDuration: true,
        },
      });

      const createCandidate = await prisma.candidateTracking.create({
        data: {
          driveId: Number(drive?.driveId),
          studentId: studentId,
          startTime: startTime,
          loginAttempts: 1,
          round: Number(round),
          roundOneDurationTaken: String(`${roundDuration?.roundDuration}:00`),
          // roundOneDurationTaken: String(`${existingCandidate?.Rounds[Number(round) - 1].roundDuration}:00`)
        },
      });
      // console.log("create", createCandidate);
      return createCandidate;
    }
  } catch (error) {
    console.log(error);
  }
}

export async function addRound(body: any) {
  const {
    round,
    roundName,
    roundDuration,
    roundTotalQuestions,
    roundDifficulty,
    roundTopics,
  } = body;
  try {
    const result = await prisma.$transaction(async (prisma) => {
      const driveId = await prisma.drive.findFirst({
        where: {
          driveStatus: "pending",
        },
      });
      if (driveId) {
        const upsertData = {
          driveId: driveId.driveId,
          round,
          roundName,
          roundDuration,
          roundTotalQuestions,
          roundDifficulty,
          roundTopics,
        };

        const res = await prisma.rounds.upsert({
          where: {
            driveId_round: {
              driveId: driveId.driveId,
              round: round,
            },
          },
          create: upsertData,
          update: upsertData,
        });

        return res;
      } else {
        return false;
      }
    });

    return result;
  } catch (error) {
    console.log(error);
  }
}

export async function getRound() {
  try {
    const drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        Rounds: true,
      },
    });
    console.log(drive);
    if (drive && drive.Rounds.length) {
      // const {
      //     round,
      //     roundName,
      //     roundDuration,
      //     roundTotalQuestions,
      //     roundDifficulty,
      //     roundTopics
      // } = drive.Rounds;

      // const roundDetails = {
      //     driveId: drive.driveId,
      //     round,
      //     roundName,
      //     roundDuration,
      //     roundTotalQuestions,
      //     roundDifficulty,
      //     roundTopics
      // };

      // // Filter out the fields with null values
      // const filteredRoundDetails = Object.fromEntries(
      //     Object.entries(roundDetails).filter(([_, value]) => value !== null)
      // );
      const driveId = drive?.driveId;
      const round = await redis.get(`driveId:${driveId}`);
      return drive.Rounds[Number(round) - 1];
    }

    return false;
  } catch (error) {
    console.log(error);
    throw error;
  }
}
