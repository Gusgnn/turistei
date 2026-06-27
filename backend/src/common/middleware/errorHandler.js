const AppError = require('../errors/AppError');
const ApiResponse = require('../responses/apiResponse');

function errorHandler(err, req, res, next) {
  if (process.env.NODE_ENV !== 'test') {
    console.error('==============================');
    console.error(err.stack);
    console.error('==============================');
  }

  if (err instanceof AppError) {
    return res
      .status(err.statusCode)
      .json(ApiResponse.error(err.message));
  }

  return res
    .status(500)
    .json(ApiResponse.error('Erro interno do servidor.'));
}

module.exports = errorHandler;