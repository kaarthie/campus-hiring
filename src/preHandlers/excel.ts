import { FastifyReply, FastifyRequest } from "fastify";
import * as fs from "fs";
import * as path from "path";
import * as pump from 'pump';

export async function preExcel(
  request: FastifyRequest,
  reply: FastifyReply,
  done: (err?: Error) => void
) {
  const uploadFolder = path.join(__dirname + "../../files");
  const data = await request.file();

  console.log(await request.file());
  if (data) {
    console.log(data.file);
    const storedfile = fs.createWriteStream(
      path.join(uploadFolder, data.filename)
    );
    await pump(data.file, storedfile, (err) => {
      if (err) {
        console.error("Error saving the file:", JSON.stringify(err));
        return done(err);
      }

      // File upload is successful
      console.log("File uploaded successfully.");
      return done();
    });
  } else {
    return reply.status(400).send("No file sent");
  }
  return reply.status(200).send({ upload: "completed" });
}
