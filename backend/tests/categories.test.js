const request = require('supertest');
const app = require('../app');

describe('Categories', () => {
  it('deve listar categorias', async () => {
    const response = await request(app)
      .get('/api/categories');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  it('deve bloquear categoria com ID inválido', async () => {
    const response = await request(app)
      .get('/api/categories/abc');

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve retornar 404 para categoria inexistente', async () => {
    const response = await request(app)
      .get('/api/categories/999999');

    expect(response.status).toBe(404);
    expect(response.body.success).toBe(false);
  });
});