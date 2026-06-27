const ValidationError = require('../common/errors/ValidationError');

function validateLogin(req, res, next) {
  const { email, senha } = req.body || {};

  if (!email || !email.includes('@')) {
    return next(new ValidationError('E-mail inválido.'));
  }

  if (!senha || senha.length < 6) {
    return next(new ValidationError('Senha inválida.'));
  }

  next();
}

module.exports = {
  validateLogin,
};