import fastifyMulter from "fastify-multer";
import path from "path";

const uploadFolder = path.join(__dirname + "../../files");
console.log(uploadFolder + " From multer Storage");
// console.log(uploadFolder);
const storage = fastifyMulter.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadFolder);
  },
  filename: function (req, file, cb) {
    cb(null, `${file.originalname}`);
  },
});

const upload = fastifyMulter({ storage: storage });
export default upload;
