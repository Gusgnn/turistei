function toCategoryResponse(category) {
  return {
    id: category.id,
    nome: category.nome,
    icone: category.icone,
    cor: category.cor,
  };
}

function toCategoryListResponse(categories) {
  return categories.map(toCategoryResponse);
}

module.exports = {
  toCategoryResponse,
  toCategoryListResponse,
};