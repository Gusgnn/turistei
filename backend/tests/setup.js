const pool = require('../database/connection');

afterAll(async () => {
  await pool.end();
});