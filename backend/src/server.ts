import express from "express";
import cors from "cors";
import { connectDB } from "./config/db.js";
import recipesRoutes from "./routes/recipesRoutes.js";

connectDB();

const app = express();
app.use(express.json());
app.use(cors());

app.use("/recipes", recipesRoutes);

app.listen(3000, () => {
  console.log("APP running on PORT 3000");
});
