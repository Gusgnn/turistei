function toPlaceResponse(place) {
  return {
    id: place.id,
    categoriaId: place.categoria_id,
    nome: place.nome,
    descricao: place.descricao,
    endereco: place.endereco,
    latitude: Number(place.latitude),
    longitude: Number(place.longitude),
    horarioFuncionamento: place.horario_funcionamento,
    valorEntrada: place.valor_entrada,
    avaliacaoMedia: Number(place.avaliacao_media),
    imagemPrincipal: place.imagem_principal,
    categoria: place.categoria,
    distancia: place.distancia ?? null,
  };
}

function toPlaceListResponse(places) {
  return places.map(toPlaceResponse);
}

module.exports = {
  toPlaceResponse,
  toPlaceListResponse,
};