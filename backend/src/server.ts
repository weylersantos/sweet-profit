import express from "express";
import cors from "cors";
import { connectDB } from "./config/db.js";
import recipesRoutes from "./routes/recipesRoutes.js";
import ingredientRoutes from "./routes/ingredientsRoutes.js";

connectDB();

const app = express();
app.use(express.json());
app.use(cors());

app.use("/recipes", recipesRoutes);
app.use("/ingredients", ingredientRoutes);

app.listen(3000, () => {
  console.log("APP running on PORT 3000");
});
