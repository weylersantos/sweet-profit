import { Request, Response } from "express";
import { prisma } from "../config/db.js";

export const getAll = async (req: Request, res: Response) => {
  const recipes = await prisma.recipe.findMany();

  return res.status(200).json(recipes);
};

export const getById = async (req: Request, res: Response) => {
  const recipeId = req.params.id as string;

  if (!recipeId) {
    return res.status(400).json({ message: "Recipe ID is required" });
  }

  try {
    const result = await prisma.recipe.findUnique({ where: { id: recipeId } });

    if (!result) {
      return res.status(404).json({ message: "Recipe not found" });
    }

    return res.status(200).json(result);
  } catch (err) {
    return res.status(500).json({ error: (err as Error).message });
  }
};

export const create = async (req: Request, res: Response) => {
  const { userId, name, description } = req.body;

  try {
    const result = await prisma.recipe.create({
      data: {
        name,
        description,
        createdBy: userId,
      },
    });

    return res.status(201).json({
      status: "success",
      message: "Recipe was created",
      data: result,
    });
  } catch (err) {
    return res.status(500).json({ error: (err as Error).message });
  }
}; //

export const removeById = async (req: Request, res: Response) => {
  const recipeId = req.params.id as string;

  if (!recipeId) {
    return res.status(400).json({ message: "Recipe ID is required" });
  }

  try {
    const result = await prisma.recipe.delete({ where: { id: recipeId } });

    if (!result) {
      return res.status(404).json({ message: "Recipe not found" });
    }

    return res.status(200).json({ message: "Recipe deleted" });
  } catch (err) {
    return res.status(500).json({ error: (err as Error).message });
  }
};
