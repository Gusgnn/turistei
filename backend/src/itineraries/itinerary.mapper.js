function toItineraryResponse(itinerary) {
  return {
    id: itinerary.id,
    usuarioId: itinerary.usuario_id,
    titulo: itinerary.titulo,
    descricao: itinerary.descricao,
    criadoEm: itinerary.criado_em,
  };
}

function toItineraryListResponse(itineraries) {
  return itineraries.map(toItineraryResponse);
}

function toPlaceResponse(place) {
  return {
    roteiroId: place.roteiro_id,
    localId: place.local_id,
    ordem: place.ordem,
    nome: place.nome,
    descricao: place.descricao,
    endereco: place.endereco,
    latitude: Number(place.latitude),
    longitude: Number(place.longitude),
    imagemPrincipal: place.imagem_principal,
  };
}

function toPlaceListResponse(places) {
  return places.map(toPlaceResponse);
}

module.exports = {
  toItineraryResponse,
  toItineraryListResponse,
  toPlaceResponse,
  toPlaceListResponse,
};