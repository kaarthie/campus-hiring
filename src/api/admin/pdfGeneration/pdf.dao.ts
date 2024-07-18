import prisma from "../../../utils/prisma";
import { generatePdfSlugArray } from "../../../utils/utils";
import { IPdfBody } from "./pdf.interface";

export async function getQuestionsDao() {
  try {
    const response = await prisma.questionPdf.findMany();
    return response;
  } catch (error) {
    console.log("Error in getQuestionsDao: -> ", error);
    throw error;
  }
}

export async function getDriveSlugDetailsDao() {
  try {
    const response = await prisma.slugDetails.findMany();
    return response;
  } catch (error) {
    console.log("Error in getDriveSlugDetailsDao: -> ", error);
    throw error;
  }
}

export async function generatePdfSlugDao(data: IPdfBody) {
  try {
    const pdfSlugData = generatePdfSlugArray(data);
    const response = await prisma.pdfSlug.createMany({
      data: pdfSlugData,
    });
    return response;
  } catch (error) {
    console.log("Error in generatePdfSlugDao: -> ", error);
    throw error;
  }
}

export async function deleteSlugDao(driveId: number) {
  try {
    const response = await prisma.pdfSlug.deleteMany({
      where: { driveId: driveId },
    });
    return response;
  } catch (error) {
    console.log("Error in deleteSlugDao: -> ", error);
    throw error;
  }
}

export async function deactivateSlugDao(driveId: number) {
  try {
    const response = await prisma.pdfSlug.updateMany({
      where: { driveId: driveId },
      data: { isAccess: false },
    });
    return response;
  } catch (error) {
    console.log("Error in deleteSlugDao: -> ", error);
    throw error;
  }
}

export async function showQuestionsDao(slug: string) {
  try {
    const data = await prisma.slugDetails.findFirst({
      where: { slug: slug },
    });
    console.log(data);
    const response = await prisma.pdfSlug.findMany({
      where: { driveId: data?.driveId },
      select: { questionPdf: true, slug: true },
    });
    return response;
  } catch (error) {
    console.log("Error in showQuestionsDao: -> ", error);
    throw error;
  }
}
