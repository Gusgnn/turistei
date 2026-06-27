const swaggerJsdoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',

    info: {
      title: 'Turistei API',
      version: '1.0.0',
      description: 'Documentação da API do Turistei',
    },

    servers: [
      {
        url: 'http://localhost:3000',
      },
    ],

    components: {
      schemas: {

        User: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            nome: { type: 'string' },
            email: { type: 'string' },
            tipo: { type: 'string' }
          }
        },

        Category: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            nome: { type: 'string' }
          }
        },

        Place: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            nome: { type: 'string' },
            endereco: { type: 'string' }
          }
        },

        Review: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            nota: { type: 'integer' },
            comentario: { type: 'string' }
          }
        },

        Event: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            titulo: { type: 'string' }
          }
        },

        Notification: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            titulo: { type: 'string' },
            mensagem: { type: 'string' }
          }
        },

        Itinerary: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            titulo: { type: 'string' }
          }
        }

      }
    }

  },

  apis: [
    './src/**/*.routes.js'
  ]
};

module.exports = swaggerJsdoc(options);