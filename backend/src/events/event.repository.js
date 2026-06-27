const pool = require('../../database/connection');

async function findAll() {
  const result = await pool.query(
    `
    SELECT
      e.id,
      e.local_id,
      e.titulo,
      e.descricao,
      e.data_evento,
      e.horario,
      e.criado_em,
      l.nome AS local_nome,
      l.endereco AS local_endereco
    FROM eventos e
    LEFT JOIN locais l
      ON l.id = e.local_id
    ORDER BY e.data_evento ASC
    `
  );

  return result.rows;
}

async function findById(id) {
  const result = await pool.query(
    `
    SELECT
      e.id,
      e.local_id,
      e.titulo,
      e.descricao,
      e.data_evento,
      e.horario,
      e.criado_em,
      l.nome AS local_nome,
      l.endereco AS local_endereco
    FROM eventos e
    LEFT JOIN locais l
      ON l.id = e.local_id
    WHERE e.id = $1
    `,
    [id]
  );

  return result.rows[0];
}

async function findUpcoming() {
  const result = await pool.query(
    `
    SELECT
      e.id,
      e.local_id,
      e.titulo,
      e.descricao,
      e.data_evento,
      e.horario,
      e.criado_em,
      l.nome AS local_nome,
      l.endereco AS local_endereco
    FROM eventos e
    LEFT JOIN locais l
      ON l.id = e.local_id
    WHERE e.data_evento >= CURRENT_DATE
    ORDER BY e.data_evento ASC
    `
  );

  return result.rows;
}

async function findByPlace(localId) {
  const result = await pool.query(
    `
    SELECT
      e.id,
      e.local_id,
      e.titulo,
      e.descricao,
      e.data_evento,
      e.horario,
      e.criado_em,
      l.nome AS local_nome,
      l.endereco AS local_endereco
    FROM eventos e
    LEFT JOIN locais l
      ON l.id = e.local_id
    WHERE e.local_id = $1
    ORDER BY e.data_evento ASC
    `,
    [localId]
  );

  return result.rows;
}

async function create(event) {
  const result = await pool.query(
    `
    INSERT INTO eventos
      (local_id, titulo, descricao, data_evento, horario)
    VALUES
      ($1, $2, $3, $4, $5)
    RETURNING *;
    `,
    [
      event.local_id,
      event.titulo,
      event.descricao,
      event.data_evento,
      event.horario,
    ]
  );

  return result.rows[0];
}

async function update(id, event) {
  const result = await pool.query(
    `
    UPDATE eventos
    SET
      local_id = COALESCE($1, local_id),
      titulo = COALESCE($2, titulo),
      descricao = COALESCE($3, descricao),
      data_evento = COALESCE($4, data_evento),
      horario = COALESCE($5, horario)
    WHERE id = $6
    RETURNING *;
    `,
    [
      event.local_id,
      event.titulo,
      event.descricao,
      event.data_evento,
      event.horario,
      id,
    ]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    DELETE FROM eventos
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
  findUpcoming,
  findByPlace,
  create,
  update,
  remove,
};