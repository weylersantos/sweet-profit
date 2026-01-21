/*
  Warnings:

  - Changed the type of `method` on the `sale_price` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "saleMethod" AS ENUM ('MARGEM', 'VALOR_FIXO');

-- AlterTable
ALTER TABLE "sale_price" DROP COLUMN "method",
ADD COLUMN     "method" "saleMethod" NOT NULL;

-- DropEnum
DROP TYPE "SaleMethod";
