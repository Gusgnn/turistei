const jwt = require('jsonwebtoken');

const UnauthorizedError = require('../errors/UnauthorizedError');

function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return next(
      new UnauthorizedError('Token não informado.')
    );
  }

  const parts = authHeader.split(' ');

  if (parts.length !== 2) {
    return next(
      new UnauthorizedError('Token inválido.')
    );
  }

  const [scheme, token] = parts;

  if (!/^Bearer$/i.test(scheme)) {
    return next(
      new UnauthorizedError('Formato do token inválido.')
    );
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    req.user = {
      id: decoded.id,
      email: decoded.email,
      tipo: decoded.tipo,
    };

    return next();
  } catch (error) {
    return next(
      new UnauthorizedError('Token inválido ou expirado.')
    );
  }
}

module.exports = authMiddleware;