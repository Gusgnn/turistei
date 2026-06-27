const reviewRepository = require('./review.repository');

async function getReviewsByPlace(localId) {
  return await reviewRepository.findByPlaceId(localId);
}

async function createReview(review) {
  const createdReview = await reviewRepository.create(review);

  await reviewRepository.updatePlaceAverage(review.local_id);

  return createdReview;
}

async function updateReview(id, review) {
  const oldReview = await reviewRepository.findById(id);

  if (!oldReview) {
    return null;
  }

  const updatedReview = await reviewRepository.update(id, review);

  await reviewRepository.updatePlaceAverage(oldReview.local_id);

  return updatedReview;
}

async function deleteReview(id) {
  const oldReview = await reviewRepository.findById(id);

  if (!oldReview) {
    return null;
  }

  const deletedReview = await reviewRepository.remove(id);

  await reviewRepository.updatePlaceAverage(oldReview.local_id);

  return deletedReview;
}

module.exports = {
  getReviewsByPlace,
  createReview,
  updateReview,
  deleteReview,
};