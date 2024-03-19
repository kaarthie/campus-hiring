import prisma from "../../../utils/prisma";

export async function createSlugDao(driveId: number) {
  try {
    const slug = await generateSlug(driveId);
    const response = await prisma.slugDetails.create({
      data: {
        slug: slug,
        driveId: driveId,
      },
    });
    return response;
  } catch (error) {
    console.log("Error in createSlugDao ->", error);
  }
}

async function generateSlug(driveId: number) {
  const candidateDetails = await prisma.candidateDetailsCollege.findFirst({
    where: { driveId },
  });

  const campusDetail = await prisma.drive.findFirst({
    where: { driveId },
    include: {
      campus: {
        select: { campusYear: true },
      },
    },
  });

  const college = candidateDetails?.college || "";
  if (!college || !campusDetail?.campus?.campusYear) {
    throw new Error("College name or campus year not found");
  }

  const firstThreeLetters = college.slice(0, 3).toUpperCase();
  let middleLetters: any = campusDetail.driveDate.toLocaleDateString();
  middleLetters = middleLetters.replaceAll("/", "");

  const slug = `${firstThreeLetters}${middleLetters}`;
  return slug;
}
