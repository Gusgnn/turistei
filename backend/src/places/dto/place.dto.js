const { toNumber } = require('../../common/utils/parser');
function toCreateDTO(body) {
  return {
    categoria_id: toNumber(body.categoria_id),

    nome: body.nome?.trim(),

    descricao: body.descricao?.trim() ?? '',

    endereco: body.endereco?.trim(),

    latitude: toNumber(body.latitude),

    longitude: toNumber(body.longitude),

    horario_funcionamento:
      body.horario_funcionamento?.trim() ?? null,

    valor_entrada:
      body.valor_entrada?.trim() ?? 'Gratuito',

    imagem_principal:
      body.imagem_principal?.trim() ?? null,
  };
}

function toUpdateDTO(body) {
  return {
    categoria_id:
      body.categoria_id !== undefined
        ? toNumber(body.categoria_id)
        : undefined,

    nome:
      body.nome !== undefined
        ? body.nome.trim()
        : undefined,

    descricao:
      body.descricao !== undefined
        ? body.descricao.trim()
        : undefined,

    endereco:
      body.endereco !== undefined
        ? body.endereco.trim()
        : undefined,

    latitude:
      body.latitude !== undefined
        ? toNumber(body.latitude)
        : undefined,

    longitude:
      body.longitude !== undefined
        ? toNumber(body.longitude)
        : undefined,

    horario_funcionamento:
      body.horario_funcionamento !== undefined
        ? body.horario_funcionamento.trim()
        : undefined,

    valor_entrada:
      body.valor_entrada !== undefined
        ? body.valor_entrada.trim()
        : undefined,

    imagem_principal:
      body.imagem_principal !== undefined
        ? body.imagem_principal.trim()
        : undefined,
  };
}

module.exports = {
  toCreateDTO,
  toUpdateDTO,
};