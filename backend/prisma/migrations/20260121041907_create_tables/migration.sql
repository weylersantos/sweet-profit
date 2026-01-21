-- CreateEnum
CREATE TYPE "IngredientCategory" AS ENUM ('KILOGRAMAS', 'GRAMAS', 'ML', 'LITROS', 'UNIDADE');

-- CreateEnum
CREATE TYPE "SaleMethod" AS ENUM ('MARGEM', 'VALOR_FIXO');

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ingredients" (
    "id" UUID NOT NULL,
    "createdBy" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "category" "IngredientCategory" NOT NULL,
    "amount" DECIMAL NOT NULL,
    "price" DECIMAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "ingredients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recipes" (
    "id" UUID NOT NULL,
    "createdBy" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "recipes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recipes_ingredients" (
    "id" UUID NOT NULL,
    "recipeId" UUID NOT NULL,
    "ingredientId" UUID NOT NULL,
    "amount" DECIMAL NOT NULL,
    "price" DECIMAL NOT NULL,

    CONSTRAINT "recipes_ingredients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sale_price" (
    "recipeId" UUID NOT NULL,
    "totalPrice" DECIMAL NOT NULL,
    "method" "SaleMethod" NOT NULL,
    "amount" DECIMAL NOT NULL,
    "finalPrice" DECIMAL NOT NULL,

    CONSTRAINT "sale_price_pkey" PRIMARY KEY ("recipeId")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "ingredients" ADD CONSTRAINT "ingredients_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipes" ADD CONSTRAINT "recipes_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipes_ingredients" ADD CONSTRAINT "recipes_ingredients_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "recipes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipes_ingredients" ADD CONSTRAINT "recipes_ingredients_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES "ingredients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sale_price" ADD CONSTRAINT "sale_price_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "recipes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
