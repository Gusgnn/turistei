const placeService = require('./place.service');
const placeMapper = require('./place.mapper');
const placeDTO = require('./dto/place.dto');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getAllPlaces = asyncHandler(async (req, res) => {
  const places = await placeService.getAllPlaces();

  return res.json(
    ApiResponse.success(
      placeMapper.toPlaceListResponse(places)
    )
  );
});

const getPlaceById = asyncHandler(async (req, res) => {
  const place = await placeService.getPlaceById(req.params.id);

  if (!place) {
    throw new NotFoundError('Local não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      placeMapper.toPlaceResponse(place)
    )
  );
});

const getPopularPlaces = asyncHandler(async (req, res) => {
  const places = await placeService.getPopularPlaces();

  return res.json(
    ApiResponse.success(
      placeMapper.toPlaceListResponse(places)
    )
  );
});

const searchPlaces = asyncHandler(async (req, res) => {
  const places = await placeService.searchPlaces(req.query.q);

  return res.json(
    ApiResponse.success(
      placeMapper.toPlaceListResponse(places)
    )
  );
});

const getPlacesByCategory = asyncHandler(async (req, res) => {
  const places = await placeService.getPlacesByCategory(req.params.id);

  return res.json(
    ApiResponse.success(
      placeMapper.toPlaceListResponse(places)
    )
  );
});

const getNearbyPlaces = asyncHandler(async (req, res) => {
  const places = await placeService.getNearbyPlaces({
    lat: req.query.lat,
    lng: req.query.lng,
    radius: req.query.radius,
    limit: req.query.limit,
  });

  return res.json(
    ApiResponse.success(
      placeMapper.toPlaceListResponse(places)
    )
  );
});

const createPlace = asyncHandler(async (req, res) => {
  const dto = placeDTO.toCreateDTO(req.body);

  const place = await placeService.createPlace(dto);

  return res
    .status(201)
    .json(
      ApiResponse.success(
        placeMapper.toPlaceResponse(place),
        'Local cadastrado com sucesso.'
      )
    );
});

const updatePlace = asyncHandler(async (req, res) => {
  const dto = placeDTO.toUpdateDTO(req.body);

  const place = await placeService.updatePlace(req.params.id, dto);

  if (!place) {
    throw new NotFoundError('Local não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      placeMapper.toPlaceResponse(place),
      'Local atualizado com sucesso.'
    )
  );
});

const deletePlace = asyncHandler(async (req, res) => {
  const place = await placeService.deletePlace(req.params.id);

  if (!place) {
    throw new NotFoundError('Local não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Local removido com sucesso.'
    )
  );
});

module.exports = {
  getAllPlaces,
  getPlaceById,
  getPopularPlaces,
  searchPlaces,
  getPlacesByCategory,
  getNearbyPlaces,
  createPlace,
  updatePlace,
  deletePlace,
};