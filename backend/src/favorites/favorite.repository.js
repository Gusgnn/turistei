const pool = require('../../database/connection');

async function findByUserId(userId) {
  const result = await pool.query(
    `
    SELECT
      f.usuario_id,
      f.local_id,
      f.criado_em,
      l.nome,
      l.descricao,
      l.endereco,
      l.latitude,
      l.longitude,
      l.imagem_principal,
      l.avaliacao_media
    FROM favoritos f
    INNER JOIN locais l
      ON l.id = f.local_id
    WHERE f.usuario_id = $1
    ORDER BY f.criado_em DESC
    `,
    [userId]
  );

  return result.rows;
}

async function create(favorite) {
  const result = await pool.query(
    `
    INSERT INTO favoritos
      (usuario_id, local_id)
    VALUES
      ($1, $2)
    RETURNING *;
    `,
    [favorite.usuario_id, favorite.local_id]
  );

  return result.rows[0];
}

async function remove(usuarioId, localId) {
  const result = await pool.query(
    `
    DELETE FROM favoritos
    WHERE usuario_id = $1
      AND local_id = $2
    RETURNING *;
    `,
    [usuarioId, localId]
  );

  return result.rows[0];
}

module.exports = {
  findByUserId,
  create,
  remove,
};