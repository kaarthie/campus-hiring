import prisma from "../../../utils/prisma";
import { ICandidateDetailsCollege } from "./candidate.interface";

export async function createCandidate({
  driveId,
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
} ) {
  try {
    const response = await prisma.candidateDetailsCollege.create({
      data: {
        driveId: +driveId,
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
        email: email,
        address: address,
      },
    });
    return response;
  } catch (error) {
    console.log("Error in createCandidate:", error);
  }
}
