/*
  Warnings:

  - The values [MARGEM,VALOR_FIXO] on the enum `saleMethod` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `category` on the `ingredients` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `ingredients` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `recipes` table. All the data in the column will be lost.
  - You are about to drop the column `amount` on the `recipes_ingredients` table. All the data in the column will be lost.
  - You are about to drop the column `category` on the `recipes_ingredients` table. All the data in the column will be lost.
  - You are about to alter the column `price` on the `recipes_ingredients` table. The data in that column could be lost. The data in that column will be cast from `Decimal` to `Decimal(10,2)`.
  - The primary key for the `sale_price` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `amount` on the `sale_price` table. All the data in the column will be lost.
  - You are about to drop the column `totalPrice` on the `sale_price` table. All the data in the column will be lost.
  - You are about to alter the column `finalPrice` on the `sale_price` table. The data in that column could be lost. The data in that column will be cast from `Decimal` to `Decimal(10,2)`.
  - A unique constraint covering the columns `[recipeId]` on the table `sale_price` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `unit` to the `ingredients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `ingredients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `recipes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `amountUsed` to the `recipes_ingredients` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unitUsed` to the `recipes_ingredients` table without a default value. This is not possible if the table is not empty.
  - The required column `id` was added to the `sale_price` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `value` to the `sale_price` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "unitCategory" AS ENUM ('KILOGRAMAS', 'GRAMAS', 'ML', 'LITROS', 'UNIDADE');

-- AlterEnum
BEGIN;
CREATE TYPE "saleMethod_new" AS ENUM ('PERCENTAGE', 'FIXED');
ALTER TABLE "sale_price" ALTER COLUMN "method" TYPE "saleMethod_new" USING ("method"::text::"saleMethod_new");
ALTER TYPE "saleMethod" RENAME TO "saleMethod_old";
ALTER TYPE "saleMethod_new" RENAME TO "saleMethod";
DROP TYPE "public"."saleMethod_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "ingredients" DROP CONSTRAINT "ingredients_createdBy_fkey";

-- DropForeignKey
ALTER TABLE "recipes" DROP CONSTRAINT "recipes_createdBy_fkey";

-- AlterTable
ALTER TABLE "ingredients" DROP COLUMN "category",
DROP COLUMN "createdBy",
ADD COLUMN     "unit" "unitCategory" NOT NULL,
ADD COLUMN     "userId" UUID NOT NULL,
ALTER COLUMN "description" DROP NOT NULL;

-- AlterTable
ALTER TABLE "recipes" DROP COLUMN "createdBy",
ADD COLUMN     "userId" UUID NOT NULL,
ALTER COLUMN "description" DROP NOT NULL;

-- AlterTable
ALTER TABLE "recipes_ingredients" DROP COLUMN "amount",
DROP COLUMN "category",
ADD COLUMN     "amountUsed" DECIMAL(10,3) NOT NULL,
ADD COLUMN     "unitUsed" "unitCategory" NOT NULL,
ALTER COLUMN "price" SET DATA TYPE DECIMAL(10,2);

-- AlterTable
ALTER TABLE "sale_price" DROP CONSTRAINT "sale_price_pkey",
DROP COLUMN "amount",
DROP COLUMN "totalPrice",
ADD COLUMN     "id" TEXT NOT NULL,
ADD COLUMN     "value" DECIMAL(10,2) NOT NULL,
ALTER COLUMN "finalPrice" SET DATA TYPE DECIMAL(10,2),
ADD CONSTRAINT "sale_price_pkey" PRIMARY KEY ("id");

-- DropEnum
DROP TYPE "IngredientCategory";

-- CreateIndex
CREATE UNIQUE INDEX "sale_price_recipeId_key" ON "sale_price"("recipeId");

-- AddForeignKey
ALTER TABLE "ingredients" ADD CONSTRAINT "ingredients_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recipes" ADD CONSTRAINT "recipes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
