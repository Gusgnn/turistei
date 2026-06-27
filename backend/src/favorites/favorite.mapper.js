function toFavoriteResponse(favorite) {
  return {
    usuarioId: favorite.usuario_id,
    localId: favorite.local_id,
    criadoEm: favorite.criado_em,
    local: favorite.nome
      ? {
          nome: favorite.nome,
          descricao: favorite.descricao,
          endereco: favorite.endereco,
          latitude: Number(favorite.latitude),
          longitude: Number(favorite.longitude),
          imagemPrincipal: favorite.imagem_principal,
          avaliacaoMedia: Number(favorite.avaliacao_media),
        }
      : null,
  };
}

function toFavoriteListResponse(favorites) {
  return favorites.map(toFavoriteResponse);
}

module.exports = {
  toFavoriteResponse,
  toFavoriteListResponse,
};