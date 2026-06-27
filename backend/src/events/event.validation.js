const ValidationError = require('../common/errors/ValidationError');

function validateEventId(req, res, next) {
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

function validateCreateEvent(req, res, next) {
  const { local_id, titulo, data_evento } = req.body || {};

  if (!local_id || !titulo || !data_evento) {
    return next(
      new ValidationError('Local, título e data do evento são obrigatórios.')
    );
  }

  next();
}

function validateUpdateEvent(req, res, next) {
  const body = req.body || {};

  if (body.local_id !== undefined) {
    const localId = Number(body.local_id);

    if (Number.isNaN(localId) || localId <= 0) {
      return next(new ValidationError('Local inválido.'));
    }
  }

  next();
}

module.exports = {
  validateEventId,
  validatePlaceId,
  validateCreateEvent,
  validateUpdateEvent,
};