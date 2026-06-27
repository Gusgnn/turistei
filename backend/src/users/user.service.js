const bcrypt = require('bcrypt');

const userRepository = require('./user.repository');
const ValidationError = require('../common/errors/ValidationError');

async function getAllUsers() {
  return await userRepository.findAll();
}

async function getUserById(id) {
  return await userRepository.findById(id);
}

async function createUser(user) {
  const existingUser = await userRepository.findByEmail(user.email);

  if (existingUser) {
    throw new ValidationError('E-mail já cadastrado.');
  }

  const hashedPassword = await bcrypt.hash(user.senha, 10);

  return await userRepository.create({
    ...user,
    senha: hashedPassword,
  });
}

async function updateUser(id, user) {
  if (user.email) {
    const existingUser = await userRepository.findByEmail(user.email);

    if (existingUser && Number(existingUser.id) !== Number(id)) {
      throw new ValidationError('E-mail já cadastrado.');
    }
  }

  return await userRepository.update(id, user);
}

async function deleteUser(id) {
  return await userRepository.remove(id);
}

module.exports = {
  getAllUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
};