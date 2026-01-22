export type dataToConvert = {
  category: "KILOGRAMAS" | "GRAMAS" | "LITROS" | "ML" | "UNIDADE";
  amount: number;
};

export function unitConversion(data: dataToConvert) {
  const { category, amount } = data;

  if (["KILOGRAMAS", "LITROS"].includes(category)) {
    return amount * 1000;
  }

  return amount;
}
