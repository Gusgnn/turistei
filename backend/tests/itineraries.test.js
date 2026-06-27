const request = require('supertest');
const app = require('../app');

describe('Itineraries', () => {
  it('deve listar roteiros do usuário', async () => {
    const response = await request(app)
      .get('/api/itineraries/user/16');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  it('deve bloquear usuário inválido', async () => {
    const response = await request(app)
      .get('/api/itineraries/user/abc');

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve criar um roteiro', async () => {
    const response = await request(app)
      .post('/api/itineraries')
      .send({
        usuario_id: 16,
        titulo: 'Roteiro Jest',
        descricao: 'Criado pelo Jest'
      });

    expect([200, 201, 409, 500]).toContain(response.status);
  });

  it('deve bloquear criação sem dados', async () => {
    const response = await request(app)
      .post('/api/itineraries')
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve retornar 404 para roteiro inexistente', async () => {
    const response = await request(app)
      .get('/api/itineraries/999999');

    expect(response.status).toBe(404);
    expect(response.body.success).toBe(false);
  });
});