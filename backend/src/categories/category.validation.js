function validateCategoryId(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return res.status(400).json({
      success: false,
      message: 'ID da categoria inválido.',
    });
  }

  next();
}

function validateCreateCategory(req, res, next) {
  const body = req.body || {};
  const { nome } = body;

  if (!nome || nome.trim().length < 2) {
    return res.status(400).json({
      success: false,
      message: 'Nome da categoria é obrigatório.',
    });
  }

  next();
}

module.exports = {
  validateCategoryId,
  validateCreateCategory,
};