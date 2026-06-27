const placeRepository = require('./place.repository');
const { calculateDistance } = require('../utils/distance');
const ValidationError = require('../common/errors/ValidationError');

async function getAllPlaces() {
  return await placeRepository.findAll();
}

async function getPlaceById(id) {
  return await placeRepository.findById(id);
}

async function getPopularPlaces() {
  return await placeRepository.findPopular();
}

async function searchPlaces(query) {
  return await placeRepository.searchByName(query);
}

async function getPlacesByCategory(categoryId) {
  return await placeRepository.findByCategory(categoryId);
}

async function getNearbyPlaces({ lat, lng, radius = 10, limit = 20 }) {
  const latitude = Number(lat);
  const longitude = Number(lng);
  const searchRadius = Number(radius);
  const resultLimit = Number(limit);

  if (
    Number.isNaN(latitude) ||
    Number.isNaN(longitude) ||
    Number.isNaN(searchRadius) ||
    Number.isNaN(resultLimit)
  ) {
    throw new ValidationError('Parâmetros de localização inválidos.');
  }

  const places = await placeRepository.findAllWithCoordinates();

  return places
    .map((place) => {
      const distance = calculateDistance(
        latitude,
        longitude,
        Number(place.latitude),
        Number(place.longitude)
      );

      return {
        ...place,
        distancia: Number(distance.toFixed(2)),
      };
    })
    .filter((place) => place.distancia <= searchRadius)
    .sort((a, b) => a.distancia - b.distancia)
    .slice(0, resultLimit);
}

async function createPlace(place) {
  return await placeRepository.create(place);
}

async function updatePlace(id, place) {
  return await placeRepository.update(id, place);
}

async function deletePlace(id) {
  return await placeRepository.remove(id);
}

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