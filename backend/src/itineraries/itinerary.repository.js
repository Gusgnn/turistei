const pool = require('../../database/connection');

async function findByUserId(userId) {
  const result = await pool.query(
    `
    SELECT *
    FROM roteiros
    WHERE usuario_id = $1
    ORDER BY criado_em DESC
    `,
    [userId]
  );

  return result.rows;
}

async function findById(id) {
  const result = await pool.query(
    `
    SELECT *
    FROM roteiros
    WHERE id = $1
    `,
    [id]
  );

  return result.rows[0];
}

async function findPlacesByItineraryId(roteiroId) {
  const result = await pool.query(
    `
    SELECT
      rl.roteiro_id,
      rl.local_id,
      rl.ordem,
      l.nome,
      l.descricao,
      l.endereco,
      l.latitude,
      l.longitude,
      l.imagem_principal
    FROM roteiro_locais rl
    INNER JOIN locais l
      ON l.id = rl.local_id
    WHERE rl.roteiro_id = $1
    ORDER BY rl.ordem ASC
    `,
    [roteiroId]
  );

  return result.rows;
}

async function create(itinerary) {
  const result = await pool.query(
    `
    INSERT INTO roteiros
      (usuario_id, titulo, descricao)
    VALUES
      ($1, $2, $3)
    RETURNING *;
    `,
    [
      itinerary.usuario_id,
      itinerary.titulo,
      itinerary.descricao,
    ]
  );

  return result.rows[0];
}

async function update(id, itinerary) {
  const result = await pool.query(
    `
    UPDATE roteiros
    SET
      titulo = COALESCE($1, titulo),
      descricao = COALESCE($2, descricao)
    WHERE id = $3
    RETURNING *;
    `,
    [
      itinerary.titulo,
      itinerary.descricao,
      id,
    ]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    DELETE FROM roteiros
    WHERE id = $1
    RETURNING *;
    `,
    [id]
  );

  return result.rows[0];
}

async function addPlace(data) {
  const result = await pool.query(
    `
    INSERT INTO roteiro_locais
      (roteiro_id, local_id, ordem)
    VALUES
      ($1, $2, $3)
    RETURNING *;
    `,
    [
      data.roteiro_id,
      data.local_id,
      data.ordem,
    ]
  );

  return result.rows[0];
}

async function removePlace(roteiroId, localId) {
  const result = await pool.query(
    `
    DELETE FROM roteiro_locais
    WHERE roteiro_id = $1
      AND local_id = $2
    RETURNING *;
    `,
    [roteiroId, localId]
  );

  return result.rows[0];
}

module.exports = {
  findByUserId,
  findById,
  findPlacesByItineraryId,
  create,
  update,
  remove,
  addPlace,
  removePlace,
};