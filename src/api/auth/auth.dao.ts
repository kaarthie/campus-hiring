import redis from "../../config/redis";
import prisma from "../../utils/prisma";

export async function checkCandidate(email: string) {
  try {
    const drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
      include: {
        CandidateDetailsCollege: {
          where: {
            email: email,
            // update it accordingly driveId
          },
        },
      },
    });
    console.log("Student Details from drive and college details" + drive);
    if (drive && drive.CandidateDetailsCollege.length > 0) {
      return drive.CandidateDetailsCollege[0];
    } else {
      return false;
    }
  } catch (error) {
    console.log("Error in checkCandidate:", error);
  }
}

export async function candidateTrack(studentId: number) {
  try {
    let drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
    });

    let createCandidate;

    const driveId = drive?.driveId;

    createCandidate = await prisma.candidateTracking.findFirst({
      where: { studentId: studentId },
    });

    return createCandidate;
  } catch (error) {
    console.log("Error in candidateTrack() ->", error);
  }
}

export async function updateCandidateTrack(studentId: number) {
  try {
    const options: Intl.DateTimeFormatOptions = {
      hour12: false,
      hour: "numeric",
      minute: "numeric",
      second: "numeric",
    };
    const startTime: string = new Date().toLocaleString("en-IN", options);
    await prisma.candidateTracking.update({
      where: { studentId: studentId },
      data: {
        loginAttempts: true,
        startTime: startTime,
      },
    });
  } catch (error) {
    console.log("Error in updateCandidate() ->", error);
  }
}

export async function createCandidateTrack(studentId: number) {
  try {
    let drive = await prisma.drive.findFirst({
      where: {
        driveStatus: "pending",
      },
    });

    const driveId = drive?.driveId;
    const options: Intl.DateTimeFormatOptions = {
      hour12: false,
      hour: "numeric",
      minute: "numeric",
      second: "numeric",
    };
    const startTime: string = new Date().toLocaleString("en-IN", options);
    let round = await redis.get(`driveId:${driveId}`);
    const roundDuration = await prisma.rounds.findFirst({
      where: {
        driveId: driveId,
      },
      select: {
        roundDuration: true,
      },
    });
    await prisma.candidateTracking.create({
      data: {
        driveId: Number(driveId),
        studentId: Number(studentId),
        round: Number(round),
        startTime: startTime,
        loginAttempts: true,
        roundOneDurationTaken: String(`${roundDuration?.roundDuration}:00`),
      },
    });
  } catch (error) {}
}
