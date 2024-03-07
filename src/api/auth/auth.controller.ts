import { OAuth2Client } from "google-auth-library";
import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { auth } from "./auth.interface";
import { checkCandidate } from "./auth.dao";
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
    console.log("response-->", response);
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
      reply
        .code(404)
        .send({ status: false, message: "user does not exist in the database" });
    }
  } catch (error) {
    reply
    .code(500)
    .send({ status: true, message: error.message });
  }
}
