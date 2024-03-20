import { OAuth2Client } from "google-auth-library";
import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { auth } from "./auth.interface";
import {
  candidateTrack,
  checkCandidate,
  createCandidateTrack,
  updateCandidateTrack,
} from "./auth.dao";
import jwt from "jsonwebtoken";

const oauth2Client = new OAuth2Client({
  clientId: process.env.GOOGLE_CLIENT_ID,
});

export async function verifyCandidate(
  request: FastifyRequest,
  reply: FastifyReply
) {
  try {
    const { accessToken } = request.body as auth;
    console.log("Student Access Token" + accessToken);
    const data = await oauth2Client.getTokenInfo(accessToken);
    console.log("Student auth data" + data);
    const email = data.email;
    // const email = accessToken;
    console.log("email-->", email);
    const response = await checkCandidate(`${email}`);
    const studentId: number = response ? response?.studentId : 0;
    const candidateTrackData = await candidateTrack(studentId);
    const attempts = candidateTrackData ? candidateTrackData?.loginAttempts : "create";
    if (attempts === true) {
      throw new Error("User logged in elsewhere");
    } else if (!attempts) {
      await updateCandidateTrack(studentId);
    } else if(attempts==="create") {
      await createCandidateTrack(studentId);
    }
    if (response) {
      const payload = {
        registerNumber: response.registerNumber,
        college: response.college,
        mobileNumber: response.mobileNumber,
        studentId: response.studentId,
        driveId: response.driveId,
      };
      const token = jwt.sign(payload, process.env.SECRET_KEY, {
        expiresIn: "24h",
      });
      console.log(token);
      reply
        .code(200)
        .send({ status: true, token: token, message: "user Verified" });
    } else {
      reply.code(404).send({
        status: false,
        message: "user does not exist in the database",
      });
    }
  } catch (error) {
    console.log("Error in verifyCandidate: ", error);
    reply.code(500).send({ status: false, message: error.message });
  }
}
