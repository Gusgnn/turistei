const ForbiddenError = require('../errors/ForbiddenError');

function adminMiddleware(req, res, next) {
  if (!req.user || req.user.tipo !== 'admin') {
    return next(
      new ForbiddenError(
        'Acesso restrito a administradores.'
      )
    );
  }

  next();
}

module.exports = adminMiddleware;