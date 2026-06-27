const reviewService = require('./review.service');
const reviewDTO = require('./dto/review.dto');
const reviewMapper = require('./review.mapper');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getReviewsByPlace = asyncHandler(async (req, res) => {
  const reviews = await reviewService.getReviewsByPlace(req.params.localId);

  return res.json(
    ApiResponse.success(
      reviewMapper.toReviewListResponse(reviews)
    )
  );
});

const createReview = asyncHandler(async (req, res) => {
  const dto = reviewDTO.toCreateDTO(req.body);

  const review = await reviewService.createReview(dto);

  return res.status(201).json(
    ApiResponse.success(
      reviewMapper.toReviewResponse(review),
      'Avaliação criada com sucesso.'
    )
  );
});

const updateReview = asyncHandler(async (req, res) => {
  const dto = reviewDTO.toUpdateDTO(req.body);

  const review = await reviewService.updateReview(req.params.id, dto);

  if (!review) {
    throw new NotFoundError('Avaliação não encontrada.');
  }

  return res.json(
    ApiResponse.success(
      reviewMapper.toReviewResponse(review),
      'Avaliação atualizada com sucesso.'
    )
  );
});

const deleteReview = asyncHandler(async (req, res) => {
  const review = await reviewService.deleteReview(req.params.id);

  if (!review) {
    throw new NotFoundError('Avaliação não encontrada.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Avaliação removida com sucesso.'
    )
  );
});

module.exports = {
  getReviewsByPlace,
  createReview,
  updateReview,
  deleteReview,
};