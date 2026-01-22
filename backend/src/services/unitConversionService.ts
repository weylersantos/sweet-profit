export type dataToConvert = {
  unit: "KILOGRAMAS" | "GRAMAS" | "LITROS" | "ML" | "UNIDADE";
  amount: number;
};

export function unitConversion(data: dataToConvert) {
  const { unit, amount } = data;

  if (["KILOGRAMAS", "LITROS"].includes(unit)) {
    return amount * 1000;
  }

  return amount;
}
