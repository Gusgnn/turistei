const categoryService = require('./category.service');
const categoryMapper = require('./category.mapper');
const categoryDTO = require('./dto/category.dto');

const ApiResponse = require('../common/responses/apiResponse');
const asyncHandler = require('../common/middleware/asyncHandler');
const NotFoundError = require('../common/errors/NotFoundError');

const getAllCategories = asyncHandler(async (req, res) => {
  const categories = await categoryService.getAllCategories();

  return res.json(
    ApiResponse.success(
      categoryMapper.toCategoryListResponse(categories)
    )
  );
});

const getCategoryById = asyncHandler(async (req, res) => {
  const category = await categoryService.getCategoryById(req.params.id);

  if (!category) {
    throw new NotFoundError('Categoria não encontrada.');
  }

  return res.json(
    ApiResponse.success(
      categoryMapper.toCategoryResponse(category)
    )
  );
});

const createCategory = asyncHandler(async (req, res) => {
  const dto = categoryDTO.toCreateDTO(req.body);

  const category = await categoryService.createCategory(dto);

  return res
    .status(201)
    .json(
      ApiResponse.success(
        categoryMapper.toCategoryResponse(category),
        'Categoria criada com sucesso.'
      )
    );
});

const updateCategory = asyncHandler(async (req, res) => {
  const dto = categoryDTO.toUpdateDTO(req.body);

  const category = await categoryService.updateCategory(req.params.id, dto);

  if (!category) {
    throw new NotFoundError('Categoria não encontrada.');
  }

  return res.json(
    ApiResponse.success(
      categoryMapper.toCategoryResponse(category),
      'Categoria atualizada com sucesso.'
    )
  );
});

const deleteCategory = asyncHandler(async (req, res) => {
  const category = await categoryService.deleteCategory(req.params.id);

  if (!category) {
    throw new NotFoundError('Categoria não encontrada.');
  }

  return res.json(
    ApiResponse.success(
      null,
      'Categoria removida com sucesso.'
    )
  );
});

module.exports = {
  getAllCategories,
  getCategoryById,
  createCategory,
  updateCategory,
  deleteCategory,
};