const request = require('supertest');
const app = require('../app');

describe('Events', () => {
  it('deve listar eventos', async () => {
    const response = await request(app)
      .get('/api/events');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  it('deve listar próximos eventos', async () => {
    const response = await request(app)
      .get('/api/events/upcoming');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
  });

  it('deve listar eventos de um local', async () => {
    const response = await request(app)
      .get('/api/events/place/1');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
  });

  it('deve bloquear local inválido', async () => {
    const response = await request(app)
      .get('/api/events/place/abc');

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve criar um evento', async () => {
    const response = await request(app)
      .post('/api/events')
      .send({
        local_id: 1,
        titulo: 'Evento de Teste',
        descricao: 'Criado pelo Jest',
        data_evento: '2026-12-20',
        horario: '18:00'
      });

    expect([200, 201]).toContain(response.status);
  });

  it('deve bloquear criação sem dados', async () => {
    const response = await request(app)
      .post('/api/events')
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve retornar 404 para evento inexistente', async () => {
    const response = await request(app)
      .delete('/api/events/999999');

    expect(response.status).toBe(404);
    expect(response.body.success).toBe(false);
  });
});