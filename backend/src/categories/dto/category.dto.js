function toCreateDTO(body) {
  return {
    nome: body.nome?.trim(),
    icone: body.icone?.trim() ?? null,
    cor: body.cor?.trim() ?? null,
  };
}

function toUpdateDTO(body) {
  return {
    nome: body.nome !== undefined ? body.nome.trim() : undefined,
    icone: body.icone !== undefined ? body.icone.trim() : undefined,
    cor: body.cor !== undefined ? body.cor.trim() : undefined,
  };
}

module.exports = {
  toCreateDTO,
  toUpdateDTO,
};