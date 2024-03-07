import Fastify from "fastify";
import path from "path";
import Autoload from "@fastify/autoload";
import fastifyMulter from "fastify-multer";
import cors from "@fastify/cors";
import dotenv from "dotenv";
import { jwtVerification } from "./preHandlers/preAuth";
import { jwtAdminVerification } from "./preHandlers/preAdminAuth";
import redisClient from "./config/redis";
import multipart from "@fastify/multipart";
// import fastifyXLSX from "fastify-xlsx";
// import fastifySwagger from '@fastify/swagger';
// import { swaggerConfig, swaggerUiConfig } from "./config/swagger.config";
// import fastifySwaggerUI from '@fastify/swagger-ui';

const envPath = path.resolve(__dirname, "./.env");
const result = dotenv.config({ path: envPath });

function server() {
  const fastify = Fastify();
  fastify.register(multipart);
  fastify.register(cors, {
    origin: "*",
    credentials: true,
  });
  // fastify.register(fastifyXLSX);

  fastify.register(Autoload, {
    dir: path.join(__dirname, "api"),
    options: { prefix: "/campus-hiring" },
  });

  // fastify.register(fastifySwagger, swaggerConfig);
  // fastify.register(fastifySwaggerUI, swaggerUiConfig);
  // fastify.register(fastifyMulter.contentParser);
  // fastify.register(require("@fastify/multipart"));

  fastify.decorate("jwtVerification", jwtVerification);
  fastify.decorate("jwtAdminVerification", jwtAdminVerification);
  fastify.decorate("redis", redisClient);

  return fastify;
}
export default server;
