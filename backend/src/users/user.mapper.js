function toUserResponse(user) {
  return {
    id: user.id,
    nome: user.nome,
    email: user.email,
    telefone: user.telefone,
    tipo: user.tipo,
    ativo: user.ativo,
    createdAt: user.created_at,
    updatedAt: user.updated_at,
  };
}

function toUserListResponse(users) {
  return users.map(toUserResponse);
}

module.exports = {
  toUserResponse,
  toUserListResponse,
};