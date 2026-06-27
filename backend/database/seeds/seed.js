const pool = require('../connection');

async function seed() {
  try {
    console.log('Iniciando seed...');

    await pool.query(`
      INSERT INTO usuarios (nome, email, senha, tipo, ativo)
      VALUES
        ('Admin Turistei', 'admin@turistei.com', '123456', 'admin', true),
        ('Usuário Teste', 'usuario@turistei.com', '123456', 'usuario', true)
      ON CONFLICT (email) DO NOTHING;
    `);

    await pool.query(`
        INSERT INTO categorias (nome, ativo)
        VALUES
            ('Pontos Turísticos', true),
            ('Gastronomia', true),
            ('Eventos', true)
        ON CONFLICT DO NOTHING;
    `);

    await pool.query(`
      INSERT INTO locais (
        categoria_id,
        nome,
        descricao,
        endereco,
        latitude,
        longitude,
        horario_funcionamento,
        valor_entrada,
        avaliacao_media,
        imagem_principal,
        ativo
      )
      VALUES
        (
          1,
          'Torre de TV',
          'Um dos pontos turísticos mais conhecidos de Brasília.',
          'Eixo Monumental, Brasília - DF',
          -15.7906,
          -47.8927,
          '09:00 às 19:00',
          'Gratuito',
          4.8,
          'https://exemplo.com/torre-tv.jpg',
          true
        ),
        (
          1,
          'Catedral Metropolitana',
          'Catedral icônica projetada por Oscar Niemeyer.',
          'Esplanada dos Ministérios, Brasília - DF',
          -15.7989,
          -47.8758,
          '08:00 às 18:00',
          'Gratuito',
          4.9,
          'https://exemplo.com/catedral.jpg',
          true
        )
      ON CONFLICT DO NOTHING;
    `);

    await pool.query(`
      INSERT INTO eventos (local_id, titulo, descricao, data_evento, horario)
      VALUES
        (1, 'Festival Cultural de Brasília', 'Evento cultural aberto ao público.', '2026-07-20', '18:00'),
        (2, 'Visita Guiada Especial', 'Visita guiada pela Catedral Metropolitana.', '2026-07-25', '10:00')
      ON CONFLICT DO NOTHING;
    `);

    await pool.query(`
      INSERT INTO notificacoes (usuario_id, titulo, mensagem, lida)
      VALUES
        (16, 'Bem-vindo ao Turistei', 'Explore os principais pontos turísticos de Brasília.', false),
        (16, 'Novo evento disponível', 'Confira os novos eventos cadastrados.', false)
      ON CONFLICT DO NOTHING;
    `);

    await pool.query(`
        INSERT INTO roteiros (usuario_id, titulo, descricao)
        VALUES
         (16, 'Roteiro Centro de Brasília', 'Passeio pelos principais pontos turísticos do centro.')
         ON CONFLICT DO NOTHING;
    `);

    await pool.query(`
      INSERT INTO roteiro_locais (roteiro_id, local_id, ordem)
      VALUES
        (1, 1, 1),
        (1, 2, 2)
      ON CONFLICT DO NOTHING;
    `);

    console.log('Seed concluído com sucesso.');
  } catch (error) {
    console.error('Erro ao executar seed:', error.message);
  } finally {
    await pool.end();
  }
}

seed();