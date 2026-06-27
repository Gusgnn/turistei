const favoriteService = require('./favorite.service');
const favoriteDTO = require('./dto/favorite.dto');
const favoriteMapper = require('./favorite.mapper');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getFavoritesByUser = asyncHandler(async (req, res) => {
  const favorites = await favoriteService.getFavoritesByUser(req.params.id);

  return res.json(
    ApiResponse.success(
      favoriteMapper.toFavoriteListResponse(favorites)
    )
  );
});

const createFavorite = asyncHandler(async (req, res) => {
  const dto = favoriteDTO.toCreateDTO(req.body);

  const favorite = await favoriteService.createFavorite(dto);

  return res.status(201).json(
    ApiResponse.success(
      favoriteMapper.toFavoriteResponse(favorite),
      'Favorito criado com sucesso.'
    )
  );
});

const deleteFavorite = asyncHandler(async (req, res) => {
  const favorite = await favoriteService.deleteFavorite(
    req.params.usuarioId,
    req.params.localId
  );

  if (!favorite) {
    throw new NotFoundError('Favorito não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Favorito removido com sucesso.'
    )
  );
});

module.exports = {
  getFavoritesByUser,
  createFavorite,
  deleteFavorite,
};