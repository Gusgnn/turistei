function toReviewResponse(review) {
  return {
    id: review.id,
    usuarioId: review.usuario_id,
    usuarioNome: review.usuario_nome ?? null,
    localId: review.local_id,
    nota: Number(review.nota),
    comentario: review.comentario,
    criadoEm: review.criado_em,
  };
}

function toReviewListResponse(reviews) {
  return reviews.map(toReviewResponse);
}

module.exports = {
  toReviewResponse,
  toReviewListResponse,
};