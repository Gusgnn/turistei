const request = require('supertest');
const app = require('../app');

describe('Auth', () => {
  it('deve bloquear login sem email e senha', async () => {
    const response = await request(app)
      .post('/api/auth/login')
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve bloquear login inválido', async () => {
    const response = await request(app)
      .post('/api/auth/login')
      .send({
        email: 'inexistente@email.com',
        senha: 'senhaerrada',
      });

    expect([400, 401]).toContain(response.status);
    expect(response.body.success).toBe(false);
  });
});