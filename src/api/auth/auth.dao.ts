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
    throw error
  }
}
