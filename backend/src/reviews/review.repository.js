const pool = require('../../database/connection');

async function findByPlaceId(localId) {
  const result = await pool.query(
    `
    SELECT
      a.id,
      a.usuario_id,
      a.local_id,
      a.nota,
      a.comentario,
      a.criado_em,
      u.nome AS usuario_nome
    FROM avaliacoes a
    INNER JOIN usuarios u
      ON u.id = a.usuario_id
    WHERE a.local_id = $1
      AND a.ativo = true
    ORDER BY a.criado_em DESC
    `,
    [localId]
  );

  return result.rows;
}

async function findById(id) {
  const result = await pool.query(
    `
    SELECT *
    FROM avaliacoes
    WHERE id = $1
      AND ativo = true
    `,
    [id]
  );

  return result.rows[0];
}

async function create(review) {
  const result = await pool.query(
    `
    INSERT INTO avaliacoes
      (usuario_id, local_id, nota, comentario)
    VALUES
      ($1, $2, $3, $4)
    RETURNING *;
    `,
    [
      review.usuario_id,
      review.local_id,
      review.nota,
      review.comentario,
    ]
  );

  return result.rows[0];
}

async function update(id, review) {
  const result = await pool.query(
    `
    UPDATE avaliacoes
    SET
      nota = COALESCE($1, nota),
      comentario = COALESCE($2, comentario),
      updated_at = CURRENT_TIMESTAMP
    WHERE id = $3
      AND ativo = true
    RETURNING *;
    `,
    [
      review.nota,
      review.comentario,
      id,
    ]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    UPDATE avaliacoes
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

async function updatePlaceAverage(localId) {
  const result = await pool.query(
    `
    UPDATE locais
    SET avaliacao_media = COALESCE((
      SELECT ROUND(AVG(nota)::numeric, 1)
      FROM avaliacoes
      WHERE local_id = $1
        AND ativo = true
    ), 0),
    updated_at = CURRENT_TIMESTAMP
    WHERE id = $1
    RETURNING *;
    `,
    [localId]
  );

  return result.rows[0];
}

module.exports = {
  findByPlaceId,
  findById,
  create,
  update,
  remove,
  updatePlaceAverage,
};