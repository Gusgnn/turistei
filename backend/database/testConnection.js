const pool = require('./connection');

async function testConnection() {
  try {
    const result = await pool.query('SELECT NOW()');
    console.log('Banco conectado com sucesso:', result.rows[0]);
  } catch (error) {
    console.error('Erro ao conectar no banco:', error.message);
  } finally {
    await pool.end();
  }
}

testConnection();