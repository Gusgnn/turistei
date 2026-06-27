/**
 * @swagger
 * tags:
 *   name: Reviews
 *   description: Gerenciamento de avaliações
 */

const express = require('express');

const reviewController = require('./review.controller');

const {
  validateReviewId,
  validatePlaceId,
  validateCreateReview,
  validateUpdateReview,
} = require('./review.validation');

const router = express.Router();

/**
 * @swagger
 * /api/reviews/place/{localId}:
 *   get:
 *     summary: Lista avaliações de um local
 *     tags: [Reviews]
 *     parameters:
 *       - in: path
 *         name: localId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de avaliações.
 */

router.get(
  '/place/:localId',
  validatePlaceId,
  reviewController.getReviewsByPlace
);

/**
 * @swagger
 * /api/reviews:
 *   post:
 *     summary: Cria uma avaliação
 *     tags: [Reviews]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Review'
 *     responses:
 *       201:
 *         description: Avaliação criada.
 */

router.post(
  '/',
  validateCreateReview,
  reviewController.createReview
);

/**
 * @swagger
 * /api/reviews/{id}:
 *   put:
 *     summary: Atualiza uma avaliação
 *     tags: [Reviews]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Review'
 *     responses:
 *       200:
 *         description: Avaliação atualizada.
 *       404:
 *         description: Avaliação não encontrada.
 */

router.put(
  '/:id',
  validateReviewId,
  validateUpdateReview,
  reviewController.updateReview
);

/**
 * @swagger
 * /api/reviews/{id}:
 *   delete:
 *     summary: Remove uma avaliação
 *     tags: [Reviews]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Avaliação removida.
 *       404:
 *         description: Avaliação não encontrada.
 */

router.delete(
  '/:id',
  validateReviewId,
  reviewController.deleteReview
);

module.exports = router;