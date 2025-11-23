import type { UUID } from "crypto"
import { type Request, type Response, type NextFunction } from "express"
import jwt from "jsonwebtoken";
import { db } from "../db/index.js";
import { users } from "../db/schema.js";
import { eq } from "drizzle-orm";


export interface AuthRequest extends Request {
  user?: UUID;
  token?: string;
}
export const auth = async (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    //get the header
    const token = req.header("x-auth-token");
    if (!token) {
      res.status(401).json({ msg: "No auth token, access denied" });
      return;
    }

    //verify if the token is valid
    const verifed = jwt.verify(token, "jwtSecretTokenStoreInDotEnvFile");
    if (!verifed) {
      res.status(401).json({ msg: "Token verification failed." });
      return;
    }

    //get the user data if the token is valid
    const verifiedToken = verifed as { id: UUID };
    const [user] = await db.select().from(users).where(eq(users.id, verifiedToken.id));

    //if no user, return false
    if (!user) {
      res.status(401).json({ msg: "User not found." });
      return;
    }
    //user exists;
    req.user = verifiedToken.id;
    req.token = token;
    next();

  } catch (e) {
    res.status(500).json(false);
  }
}