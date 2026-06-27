const ValidationError = require('../common/errors/ValidationError');

function validateUserId(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID do usuário inválido.'));
  }

  next();
}

function validateCreateUser(req, res, next) {
  const body = req.body || {};

  const {
    nome,
    email,
    senha,
  } = body;

  if (!nome || nome.trim().length < 3) {
    return next(new ValidationError('Nome é obrigatório.'));
  }

  if (!email || !email.includes('@')) {
    return next(new ValidationError('E-mail inválido.'));
  }

  if (!senha || senha.length < 6) {
    return next(
      new ValidationError(
        'A senha deve possuir pelo menos 6 caracteres.'
      )
    );
  }

  next();
}

function validateUpdateUser(req, res, next) {
  const id = Number(req.params.id);

  if (Number.isNaN(id) || id <= 0) {
    return next(new ValidationError('ID do usuário inválido.'));
  }

  next();
}

module.exports = {
  validateUserId,
  validateCreateUser,
  validateUpdateUser,
};