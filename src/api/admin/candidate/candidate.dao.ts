import { Prisma } from "@prisma/client";
import redis from "../../../config/redis";
import prisma from "../../../utils/prisma";
import { ICandidateDetailsCollege } from "./candidate.interface";

export async function createCandidate({
  driveName,
  registerNumber,
  name,
  college,
  degree,
  branch,
  dateOfBirth,
  gender,
  tenthPercentage,
  tenthYOP,
  twelthPercentage,
  twelthYOP,
  diplomaPercentage,
  diplomaYOP,
  UG_CGPA,
  UG_YOP,
  PG_CGPA,
  PG_YOP,
  arrearStatus,
  arrearCount,
  mobileNumber,
  email,
  address,
}: any) {
  console.log(driveName, ":HERE");
  try {
    const driveData: any = await prisma.college.findUnique({
      where: { driveName: driveName },
    });
    const response = await prisma.candidateDetailsCollege.create({
      data: {
        driveId: driveData.driveId,
        registerNumber: registerNumber,
        name: name,
        college: college,
        degree: degree,
        branch: branch,
        dateOfBirth: dateOfBirth,
        gender: gender,
        tenthPercentage: isNaN(parseInt(tenthPercentage as string))
          ? null
          : parseInt(tenthPercentage as string),
        tenthYOP: isNaN(parseInt(tenthYOP as string))
          ? null
          : parseInt(tenthYOP as string),
        twelthPercentage: isNaN(parseInt(twelthPercentage as string))
          ? null
          : parseInt(twelthPercentage as string),
        twelthYOP: isNaN(parseInt(twelthYOP as string))
          ? null
          : parseInt(twelthYOP as string),
        diplomaPercentage: isNaN(parseInt(diplomaPercentage as string))
          ? null
          : parseInt(diplomaPercentage as string),
        diplomaYOP: isNaN(parseInt(diplomaYOP as string))
          ? null
          : parseInt(diplomaYOP as string),
        UG_CGPA: isNaN(parseInt(UG_CGPA as string))
          ? null
          : parseInt(UG_CGPA as string),
        UG_YOP: isNaN(parseInt(UG_YOP as string))
          ? null
          : parseInt(UG_YOP as string),
        PG_CGPA: isNaN(parseInt(PG_CGPA as string))
          ? null
          : parseInt(PG_CGPA as string),
        PG_YOP: isNaN(parseInt(PG_YOP as string))
          ? null
          : parseInt(PG_YOP as string),
        arrearStatus: arrearStatus ? arrearStatus : null,
        arrearCount: isNaN(parseInt(arrearCount as string))
          ? null
          : parseInt(arrearCount as string),
        mobileNumber: mobileNumber,
        email: email.length > 0 ? email : null,
        address: address,
      },
    });
    return response;
  } catch (error) {
    console.log("Error in createCandidate:", error);
    throw error;
  }
}

// Function to fetch candidate details
export async function getCandidateDetailsForExcel(studentId: any) {
  try {
    // Query the database for candidate details
    const candidate = await prisma.candidateDetailsCollege.findUnique({
      where: { studentId },
      select: {
        name: true,
        email: true,
        college: true,
        branch: true,
        dateOfBirth: true,
        gender: true,
        mobileNumber: true,
      },
    });

    return candidate;
  } catch (error) {
    console.error("Error fetching candidate details:", error);
    throw error;
  }
}

export async function candidateStatusDao(
  driveId: number,
  page: number = 0,
  pageSize: number = 5,
  registerNumber: string
) {
  try {
    let whereCondition: any = {};
    whereCondition.driveId = driveId;
    if (registerNumber) {
      whereCondition.registerNumber = { startsWith: `${registerNumber}` };
      page = 0;
    }
    const count = await prisma.candidateDetailsCollege.count({
      where: whereCondition,
    });
    const candidatesData = await prisma.candidateDetailsCollege.findMany({
      take: +pageSize,
      skip: +page,
      where: whereCondition,
    });

    const candidatesWithStatus = await Promise.all(
      candidatesData.map(async (data: { studentId: any }) => {
        let testAttended = false;
        let testSubmitted = false;

        const testAttendedData = await prisma.candidateTracking.findFirst({
          where: { studentId: data?.studentId },
        });

        const testSubmittedData = await prisma.submitTest.findFirst({
          where: { candidateId: data?.studentId },
        });

        const questionsAttended = await prisma.answers.count({
          where: { candidateId: data?.studentId },
        });

        const candidateTrackData = await prisma.candidateTracking.findFirst({
          where: { studentId: data?.studentId },
        });

        if (testAttendedData) {
          testAttended = true;
        }

        if (testSubmittedData) {
          testSubmitted = true;
        }

        return {
          "lock status": candidateTrackData?.loginAttempts || false,
          ...data,
          testAttended,
          testSubmitted,
          questionsAttended: questionsAttended || 0,
        };
      })
    );

    return { candidatesData: candidatesWithStatus, count: count };
  } catch (error) {
    console.log("Error in candidateStatusDao() ->", error);
  }
}

export async function unlockCandidateDao(
  candidateId: number,
  timeStamp?: string
) {
  console.log(candidateId, "CHECK");
  try {
    const response = await prisma.candidateTracking.update({
      where: { studentId: candidateId },
      data: { loginAttempts: false },
    });
    const answerData = await prisma.answers.findMany({
      where: { candidateId: candidateId },
      orderBy: {
        createdAt: "desc",
      },
    });
    if (answerData && !timeStamp) {
      const timeStamp = answerData[0]?.timeStamp;
      await redis.set(`${candidateId}`, `${timeStamp}`);
    } else {
      await redis.set(`${candidateId}`, `${timeStamp}`);
    }
    return response;
  } catch (error) {
    console.log("Error in unlockCandidateDao() ->", error);
    return error;
  }
}
