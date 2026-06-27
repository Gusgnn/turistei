const request = require('supertest');
const app = require('../app');

describe('Places', () => {
  it('deve listar todos os locais', async () => {
    const response = await request(app).get('/api/places');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(Array.isArray(response.body.data)).toBe(true);
  });

  it('deve listar locais populares', async () => {
    const response = await request(app).get('/api/places/popular');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
  });

  it('deve pesquisar locais', async () => {
    const response = await request(app)
      .get('/api/places/search')
      .query({ q: 'Parque' });

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
  });

  it('deve bloquear pesquisa sem parâmetro', async () => {
    const response = await request(app)
      .get('/api/places/search');

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve bloquear coordenadas inválidas', async () => {
    const response = await request(app)
      .get('/api/places/nearby')
      .query({
        lat: 'abc',
        lng: 'xyz',
      });

    expect(response.status).toBe(400);
    expect(response.body.success).toBe(false);
  });

  it('deve retornar 404 para local inexistente', async () => {
    const response = await request(app)
      .get('/api/places/999999');

    expect(response.status).toBe(404);
    expect(response.body.success).toBe(false);
  });
});