import prisma from "../../../utils/prisma";

export async function createSlugDao(driveId: number) {
  try {
    const uniqueSlug = await generateUniqueSlug(driveId);
    // const uniqueSlug = await generateSlug(driveId);
    const response = await prisma.slugDetails.create({
      data: {
        slug: uniqueSlug,
        driveId: driveId,
      },
    });
    return response;
  } catch (error) {
    console.log("Error in createSlugDao ->", error);
  }
}

// async function generateSlug(driveId: number) {
//   const candidateDetails = await prisma.candidateDetailsCollege.findFirst({
//     where: { driveId },
//   });

//   const campusDetail = await prisma.drive.findFirst({
//     where: { driveId },
//     include: {
//       campus: {
//         select: { campusYear: true },
//       },
//     },
//   });

//   const college = candidateDetails?.college || "";
//   if (!college || !campusDetail?.campus?.campusYear) {
//     throw new Error("College name or campus year not found");
//   }

//   const firstThreeLetters = college.slice(0, 3).toUpperCase();
//   let middleLetters: any = campusDetail.driveDate.toLocaleDateString();
//   middleLetters = middleLetters.replaceAll("/", "");

//   const slug = `${firstThreeLetters}${middleLetters}`;
//   return slug;
// }

async function generateUniqueSlug(
  driveId: number,
  attempt: number = 1
): Promise<string> {
  const slug = await generateSlug(driveId);
  const existingSlug = await prisma.slugDetails.findFirst({
    where: { slug: slug },
  });

  if (!existingSlug) {
    return slug;
  } else {
    if (attempt >= 3) {
      throw new Error("Maximum attempts reached to generate a unique slug");
    }
    return generateUniqueSlug(driveId, attempt + 1);
  }
}

function generateSlug(driveId: number): string {
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let hash = "";
  for (let i = 0; i < 6; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    hash += characters[randomIndex];
  }
  return hash;
}
