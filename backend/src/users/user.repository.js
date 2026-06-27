const pool = require('../../database/connection');

async function findAll() {
  const result = await pool.query(`
    SELECT id, nome, email, telefone, tipo, ativo, created_at, updated_at
    FROM usuarios
    WHERE ativo = true
    ORDER BY id ASC
  `);

  return result.rows;
}

async function findById(id) {
  const result = await pool.query(
    `
    SELECT id, nome, email, telefone, tipo, ativo, created_at, updated_at
    FROM usuarios
    WHERE id = $1
      AND ativo = true
    `,
    [id]
  );

  return result.rows[0];
}

async function findByEmail(email) {
  const result = await pool.query(
    `
    SELECT *
    FROM usuarios
    WHERE email = $1
      AND ativo = true
    `,
    [email]
  );

  return result.rows[0];
}

async function create(user) {
  const result = await pool.query(
    `
    INSERT INTO usuarios
    (
      nome,
      email,
      senha,
      telefone,
      tipo
    )
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id, nome, email, telefone, tipo, ativo, created_at, updated_at;
    `,
    [
      user.nome,
      user.email,
      user.senha,
      user.telefone,
      user.tipo,
    ]
  );

  return result.rows[0];
}

async function update(id, user) {
  const result = await pool.query(
    `
    UPDATE usuarios
    SET
      nome = COALESCE($1, nome),
      email = COALESCE($2, email),
      telefone = COALESCE($3, telefone),
      tipo = COALESCE($4, tipo),
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $5
      AND ativo = true
    RETURNING id, nome, email, telefone, tipo, ativo, created_at, updated_at;
    `,
    [
      user.nome,
      user.email,
      user.telefone,
      user.tipo,
      id,
    ]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    UPDATE usuarios
    SET
      ativo = false,
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $1
      AND ativo = true
    RETURNING id, nome, email, telefone, tipo, ativo, created_at, updated_at;
    `,
    [id]
  );

  return result.rows[0];
}

module.exports = {
  findAll,
  findById,
  findByEmail,
  create,
  update,
  remove,
};