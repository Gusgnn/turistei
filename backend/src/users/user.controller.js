const userService = require('./user.service');
const userMapper = require('./user.mapper');
const userDTO = require('./dto/user.dto');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getAllUsers = asyncHandler(async (req, res) => {
  const users = await userService.getAllUsers();

  return res.json(
    ApiResponse.success(
      userMapper.toUserListResponse(users)
    )
  );
});

const getUserById = asyncHandler(async (req, res) => {
  const user = await userService.getUserById(req.params.id);

  if (!user) {
    throw new NotFoundError('Usuário não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      userMapper.toUserResponse(user)
    )
  );
});

const createUser = asyncHandler(async (req, res) => {
  const dto = userDTO.toCreateDTO(req.body);

  const user = await userService.createUser(dto);

  return res
    .status(201)
    .json(
      ApiResponse.success(
        userMapper.toUserResponse(user),
        'Usuário criado com sucesso.'
      )
    );
});

const updateUser = asyncHandler(async (req, res) => {
  const dto = userDTO.toUpdateDTO(req.body);

  const user = await userService.updateUser(req.params.id, dto);

  if (!user) {
    throw new NotFoundError('Usuário não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      userMapper.toUserResponse(user),
      'Usuário atualizado com sucesso.'
    )
  );
});

const deleteUser = asyncHandler(async (req, res) => {
  const user = await userService.deleteUser(req.params.id);

  if (!user) {
    throw new NotFoundError('Usuário não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Usuário removido com sucesso.'
    )
  );
});

module.exports = {
  getAllUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
};