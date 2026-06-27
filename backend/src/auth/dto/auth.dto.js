function toLoginDTO(body) {
  return {
    email: body.email?.trim().toLowerCase(),
    senha: body.senha,
  };
}

module.exports = {
  toLoginDTO,
};