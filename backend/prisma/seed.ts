import { Prisma, PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

const userMock: Prisma.userCreateManyInput[] = [
  {
    id: "09dc50f5-aed0-48b2-aa03-445da3fa773d",
    name: "teste",
    email: "teste@teste.com",
    password: "teste",
  },
  {
    id: "3bddbb9f-657e-4568-9ff8-073c25c698f5",
    name: "Weyler Santos",
    email: "weyler@teste.com",
    password: "weyler",
  },
];

async function main() {
  console.log(`🌱 Iniciando seed...`);
  console.log("Limpando a tabela de agentes, usuarios e conversation");

  await prisma.user.deleteMany();

  console.log("Inserindo um usuário na tabela");

  await prisma.user.createMany({
    data: userMock,
    skipDuplicates: true,
  });

  console.log("✅ Seed finalizado com sucesso");
}

main()
  .catch((e) => {
    console.error("Erro durante o seeding: ", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
