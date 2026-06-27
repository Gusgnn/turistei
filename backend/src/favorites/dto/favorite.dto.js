const { toNumber } = require('../../common/utils/parser');

function toCreateDTO(body) {
  return {
    usuario_id: toNumber(body.usuario_id),
    local_id: toNumber(body.local_id),
  };
}

module.exports = {
  toCreateDTO,
};