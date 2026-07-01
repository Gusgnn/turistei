const ValidationError = require('../common/errors/ValidationError');

function validateId(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID inválido.'));
  }

  next();
}

function validateUserId(req, res, next) {
  const id = Number(req.params.userId);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('Usuário inválido.'));
  }

  next();
}

function validateCreate(req, res, next) {
  const { usuario_id, titulo, nome } = req.body || {};

  if (!usuario_id || (!titulo && !nome)) {
    return next(
      new ValidationError('Usuário e título são obrigatórios.')
    );
  }

  next();
}

function validateAddPlace(req, res, next) {
  const { roteiro_id, local_id, ordem } = req.body || {};

  if (!roteiro_id || !local_id || ordem === undefined) {
    return next(
      new ValidationError('Roteiro, local e ordem são obrigatórios.')
    );
  }

  next();
}

function validateUpdatePlaceOrder(req, res, next) {
  const { roteiro_id, local_id, ordem } = req.body || {};

  const roteiroIdNumber = Number(roteiro_id);
  const localIdNumber = Number(local_id);
  const ordemNumber = Number(ordem);

  if (
    Number.isNaN(roteiroIdNumber) ||
    roteiroIdNumber <= 0 ||
    Number.isNaN(localIdNumber) ||
    localIdNumber <= 0 ||
    Number.isNaN(ordemNumber) ||
    ordemNumber <= 0
  ) {
    return next(
      new ValidationError('Roteiro, local ou ordem inválidos.')
    );
  }

  next();
}

function validateRemovePlace(req, res, next) {
  const roteiroId = Number(req.params.roteiroId);
  const localId = Number(req.params.localId);

  if (
    Number.isNaN(roteiroId) ||
    roteiroId <= 0 ||
    Number.isNaN(localId) ||
    localId <= 0
  ) {
    return next(new ValidationError('Roteiro ou local inválido.'));
  }

  next();
}

module.exports = {
  validateId,
  validateUserId,
  validateCreate,
  validateAddPlace,
  validateUpdatePlaceOrder,
  validateRemovePlace,
};