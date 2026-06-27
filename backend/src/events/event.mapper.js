function toEventResponse(event) {
  return {
    id: event.id,
    localId: event.local_id,
    titulo: event.titulo,
    descricao: event.descricao,
    dataEvento: event.data_evento,
    horario: event.horario,
    criadoEm: event.criado_em,
    local: event.local_nome
      ? {
          nome: event.local_nome,
          endereco: event.local_endereco,
        }
      : null,
  };
}

function toEventListResponse(events) {
  return events.map(toEventResponse);
}

module.exports = {
  toEventResponse,
  toEventListResponse,
};