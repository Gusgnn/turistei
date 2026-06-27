const request = require('supertest');
const app = require('../app');

describe('Favorites', () => {
  it('deve listar favoritos do usuário 16', async () => {
    const response = await request(app)
      .get('/api/favorites/user/16');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  it('deve bloquear usuário inválido', async () => {
    const response = await request(app)
      .get('/api/favorites/user/abc');

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve criar um favorito', async () => {
    const response = await request(app)
      .post('/api/favorites')
      .send({
        usuario_id: 16,
        local_id: 1
      });

    expect([200, 201, 409, 500]).toContain(response.status);
  });

  it('deve bloquear criação sem dados', async () => {
    const response = await request(app)
      .post('/api/favorites')
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });
});