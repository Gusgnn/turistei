const express = require('express');

const authController = require('./auth.controller');

const {
  validateLogin,
} = require('./auth.validation');

const router = express.Router();

/**
 * @swagger
 * tags:
 *   name: Auth
 *   description: Autenticação
 */

/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: Realiza login
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - senha
 *             properties:
 *               email:
 *                 type: string
 *                 example: admin@email.com
 *               senha:
 *                 type: string
 *                 example: 123456
 *     responses:
 *       200:
 *         description: Login realizado com sucesso.
 *       401:
 *         description: Email ou senha inválidos.
 */

router.post(
  '/login',
  validateLogin,
  authController.login
);

module.exports = router;