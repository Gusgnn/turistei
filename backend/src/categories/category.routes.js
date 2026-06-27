/**
 * @swagger
 * tags:
 *   name: Categories
 *   description: Gerenciamento de categorias
 */

const express = require('express');

const categoryController = require('./category.controller');

const {
  validateCategoryId,
  validateCreateCategory,
} = require('./category.validation');

const router = express.Router();

/**
 * @swagger
 * /api/categories:
 *   post:
 *     summary: Cria categoria
 *     tags: [Categories]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Category'
 *     responses:
 *       201:
 *         description: Categoria criada.
 */

router.post(
  '/',
  validateCreateCategory,
  categoryController.createCategory
);

/**
 * @swagger
 * /api/categories/{id}:
 *   put:
 *     summary: Atualiza categoria
 *     tags: [Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Categoria atualizada.
 */

router.put(
  '/:id',
  validateCategoryId,
  categoryController.updateCategory
);

/**
 * @swagger
 * /api/categories/{id}:
 *   delete:
 *     summary: Remove categoria
 *     tags: [Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Categoria removida.
 */

router.delete(
  '/:id',
  validateCategoryId,
  categoryController.deleteCategory
);

/**
 * @swagger
 * /api/categories:
 *   get:
 *     summary: Lista categorias
 *     tags: [Categories]
 *     responses:
 *       200:
 *         description: Lista de categorias.
 */

router.get('/', categoryController.getAllCategories);

/**
 * @swagger
 * /api/categories/{id}:
 *   get:
 *     summary: Busca categoria por ID
 *     tags: [Categories]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Categoria encontrada.
 *       404:
 *         description: Categoria não encontrada.
 */

router.get(
  '/:id',
  validateCategoryId,
  categoryController.getCategoryById
);

module.exports = router;