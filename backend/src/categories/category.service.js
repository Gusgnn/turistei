const categoryRepository = require('./category.repository');

async function getAllCategories() {
  return await categoryRepository.findAll();
}

async function getCategoryById(id) {
  return await categoryRepository.findById(id);
}

async function createCategory(category) {
  return await categoryRepository.create(category);
}

async function updateCategory(id, category) {
  return await categoryRepository.update(id, category);
}

async function deleteCategory(id) {
  return await categoryRepository.remove(id);
}

module.exports = {
  getAllCategories,
  getCategoryById,
  createCategory,
  updateCategory,
  deleteCategory,
};