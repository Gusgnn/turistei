/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Gerenciamento de usuários
 */

const express = require('express');

const userController = require('./user.controller');

const {
  validateUserId,
  validateCreateUser,
  validateUpdateUser,
} = require('./user.validation');

const router = express.Router();

/**
 * @swagger
 * /api/users:
 *   get:
 *     summary: Lista todos os usuários
 *     tags: [Users]
 *     responses:
 *       200:
 *         description: Lista de usuários.
 */

router.get(
  '/',
  userController.getAllUsers
);

/**
 * @swagger
 * /api/users/{id}:
 *   get:
 *     summary: Busca um usuário pelo ID
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Usuário encontrado.
 *       404:
 *         description: Usuário não encontrado.
 */

router.get(
  '/:id',
  validateUserId,
  userController.getUserById
);

/**
 * @swagger
 * /api/users:
 *   post:
 *     summary: Cria um usuário
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - nome
 *               - email
 *               - senha
 *             properties:
 *               nome:
 *                 type: string
 *                 example: Gustavo Neumann
 *               email:
 *                 type: string
 *                 example: gustavo@email.com
 *               senha:
 *                 type: string
 *                 example: 123456
 *               tipo:
 *                 type: string
 *                 example: usuario
 *     responses:
 *       201:
 *         description: Usuário criado.
 */

router.post(
  '/',
  validateCreateUser,
  userController.createUser
);

/**
 * @swagger
 * /api/users/{id}:
 *   put:
 *     summary: Atualiza um usuário
 *     tags: [Users]
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
 *             type: object
 *             properties:
 *               nome:
 *                 type: string
 *               email:
 *                 type: string
 *               senha:
 *                 type: string
 *               tipo:
 *                 type: string
 *     responses:
 *       200:
 *         description: Usuário atualizado.
 */

router.put(
  '/:id',
  validateUpdateUser,
  userController.updateUser
);

/**
 * @swagger
 * /api/users/{id}:
 *   delete:
 *     summary: Remove um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Usuário removido.
 */

router.delete(
  '/:id',
  validateUserId,
  userController.deleteUser
);

module.exports = router;