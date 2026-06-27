const ValidationError = require('../common/errors/ValidationError');

function validateNotificationId(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID inválido.'));
  }

  next();
}

function validateUserId(req, res, next) {
  const userId = Number(req.params.userId);

  if (Number.isNaN(userId) || userId <= 0) {
    return next(new ValidationError('Usuário inválido.'));
  }

  next();
}

function validateCreateNotification(req, res, next) {
  const { usuario_id, titulo, mensagem } = req.body || {};

  if (!usuario_id || !titulo || !mensagem) {
    return next(
      new ValidationError('Usuário, título e mensagem são obrigatórios.')
    );
  }

  next();
}

module.exports = {
  validateNotificationId,
  validateUserId,
  validateCreateNotification,
};