const ValidationError = require('../common/errors/ValidationError');

function validateFavoriteId(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID inválido.'));
  }

  next();
}

function validateCreateFavorite(req, res, next) {
  const { usuario_id, local_id } = req.body || {};

  if (!usuario_id || !local_id) {
    return next(new ValidationError('Usuário e local são obrigatórios.'));
  }

  next();
}

function validateDeleteFavorite(req, res, next) {
  const usuarioId = Number(req.params.usuarioId);
  const localId = Number(req.params.localId);

  if (
    Number.isNaN(usuarioId) ||
    usuarioId <= 0 ||
    Number.isNaN(localId) ||
    localId <= 0
  ) {
    return next(new ValidationError('Usuário e local inválidos.'));
  }

  next();
}

module.exports = {
  validateFavoriteId,
  validateCreateFavorite,
  validateDeleteFavorite,
};