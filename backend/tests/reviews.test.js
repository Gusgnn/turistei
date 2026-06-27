const request = require('supertest');
const app = require('../app');

describe('Reviews', () => {
  it('deve listar avaliações do local', async () => {
    const response = await request(app)
      .get('/api/reviews/place/1');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  it('deve bloquear local inválido', async () => {
    const response = await request(app)
      .get('/api/reviews/place/abc');

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve criar uma avaliação', async () => {
    const response = await request(app)
      .post('/api/reviews')
      .send({
        usuario_id: 16,
        local_id: 1,
        nota: 5,
        comentario: 'Excelente local.'
      });

    expect([200, 201]).toContain(response.status);
  });

  it('deve bloquear avaliação sem dados', async () => {
    const response = await request(app)
      .post('/api/reviews')
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve retornar 404 para avaliação inexistente', async () => {
    const response = await request(app)
      .delete('/api/reviews/999999');

    expect(response.status).toBe(404);
    expect(response.body.success).toBe(false);
  });
});