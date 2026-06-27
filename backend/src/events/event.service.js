const eventRepository = require('./event.repository');

async function getAllEvents() {
  return await eventRepository.findAll();
}

async function getEventById(id) {
  return await eventRepository.findById(id);
}

async function getUpcomingEvents() {
  return await eventRepository.findUpcoming();
}

async function getEventsByPlace(localId) {
  return await eventRepository.findByPlace(localId);
}

async function createEvent(event) {
  return await eventRepository.create(event);
}

async function updateEvent(id, event) {
  return await eventRepository.update(id, event);
}

async function deleteEvent(id) {
  return await eventRepository.remove(id);
}

module.exports = {
  getAllEvents,
  getEventById,
  getUpcomingEvents,
  getEventsByPlace,
  createEvent,
  updateEvent,
  deleteEvent,
};