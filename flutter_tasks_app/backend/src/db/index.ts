import { Pool } from "pg";
import { drizzle } from "drizzle-orm/node-postgres";

const pool = new Pool({
  connectionString: "postgresql://postgres:1234567890@db:5432/taskdb",
});

export const db = drizzle(pool);