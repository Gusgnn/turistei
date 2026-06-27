const favoriteRepository = require('./favorite.repository');

async function getFavoritesByUser(userId) {
  return await favoriteRepository.findByUserId(userId);
}

async function createFavorite(favorite) {
  return await favoriteRepository.create(favorite);
}

async function deleteFavorite(usuarioId, localId) {
  return await favoriteRepository.remove(usuarioId, localId);
}

module.exports = {
  getFavoritesByUser,
  createFavorite,
  deleteFavorite,
};