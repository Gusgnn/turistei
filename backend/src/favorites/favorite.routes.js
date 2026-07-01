/**
 * @swagger
 * tags:
 *   name: Favorites
 *   description: Gerenciamento de favoritos
 */

const express = require('express');

const favoriteController = require('./favorite.controller');
const authMiddleware = require('../common/middleware/authMiddleware');

const {
  validateFavoriteId,
  validateCreateFavorite,
  validateDeleteFavorite,
} = require('./favorite.validation');

const router = express.Router();

router.get(
  '/me',
  authMiddleware,
  favoriteController.getMyFavorites
);

/**
 * @swagger
 * /api/favorites/user/{id}:
 *   get:
 *     summary: Lista os favoritos de um usuário
 *     tags: [Favorites]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de favoritos.
 *       404:
 *         description: Usuário não encontrado.
 */

router.get(
  '/user/:id',
  validateFavoriteId,
  favoriteController.getFavoritesByUser
);

/**
 * @swagger
 * /api/favorites:
 *   post:
 *     summary: Adiciona um local aos favoritos
 *     tags: [Favorites]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - usuario_id
 *               - local_id
 *             properties:
 *               usuario_id:
 *                 type: integer
 *                 example: 16
 *               local_id:
 *                 type: integer
 *                 example: 1
 *     responses:
 *       201:
 *         description: Favorito criado com sucesso.
 */

router.post(
  '/',
  validateCreateFavorite,
  favoriteController.createFavorite
);

/**
 * @swagger
 * /api/favorites/user/{usuarioId}/place/{localId}:
 *   delete:
 *     summary: Remove um favorito
 *     tags: [Favorites]
 *     parameters:
 *       - in: path
 *         name: usuarioId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: localId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Favorito removido com sucesso.
 *       404:
 *         description: Favorito não encontrado.
 */

router.delete(
  '/user/:usuarioId/place/:localId',
  validateDeleteFavorite,
  favoriteController.deleteFavorite
);

module.exports = router;