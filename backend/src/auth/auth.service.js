const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const userRepository = require('../users/user.repository');
const ValidationError = require('../common/errors/ValidationError');

async function login({ email, senha }) {
  const user = await userRepository.findByEmail(email);

  if (!user) {
    throw new ValidationError('E-mail ou senha inválidos.');
  }

  const passwordMatches = await bcrypt.compare(senha, user.senha);

  if (!passwordMatches) {
    throw new ValidationError('E-mail ou senha inválidos.');
  }

  const token = jwt.sign(
    {
      id: user.id,
      email: user.email,
      tipo: user.tipo,
    },
    process.env.JWT_SECRET,
    {
      expiresIn: process.env.JWT_EXPIRES_IN || '1d',
    }
  );

  return {
    token,
    user: {
      id: user.id,
      nome: user.nome,
      email: user.email,
      tipo: user.tipo,
    },
  };
}

module.exports = {
  login,
};