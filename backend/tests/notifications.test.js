const request = require('supertest');
const app = require('../app');

describe('Notifications', () => {
  it('deve listar notificações do usuário', async () => {
    const response = await request(app)
      .get('/api/notifications/user/16');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  it('deve bloquear usuário inválido', async () => {
    const response = await request(app)
      .get('/api/notifications/user/abc');

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve criar uma notificação', async () => {
    const response = await request(app)
      .post('/api/notifications')
      .send({
        usuario_id: 16,
        titulo: 'Teste Jest',
        mensagem: 'Notificação criada pelo Jest.'
      });

    expect([200, 201]).toContain(response.status);
  });

  it('deve bloquear criação sem dados', async () => {
    const response = await request(app)
      .post('/api/notifications')
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve retornar 404 para notificação inexistente', async () => {
    const response = await request(app)
      .patch('/api/notifications/999999/read');

    expect(response.status).toBe(404);
    expect(response.body.success).toBe(false);
  });
});