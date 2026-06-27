const pool = require('../../database/connection');

async function findByUserId(userId) {
  const result = await pool.query(
    `
    SELECT *
    FROM notificacoes
    WHERE usuario_id = $1
    ORDER BY criado_em DESC
    `,
    [userId]
  );

  return result.rows;
}

async function create(notification) {
  const result = await pool.query(
    `
    INSERT INTO notificacoes
      (usuario_id, titulo, mensagem)
    VALUES
      ($1, $2, $3)
    RETURNING *;
    `,
    [
      notification.usuario_id,
      notification.titulo,
      notification.mensagem,
    ]
  );

  return result.rows[0];
}

async function markAsRead(id) {
  const result = await pool.query(
    `
    UPDATE notificacoes
    SET lida = true
    WHERE id = $1
    RETURNING *;
    `,
    [id]
  );

  return result.rows[0];
}

async function remove(id) {
  const result = await pool.query(
    `
    DELETE FROM notificacoes
    WHERE id = $1
    RETURNING *;
    `,
    [id]
  );

  return result.rows[0];
}

module.exports = {
  findByUserId,
  create,
  markAsRead,
  remove,
};