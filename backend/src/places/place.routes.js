/**
 * @swagger
 * tags:
 *   name: Places
 *   description: Gerenciamento de locais turísticos
 */


const express = require('express');

const placeController = require('./place.controller');

const {
  validatePlaceId,
  validateSearchQuery,
  validateCoordinates,
  validateCreatePlace,
} = require('./place.validation');

const router = express.Router();

/**
 * @swagger
 * /api/places:
 *   get:
 *     summary: Lista locais
 *     tags: [Places]
 *     responses:
 *       200:
 *         description: Lista de locais.
 */

router.get('/', placeController.getAllPlaces);

/**
 * @swagger
 * /api/places/popular:
 *   get:
 *     summary: Lista os locais mais populares
 *     tags: [Places]
 *     responses:
 *       200:
 *         description: Lista de locais populares.
 */

router.get('/popular', placeController.getPopularPlaces);

/**
 * @swagger
 * /api/places/search:
 *   get:
 *     summary: Busca locais por texto
 *     tags: [Places]
 *     parameters:
 *       - in: query
 *         name: q
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Resultado da busca.
 */

router.get(
  '/search',
  validateSearchQuery,
  placeController.searchPlaces
);

/**
 * @swagger
 * /api/places/nearby:
 *   get:
 *     summary: Busca locais próximos
 *     tags: [Places]
 *     parameters:
 *       - in: query
 *         name: lat
 *         required: true
 *         schema:
 *           type: number
 *       - in: query
 *         name: lng
 *         required: true
 *         schema:
 *           type: number
 *     responses:
 *       200:
 *         description: Locais próximos.
 */

router.get(
  '/nearby',
  validateCoordinates,
  placeController.getNearbyPlaces
);

/**
 * @swagger
 * /api/places/category/{id}:
 *   get:
 *     summary: Lista locais por categoria
 *     tags: [Places]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de locais da categoria.
 */

router.get(
  '/category/:id',
  validatePlaceId,
  placeController.getPlacesByCategory
);

/**
 * @swagger
 * /api/places/{id}:
 *   get:
 *     summary: Busca local por ID
 *     tags: [Places]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Local encontrado.
 */

router.get(
  '/:id',
  validatePlaceId,
  placeController.getPlaceById
);

/**
 * @swagger
 * /api/places:
 *   post:
 *     summary: Cria local
 *     tags: [Places]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Place'
 *     responses:
 *       201:
 *         description: Local criado.
 */

router.post(
  '/',
  validateCreatePlace,
  placeController.createPlace
);

/**
 * @swagger
 * /api/places/{id}:
 *   put:
 *     summary: Atualiza local
 *     tags: [Places]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Local atualizado.
 */

router.put(
  '/:id',
  validatePlaceId,
  placeController.updatePlace
);

/**
 * @swagger
 * /api/places/{id}:
 *   delete:
 *     summary: Remove local
 *     tags: [Places]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Local removido.
 */

router.delete(
  '/:id',
  validatePlaceId,
  placeController.deletePlace
);

module.exports = router;