function toAuthResponse(user, token) {
  return {
    usuario: {
      id: user.id,
      nome: user.nome,
      email: user.email,
      tipo: user.tipo,
    },
    token,
  };
}

module.exports = {
  toAuthResponse,
};