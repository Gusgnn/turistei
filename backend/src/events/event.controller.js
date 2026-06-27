const eventService = require('./event.service');
const eventDTO = require('./dto/event.dto');
const eventMapper = require('./event.mapper');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getAllEvents = asyncHandler(async (req, res) => {
  const events = await eventService.getAllEvents();

  return res.json(
    ApiResponse.success(
      eventMapper.toEventListResponse(events)
    )
  );
});

const getEventById = asyncHandler(async (req, res) => {
  const event = await eventService.getEventById(req.params.id);

  if (!event) {
    throw new NotFoundError('Evento não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      eventMapper.toEventResponse(event)
    )
  );
});

const getUpcomingEvents = asyncHandler(async (req, res) => {
  const events = await eventService.getUpcomingEvents();

  return res.json(
    ApiResponse.success(
      eventMapper.toEventListResponse(events)
    )
  );
});

const getEventsByPlace = asyncHandler(async (req, res) => {
  const events = await eventService.getEventsByPlace(req.params.localId);

  return res.json(
    ApiResponse.success(
      eventMapper.toEventListResponse(events)
    )
  );
});

const createEvent = asyncHandler(async (req, res) => {
  const dto = eventDTO.toCreateDTO(req.body);

  const event = await eventService.createEvent(dto);

  return res.status(201).json(
    ApiResponse.success(
      eventMapper.toEventResponse(event),
      'Evento criado com sucesso.'
    )
  );
});

const updateEvent = asyncHandler(async (req, res) => {
  const dto = eventDTO.toUpdateDTO(req.body);

  const event = await eventService.updateEvent(req.params.id, dto);

  if (!event) {
    throw new NotFoundError('Evento não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      eventMapper.toEventResponse(event),
      'Evento atualizado com sucesso.'
    )
  );
});

const deleteEvent = asyncHandler(async (req, res) => {
  const event = await eventService.deleteEvent(req.params.id);

  if (!event) {
    throw new NotFoundError('Evento não encontrado.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Evento removido com sucesso.'
    )
  );
});

module.exports = {
  getAllEvents,
  getEventById,
  getUpcomingEvents,
  getEventsByPlace,
  createEvent,
  updateEvent,
  deleteEvent,
};