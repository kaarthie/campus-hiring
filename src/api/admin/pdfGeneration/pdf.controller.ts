import { FastifyRequest, FastifyReply } from "fastify";
import {
  deactivateSlugDao,
  deleteSlugDao,
  generatePdfSlugDao,
  getDriveSlugDetailsDao,
  getQuestionsDao,
  showQuestionsDao,
} from "./pdf.dao";
import { IPdfBody } from "./pdf.interface";

export async function getQuestions(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const response = await getQuestionsDao();
    if (response) {
      reply.code(200).send({ status: true, data: response });
    } else {
      reply.code(403).send({
        status: false,
        message: "error in fetching the Questions details",
      });
    }
  } catch (error) {
    console.log("Error in getQuestions: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function getDriveSlugDetails(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const response = await getDriveSlugDetailsDao();
    if (response) {
      reply.code(200).send({ status: true, data: response });
    } else {
      reply.code(403).send({
        status: false,
        message: "error in fetching the Drive Slug details",
      });
    }
  } catch (error) {
    console.log("Error in getDriveSlugDetails: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function generatePdfSlug(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const pdfData: IPdfBody = request.body as IPdfBody;
    const response = await generatePdfSlugDao(pdfData);
    if (response) {
      reply
        .code(200)
        .send({ status: true, message: "Slug Successfully Created" });
    } else {
      reply.code(403).send({
        status: false,
        message: "Error in Generating Slug",
      });
    }
  } catch (error) {
    console.log("Error in generatePdfSlug: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function deleteSlug(request: FastifyRequest, reply: FastifyReply) {
  try {
    const { driveId } = request.query as { driveId: number };
    const response = await deleteSlugDao(+driveId);
    if (response) {
      reply
        .code(200)
        .send({ status: true, message: "Slug Successfully Deleted" });
    } else {
      reply.code(403).send({
        status: false,
        message: "Error in Generating Slug",
      });
    }
  } catch (error) {
    console.log("Error in deleteSlug: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function deactivateSlug(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const { driveId } = request.body as { driveId: number };
    const response = await deactivateSlugDao(+driveId);
    if (response) {
      reply
        .code(200)
        .send({ status: true, message: "Slug Successfully Deactivated" });
    } else {
      reply.code(403).send({
        status: false,
        message: "Error in Generating Slug",
      });
    }
  } catch (error) {
    console.log("Error in deactivateSlug: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}

export async function showQuestions(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const { slug } = request.query as { slug: string };
    const response = await showQuestionsDao(slug);
    const formattedResponse = response.map((res) => ({
      ...res.questionPdf,
      slug: res.slug,
    }));
    if (response) {
      reply.code(200).send({ status: true, data: formattedResponse });
    } else {
      reply.code(403).send({
        status: false,
        message: "Error in fetching questions",
      });
    }
  } catch (error) {
    console.log("Error in showQuestions: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}
