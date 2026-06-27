/**
 * @swagger
 * tags:
 *   name: Itineraries
 *   description: Gerenciamento de roteiros
 */

const express = require('express');

const controller = require('./itinerary.controller');

const {
  validateId,
  validateUserId,
  validateCreate,
  validateAddPlace,
  validateRemovePlace,
} = require('./itinerary.validation');

const router = express.Router();
/**
 * @swagger
 * /api/itineraries/user/{userId}:
 *   get:
 *     summary: Lista os roteiros de um usuário
 *     tags: [Itineraries]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de roteiros.
 */

router.get('/user/:userId', validateUserId, controller.getByUser);

/**
 * @swagger
 * /api/itineraries/{id}:
 *   get:
 *     summary: Busca um roteiro pelo ID
 *     tags: [Itineraries]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Roteiro encontrado.
 *       404:
 *         description: Roteiro não encontrado.
 */

router.get('/:id/places', validateId, controller.getPlaces);

/**
 * @swagger
 * /api/itineraries/{id}/places:
 *   get:
 *     summary: Lista os locais de um roteiro
 *     tags: [Itineraries]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de locais do roteiro.
 */

router.get('/:id', validateId, controller.getById);

/**
 * @swagger
 * /api/itineraries:
 *   post:
 *     summary: Cria um roteiro
 *     tags: [Itineraries]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Itinerary'
 *     responses:
 *       201:
 *         description: Roteiro criado.
 */

router.post('/', validateCreate, controller.create);

/**
 * @swagger
 * /api/itineraries/places:
 *   post:
 *     summary: Adiciona um local ao roteiro
 *     tags: [Itineraries]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - roteiro_id
 *               - local_id
 *               - ordem
 *             properties:
 *               roteiro_id:
 *                 type: integer
 *                 example: 1
 *               local_id:
 *                 type: integer
 *                 example: 1
 *               ordem:
 *                 type: integer
 *                 example: 1
 *     responses:
 *       201:
 *         description: Local adicionado ao roteiro.
 */

router.post('/places', validateAddPlace, controller.addPlace);

/**
 * @swagger
 * /api/itineraries/{id}:
 *   put:
 *     summary: Atualiza um roteiro
 *     tags: [Itineraries]
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
 *             $ref: '#/components/schemas/Itinerary'
 *     responses:
 *       200:
 *         description: Roteiro atualizado.
 *       404:
 *         description: Roteiro não encontrado.
 */

router.put('/:id', validateId, controller.update);

/**
 * @swagger
 * /api/itineraries/{id}:
 *   delete:
 *     summary: Remove um roteiro
 *     tags: [Itineraries]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Roteiro removido.
 *       404:
 *         description: Roteiro não encontrado.
 */

router.delete('/:id', validateId, controller.remove);

/**
 * @swagger
 * /api/itineraries/{roteiroId}/places/{localId}:
 *   delete:
 *     summary: Remove um local do roteiro
 *     tags: [Itineraries]
 *     parameters:
 *       - in: path
 *         name: roteiroId
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
 *         description: Local removido do roteiro.
 *       404:
 *         description: Item não encontrado.
 */

router.delete(
  '/:roteiroId/places/:localId',
  validateRemovePlace,
  controller.removePlace
);

module.exports = router;