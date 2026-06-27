const itineraryService = require('./itinerary.service');
const itineraryDTO = require('./dto/itinerary.dto');
const itineraryMapper = require('./itinerary.mapper');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getByUser = asyncHandler(async (req, res) => {
  const itineraries =
    await itineraryService.getItinerariesByUser(req.params.userId);

  return res.json(
    ApiResponse.success(
      itineraryMapper.toItineraryListResponse(itineraries)
    )
  );
});

const getById = asyncHandler(async (req, res) => {
  const itinerary =
    await itineraryService.getItineraryById(req.params.id);

  if (!itinerary) {
    throw new NotFoundError('Roteiro não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      itineraryMapper.toItineraryResponse(itinerary)
    )
  );
});

const getPlaces = asyncHandler(async (req, res) => {
  const places =
    await itineraryService.getPlacesByItinerary(req.params.id);

  return res.json(
    ApiResponse.success(
      itineraryMapper.toPlaceListResponse(places)
    )
  );
});

const create = asyncHandler(async (req, res) => {
  const dto = itineraryDTO.toCreateDTO(req.body);

  const itinerary =
    await itineraryService.createItinerary(dto);

  return res.status(201).json(
    ApiResponse.success(
      itineraryMapper.toItineraryResponse(itinerary),
      'Roteiro criado com sucesso.'
    )
  );
});

const update = asyncHandler(async (req, res) => {
  const dto = itineraryDTO.toUpdateDTO(req.body);

  const itinerary =
    await itineraryService.updateItinerary(req.params.id, dto);

  if (!itinerary) {
    throw new NotFoundError('Roteiro não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      itineraryMapper.toItineraryResponse(itinerary),
      'Roteiro atualizado com sucesso.'
    )
  );
});

const remove = asyncHandler(async (req, res) => {
  const itinerary =
    await itineraryService.deleteItinerary(req.params.id);

  if (!itinerary) {
    throw new NotFoundError('Roteiro não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Roteiro removido com sucesso.'
    )
  );
});

const addPlace = asyncHandler(async (req, res) => {
  const dto = itineraryDTO.toAddPlaceDTO(req.body);

  const place =
    await itineraryService.addPlace(dto);

  return res.status(201).json(
    ApiResponse.success(
      place,
      'Local adicionado ao roteiro.'
    )
  );
});

const removePlace = asyncHandler(async (req, res) => {
  const place =
    await itineraryService.removePlace(
      req.params.roteiroId,
      req.params.localId
    );

  if (!place) {
    throw new NotFoundError('Item não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Local removido do roteiro.'
    )
  );
});

module.exports = {
  getByUser,
  getById,
  getPlaces,
  create,
  update,
  remove,
  addPlace,
  removePlace,
};