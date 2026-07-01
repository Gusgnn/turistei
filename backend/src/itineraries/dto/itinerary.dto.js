const { toNumber } = require('../../common/utils/parser');

function toCreateDTO(body) {
  return {
    usuario_id: toNumber(body.usuario_id),
    titulo: body.titulo?.trim() || body.nome?.trim(),
    descricao: body.descricao?.trim() ?? null,
  };
}

function toUpdateDTO(body) {
  return {
    titulo:
      body.titulo !== undefined
        ? body.titulo.trim()
        : body.nome !== undefined
          ? body.nome.trim()
          : undefined,

    descricao:
      body.descricao !== undefined
        ? body.descricao.trim()
        : undefined,
  };
}

function toAddPlaceDTO(body) {
  return {
    roteiro_id: toNumber(body.roteiro_id),
    local_id: toNumber(body.local_id),
    ordem: toNumber(body.ordem),
  };
}

function toUpdatePlaceOrderDTO(body) {
  return {
    roteiro_id: toNumber(body.roteiro_id),
    local_id: toNumber(body.local_id),
    ordem: toNumber(body.ordem),
  };
}

module.exports = {
  toCreateDTO,
  toUpdateDTO,
  toAddPlaceDTO,
  toUpdatePlaceOrderDTO,
};