const pool = require('../../database/connection');

async function findAll() {
  const result = await pool.query(`
    SELECT id, nome, icone, cor
    FROM categorias
    WHERE ativo = true
    ORDER BY nome ASC
  `);

  return result.rows;
}

async function findById(id) {
  const result = await pool.query(
    `
    SELECT id, nome, icone, cor
    FROM categorias
    WHERE id = $1
    AND ativo = true
    `,
    [id]
  );

  return result.rows[0];
}

async function create(category) {
  const result = await pool.query(
    `
    INSERT INTO categorias (nome, icone, cor)
    VALUES ($1, $2, $3)
    RETURNING *;
    `,
    [category.nome, category.icone, category.cor]
  );

  return result.rows[0];
}

async function update(id, category) {
  const result = await pool.query(
    `
    UPDATE categorias
    SET
      nome = COALESCE($1, nome),
      icone = COALESCE($2, icone),
      cor = COALESCE($3, cor),
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $4
    RETURNING *;
    `,
    [category.nome, category.icone, category.cor, id]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    UPDATE categorias
    SET
      ativo = false,
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $1
    RETURNING *;
    `,
    [id]
  );

  return result.rows[0];
}

module.exports = {
  findAll,
  findById,
  create,
  update,
  remove,
};