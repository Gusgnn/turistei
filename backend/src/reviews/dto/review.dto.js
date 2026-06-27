const { toNumber } = require('../../common/utils/parser');

function toCreateDTO(body) {
  return {
    usuario_id: toNumber(body.usuario_id),
    local_id: toNumber(body.local_id),
    nota: toNumber(body.nota),
    comentario: body.comentario?.trim() ?? null,
  };
}

function toUpdateDTO(body) {
  return {
    nota:
      body.nota !== undefined
        ? toNumber(body.nota)
        : undefined,

    comentario:
      body.comentario !== undefined
        ? body.comentario.trim()
        : undefined,
  };
}

module.exports = {
  toCreateDTO,
  toUpdateDTO,
};