const ValidationError = require('../common/errors/ValidationError');

function validateReviewId(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID inválido.'));
  }

  next();
}

function validatePlaceId(req, res, next) {
  const localId = Number(req.params.localId);

  if (Number.isNaN(localId) || localId <= 0) {
    return next(new ValidationError('Local inválido.'));
  }

  next();
}

function validateCreateReview(req, res, next) {
  const { usuario_id, local_id, nota } = req.body || {};

  if (!usuario_id || !local_id || nota === undefined) {
    return next(new ValidationError('Usuário, local e nota são obrigatórios.'));
  }

  const notaNumber = Number(nota);

  if (Number.isNaN(notaNumber) || notaNumber < 1 || notaNumber > 5) {
    return next(new ValidationError('A nota deve estar entre 1 e 5.'));
  }

  next();
}

function validateUpdateReview(req, res, next) {
  const { nota } = req.body || {};

  if (nota !== undefined) {
    const notaNumber = Number(nota);

    if (Number.isNaN(notaNumber) || notaNumber < 1 || notaNumber > 5) {
      return next(new ValidationError('A nota deve estar entre 1 e 5.'));
    }
  }

  next();
}

module.exports = {
  validateReviewId,
  validatePlaceId,
  validateCreateReview,
  validateUpdateReview,
};