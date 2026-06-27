const { toNumber } = require('../../common/utils/parser');

function toCreateDTO(body) {
  return {
    usuario_id: toNumber(body.usuario_id),
    titulo: body.titulo?.trim(),
    mensagem: body.mensagem?.trim(),
  };
}

module.exports = {
  toCreateDTO,
};