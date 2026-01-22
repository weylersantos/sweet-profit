import { Request, Response } from "express";
import { prisma } from "../config/db.js";

type ingredient = {
  userId: string;
  name: string;
  unit: "KILOGRAMAS" | "GRAMAS" | "LITROS" | "ML" | "UNIDADE";
  amount: number;
  price: number;
  description: string;
};

export const getAll = async (req: Request, res: Response) => {
  const ingredients = await prisma.ingredient.findMany();

  return res.status(200).json(ingredients);
};

export const getById = async (req: Request, res: Response) => {
  const ingredientId = req.params.id as string;

  if (!ingredientId) {
    return res.status(400).json({ message: "Ingredient ID is required" });
  }

  try {
    const result = await prisma.ingredient.findUnique({
      where: { id: ingredientId },
    });

    if (!result) {
      return res.status(404).json({ message: "Ingredient not found" });
    }

    return res.status(200).json(result);
  } catch (err) {
    return res.status(500).json({ error: (err as Error).message });
  }
};

export const create = async (req: Request, res: Response) => {
  const { userId, data } = req.body;

  const listItem = data.map((item: ingredient) =>
    Object.assign({ userId: userId }, item),
  );

  try {
    const result = await prisma.ingredient.createMany({
      data: listItem,
    });

    return res.status(201).json({
      status: "success",
      message: "Ingredient was created",
    });
  } catch (err) {
    return res.status(500).json({ error: (err as Error).message });
  }
};

export const removeById = async (req: Request, res: Response) => {
  const ingredientId = req.params.id as string;

  if (!ingredientId) {
    return res.status(400).json({ message: "Ingredient ID is required" });
  }

  try {
    const result = await prisma.ingredient.delete({
      where: { id: ingredientId },
    });

    if (!result) {
      return res.status(404).json({ message: "Ingredient not found" });
    }

    return res.status(200).json({ message: "Ingredient deleted" });
  } catch (err) {
    return res.status(500).json({ error: (err as Error).message });
  }
};
