import dotenv from 'dotenv';
import path from 'path';
import { createClient } from "@redis/client";

const envPath = path.resolve(__dirname, '../.env');
const result = dotenv.config({ path: envPath });

const redis = createClient({
    socket: {
        host: "localhost",
        port: 6379,
    }
});

(async () => {
    await redis.connect();
    console.log("Redis connected");
})();

export default redis;
