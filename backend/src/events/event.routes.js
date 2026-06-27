/**
 * @swagger
 * tags:
 *   name: Events
 *   description: Gerenciamento de eventos
 */

const express = require('express');

const eventController = require('./event.controller');

const {
  validateEventId,
  validatePlaceId,
  validateCreateEvent,
  validateUpdateEvent,
} = require('./event.validation');

const router = express.Router();

/**
 * @swagger
 * /api/events:
 *   get:
 *     summary: Lista todos os eventos
 *     tags: [Events]
 *     responses:
 *       200:
 *         description: Lista de eventos.
 */

router.get('/', eventController.getAllEvents);

/**
 * @swagger
 * /api/events/upcoming:
 *   get:
 *     summary: Lista os próximos eventos
 *     tags: [Events]
 *     responses:
 *       200:
 *         description: Lista de próximos eventos.
 */

router.get('/upcoming', eventController.getUpcomingEvents);

/**
 * @swagger
 * /api/events/place/{localId}:
 *   get:
 *     summary: Lista eventos de um local
 *     tags: [Events]
 *     parameters:
 *       - in: path
 *         name: localId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de eventos do local.
 */

router.get(
  '/place/:localId',
  validatePlaceId,
  eventController.getEventsByPlace
);

/**
 * @swagger
 * /api/events/{id}:
 *   get:
 *     summary: Busca um evento pelo ID
 *     tags: [Events]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Evento encontrado.
 *       404:
 *         description: Evento não encontrado.
 */

router.get(
  '/:id',
  validateEventId,
  eventController.getEventById
);

/**
 * @swagger
 * /api/events:
 *   post:
 *     summary: Cria um evento
 *     tags: [Events]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Event'
 *     responses:
 *       201:
 *         description: Evento criado.
 */

router.post(
  '/',
  validateCreateEvent,
  eventController.createEvent
);

/**
 * @swagger
 * /api/events/{id}:
 *   put:
 *     summary: Atualiza um evento
 *     tags: [Events]
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
 *             $ref: '#/components/schemas/Event'
 *     responses:
 *       200:
 *         description: Evento atualizado.
 *       404:
 *         description: Evento não encontrado.
 */

router.put(
  '/:id',
  validateEventId,
  validateUpdateEvent,
  eventController.updateEvent
);

/**
 * @swagger
 * /api/events/{id}:
 *   delete:
 *     summary: Remove um evento
 *     tags: [Events]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Evento removido.
 *       404:
 *         description: Evento não encontrado.
 */

router.delete(
  '/:id',
  validateEventId,
  eventController.deleteEvent
);

module.exports = router;