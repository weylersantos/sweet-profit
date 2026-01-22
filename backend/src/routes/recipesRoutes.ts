import express from "express";
import { create, createIngredient, removeById, getAll, getById } from "../controllers/recipesControllers.js";

const router = express.Router();

router.get("/", getAll)
router.get("/:id", getById)
router.post("/", create);
router.post("/:id/ingredients", createIngredient);
router.delete("/:id", removeById);


export default router;
