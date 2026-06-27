/**
 * @swagger
 * tags:
 *   name: Notifications
 *   description: Gerenciamento de notificações
 */

const express = require('express');

const notificationController = require('./notification.controller');

const {
  validateNotificationId,
  validateUserId,
  validateCreateNotification,
} = require('./notification.validation');

const router = express.Router();

/**
 * @swagger
 * /api/notifications/user/{userId}:
 *   get:
 *     summary: Lista as notificações de um usuário
 *     tags: [Notifications]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de notificações.
 */

router.get(
  '/user/:userId',
  validateUserId,
  notificationController.getNotificationsByUser
);

/**
 * @swagger
 * /api/notifications:
 *   post:
 *     summary: Cria uma notificação
 *     tags: [Notifications]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Notification'
 *     responses:
 *       201:
 *         description: Notificação criada.
 */

router.post(
  '/',
  validateCreateNotification,
  notificationController.createNotification
);

/**
 * @swagger
 * /api/notifications/{id}/read:
 *   patch:
 *     summary: Marca uma notificação como lida
 *     tags: [Notifications]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Notificação marcada como lida.
 *       404:
 *         description: Notificação não encontrada.
 */

router.patch(
  '/:id/read',
  validateNotificationId,
  notificationController.markNotificationAsRead
);

/**
 * @swagger
 * /api/notifications/{id}:
 *   delete:
 *     summary: Remove uma notificação
 *     tags: [Notifications]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Notificação removida.
 *       404:
 *         description: Notificação não encontrada.
 */

router.delete(
  '/:id',
  validateNotificationId,
  notificationController.deleteNotification
);

module.exports = router;