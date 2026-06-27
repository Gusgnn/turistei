const authService = require('./auth.service');
const authDTO = require('./dto/auth.dto');
const authMapper = require('./auth.mapper');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');

const login = asyncHandler(async (req, res) => {
  const dto = authDTO.toLoginDTO(req.body);

  const { user, token } = await authService.login(dto);

  return res.json(
    ApiResponse.success(
      authMapper.toAuthResponse(user, token),
      'Login realizado com sucesso.'
    )
  );
});

module.exports = {
  login,
};