export type costInput = {
  quantidadeReal: number;
  quantidadeUtilizada: number;
  valorReal: number;
};

export function costCalculator(input: costInput) {
  const { quantidadeReal, quantidadeUtilizada, valorReal } = input;

  return (quantidadeUtilizada / quantidadeReal) * valorReal;
}