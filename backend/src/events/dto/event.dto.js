const { toNumber } = require('../../common/utils/parser');

function toCreateDTO(body) {
  return {
    local_id: toNumber(body.local_id),
    titulo: body.titulo?.trim(),
    descricao: body.descricao?.trim() ?? null,
    data_evento: body.data_evento,
    horario: body.horario?.trim() ?? null,
  };
}

function toUpdateDTO(body) {
  return {
    local_id:
      body.local_id !== undefined
        ? toNumber(body.local_id)
        : undefined,

    titulo:
      body.titulo !== undefined
        ? body.titulo.trim()
        : undefined,

    descricao:
      body.descricao !== undefined
        ? body.descricao.trim()
        : undefined,

    data_evento:
      body.data_evento !== undefined
        ? body.data_evento
        : undefined,

    horario:
      body.horario !== undefined
        ? body.horario.trim()
        : undefined,
  };
}

module.exports = {
  toCreateDTO,
  toUpdateDTO,
};