const request = require('supertest');
const app = require('../app');

describe('Health Check', () => {
  it('deve retornar API funcionando', async () => {
    const response = await request(app).get('/');

    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.message).toBe('API Turistei funcionando!');
  });
});