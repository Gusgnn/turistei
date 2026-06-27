const ValidationError = require('../common/errors/ValidationError');

function validatePlaceId(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID inválido.'));
  }

  next();
}

function validateSearchQuery(req, res, next) {
  const { q } = req.query;

  if (!q || q.trim().length < 2) {
    return next(
      new ValidationError('Informe pelo menos 2 caracteres para pesquisar.')
    );
  }

  next();
}

function validateCoordinates(req, res, next) {
  const lat = Number(req.query.lat);
  const lng = Number(req.query.lng);

  if (Number.isNaN(lat) || Number.isNaN(lng)) {
    return next(new ValidationError('Latitude e longitude inválidas.'));
  }

  next();
}

function validateCreatePlace(req, res, next) {
  const body = req.body || {};

  const {
    categoria_id,
    nome,
    endereco,
    latitude,
    longitude,
  } = body;

  if (
    !categoria_id ||
    !nome ||
    !endereco ||
    latitude === undefined ||
    longitude === undefined
  ) {
    return next(new ValidationError('Campos obrigatórios não informados.'));
  }

  next();
}

function validateUpdatePlace(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID inválido.'));
  }

  next();
}

module.exports = {
  validatePlaceId,
  validateSearchQuery,
  validateCoordinates,
  validateCreatePlace,
  validateUpdatePlace,
};