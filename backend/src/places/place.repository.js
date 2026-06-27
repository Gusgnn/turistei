const pool = require('../../database/connection');

async function findAll() {
  const result = await pool.query(`
    SELECT
      l.id,
      l.nome,
      l.descricao,
      l.endereco,
      l.latitude,
      l.longitude,
      l.horario_funcionamento,
      l.valor_entrada,
      l.avaliacao_media,
      l.imagem_principal,
      l.ativo,
      c.nome AS categoria
      FROM locais l
      LEFT JOIN categorias c
      ON c.id = l.categoria_id
      WHERE l.ativo = true
      ORDER BY l.id ASC
  `);

  return result.rows;
}

async function findById(id) {
  const result = await pool.query(
    `
    SELECT
      l.*,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.id = $1
    AND l.ativo = true
    `,
    [id]
  );

  return result.rows[0];
}

async function findPopular() {
  const result = await pool.query(`
    SELECT
      l.*,
      c.nome AS categoria
      FROM locais l
      LEFT JOIN categorias c
      ON c.id = l.categoria_id
      WHERE l.ativo = true
      ORDER BY l.avaliacao_media DESC
      LIMIT 10
  `);

  return result.rows;
}

async function searchByName(query) {
  const result = await pool.query(
    `
    SELECT
      l.*,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.ativo = true
      AND (
          l.nome ILIKE $1
      OR l.descricao ILIKE $1
      OR c.nome ILIKE $1
      )
    `,
    [`%${query}%`]
  );

  return result.rows;
}

async function findByCategory(categoryId) {const pool = require('../../database/connection');

async function findAll() {
  const result = await pool.query(`
    SELECT
      l.id,
      l.categoria_id,
      l.nome,
      l.descricao,
      l.endereco,
      l.latitude,
      l.longitude,
      l.horario_funcionamento,
      l.valor_entrada,
      l.avaliacao_media,
      l.imagem_principal,
      l.ativo,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.ativo = true
    ORDER BY l.id ASC
  `);

  return result.rows;
}

async function findById(id) {
  const result = await pool.query(
    `
    SELECT
      l.*,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.id = $1
      AND l.ativo = true
    `,
    [id]
  );

  return result.rows[0];
}

async function findPopular() {
  const result = await pool.query(`
    SELECT
      l.*,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.ativo = true
    ORDER BY l.avaliacao_media DESC
    LIMIT 10
  `);

  return result.rows;
}

async function searchByName(query) {
  const result = await pool.query(
    `
    SELECT
      l.*,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.ativo = true
      AND (
        l.nome ILIKE $1
        OR l.descricao ILIKE $1
        OR c.nome ILIKE $1
      )
    ORDER BY l.id ASC
    `,
    [`%${query}%`]
  );

  return result.rows;
}

async function findByCategory(categoryId) {
  const result = await pool.query(
    `
    SELECT
      l.*,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.categoria_id = $1
      AND l.ativo = true
    ORDER BY l.id ASC
    `,
    [categoryId]
  );

  return result.rows;
}

async function findAllWithCoordinates() {
  const result = await pool.query(`
    SELECT *
    FROM locais
    WHERE ativo = true
      AND latitude IS NOT NULL
      AND longitude IS NOT NULL
  `);

  return result.rows;
}

async function create(place) {
  const result = await pool.query(
    `
    INSERT INTO locais
    (
      categoria_id,
      nome,
      descricao,
      endereco,
      latitude,
      longitude,
      horario_funcionamento,
      valor_entrada,
      imagem_principal
    )
    VALUES
    ($1,$2,$3,$4,$5,$6,$7,$8,$9)
    RETURNING *;
    `,
    [
      place.categoria_id,
      place.nome,
      place.descricao,
      place.endereco,
      place.latitude,
      place.longitude,
      place.horario_funcionamento,
      place.valor_entrada,
      place.imagem_principal,
    ]
  );

  return result.rows[0];
}

async function update(id, place) {
  const result = await pool.query(
    `
    UPDATE locais
    SET
      categoria_id = COALESCE($1, categoria_id),
      nome = COALESCE($2, nome),
      descricao = COALESCE($3, descricao),
      endereco = COALESCE($4, endereco),
      latitude = COALESCE($5, latitude),
      longitude = COALESCE($6, longitude),
      horario_funcionamento = COALESCE($7, horario_funcionamento),
      valor_entrada = COALESCE($8, valor_entrada),
      imagem_principal = COALESCE($9, imagem_principal),
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $10
      AND ativo = true
    RETURNING *;
    `,
    [
      place.categoria_id,
      place.nome,
      place.descricao,
      place.endereco,
      place.latitude,
      place.longitude,
      place.horario_funcionamento,
      place.valor_entrada,
      place.imagem_principal,
      id,
    ]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    UPDATE locais
    SET
      ativo = false,
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $1
      AND ativo = true
    RETURNING *;
    `,
    [id]
  );

  return result.rows[0];
}

module.exports = {
  findAll,
  findById,
  findPopular,
  searchByName,
  findByCategory,
  findAllWithCoordinates,
  create,
  update,
  remove,
};
  const result = await pool.query(
    `
    SELECT
      l.*,
      c.nome AS categoria
    FROM locais l
    LEFT JOIN categorias c
      ON c.id = l.categoria_id
    WHERE l.categoria_id = $1
      AND l.ativo = true
    `,
    [categoryId]
  );

  return result.rows;
}

async function findAllWithCoordinates() {
  const result = await pool.query(`
    SELECT *
    FROM locais
    WHERE ativo = true
  `);

  return result.rows;
}

async function create(place) {

  const result = await pool.query(

    `
    INSERT INTO locais
    (
      categoria_id,
      nome,
      descricao,
      endereco,
      latitude,
      longitude,
      horario_funcionamento,
      valor_entrada,
      imagem_principal
    )

    VALUES

    ($1,$2,$3,$4,$5,$6,$7,$8,$9)

    RETURNING *;
    `,

    [

      place.categoria_id,

      place.nome,

      place.descricao,

      place.endereco,

      place.latitude,

      place.longitude,

      place.horario_funcionamento,

      place.valor_entrada,

      place.imagem_principal

    ]

  );

  return result.rows[0];

}

async function update(id, place) {
  const result = await pool.query(
    `
    UPDATE locais
    SET
      categoria_id = COALESCE($1, categoria_id),
      nome = COALESCE($2, nome),
      descricao = COALESCE($3, descricao),
      endereco = COALESCE($4, endereco),
      latitude = COALESCE($5, latitude),
      longitude = COALESCE($6, longitude),
      horario_funcionamento = COALESCE($7, horario_funcionamento),
      valor_entrada = COALESCE($8, valor_entrada),
      imagem_principal = COALESCE($9, imagem_principal),
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $10
    RETURNING *;
    `,
    [
      place.categoria_id,
      place.nome,
      place.descricao,
      place.endereco,
      place.latitude,
      place.longitude,
      place.horario_funcionamento,
      place.valor_entrada,
      place.imagem_principal,
      id,
    ]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    UPDATE locais
    SET ativo = false,
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
  findPopular,
  searchByName,
  findByCategory,
  findAllWithCoordinates,
  create,
  update,
  remove,
};