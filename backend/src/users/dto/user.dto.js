function toCreateDTO(body) {
  return {
    nome: body.nome?.trim(),
    email: body.email?.trim().toLowerCase(),
    senha: body.senha,
    telefone: body.telefone?.trim() ?? null,
    tipo: body.tipo?.trim() ?? 'user',
  };
}

function toUpdateDTO(body) {
  return {
    nome:
      body.nome !== undefined
        ? body.nome.trim()
        : undefined,

    email:
      body.email !== undefined
        ? body.email.trim().toLowerCase()
        : undefined,

    telefone:
      body.telefone !== undefined
        ? body.telefone.trim()
        : undefined,

    tipo:
      body.tipo !== undefined
        ? body.tipo.trim()
        : undefined,
  };
}

module.exports = {
  toCreateDTO,
  toUpdateDTO,
};