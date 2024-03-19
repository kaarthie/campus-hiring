import { OAuth2Client } from "google-auth-library";
import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { auth } from "./auth.interface";
import { checkAdmin, createAdmin } from "./auth.dao";
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
    console.log("accesstoken", request.body);
    const data = await oauth2Client.getTokenInfo(accessToken);
    const email = data.email;
    const pattern = /@codingmart\.com$/;

    if (pattern.test(`${email}`)) {
      const response: any = await checkAdmin(`${email}`);
      if (response) {
        const payload = {
          email: response,
        };
        const token = jwt.sign(payload, process.env.ADMIN_SECRET_KEY, {
          expiresIn: "24h",
        });
        console.log(token);
        reply
          .code(200)
          .send({ status: true, token: token, message: "admin Verified" });
      } else {
        reply.code(404).send({
          status: false,
          message: "admin is not registered",
        });
        // const response = await createAdmin(`${email}`);
        // const payload = {
        //   email: email,
        // };
        // const token = jwt.sign(payload, process.env.ADMIN_SECRET_KEY, {
        //   expiresIn: "24h",
        // });
        // console.log(token);
        // reply
        //   .code(200)
        //   .send({ status: true, token: token, message: "admin Verified" });
      }
    } else {
      reply.code(404).send({
        status: false,
        message: "admin does not belong to the codingmart domain",
      });
    }
  } catch (error) {
    console.log("Error in verifyCandidate: ", error);
    reply.code(500).send({
      status: false,
      message: error.message,
    });
  }
}
