const itineraryRepository = require('./itinerary.repository');

async function getItinerariesByUser(userId) {
  return await itineraryRepository.findByUserId(userId);
}

async function getItineraryById(id) {
  return await itineraryRepository.findById(id);
}

async function getPlacesByItinerary(id) {
  return await itineraryRepository.findPlacesByItineraryId(id);
}

async function createItinerary(itinerary) {
  return await itineraryRepository.create(itinerary);
}

async function updateItinerary(id, itinerary) {
  return await itineraryRepository.update(id, itinerary);
}

async function deleteItinerary(id) {
  return await itineraryRepository.remove(id);
}

async function addPlace(data) {
  return await itineraryRepository.addPlace(data);
}

async function removePlace(roteiroId, localId) {
  return await itineraryRepository.removePlace(roteiroId, localId);
}

module.exports = {
  getItinerariesByUser,
  getItineraryById,
  getPlacesByItinerary,
  createItinerary,
  updateItinerary,
  deleteItinerary,
  addPlace,
  removePlace,
};