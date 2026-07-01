DROP TABLE IF EXISTS notificacoes CASCADE;
DROP TABLE IF EXISTS roteiro_locais CASCADE;
DROP TABLE IF EXISTS roteiros CASCADE;
DROP TABLE IF EXISTS eventos CASCADE;
DROP TABLE IF EXISTS avaliacoes CASCADE;
DROP TABLE IF EXISTS favoritos CASCADE;
DROP TABLE IF EXISTS usuario_tags CASCADE;
DROP TABLE IF EXISTS local_tags CASCADE;
DROP TABLE IF EXISTS locais CASCADE;
DROP TABLE IF EXISTS tags CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL,
  tipo VARCHAR(20) DEFAULT 'usuario',
  ativo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  icone VARCHAR(80),
  cor VARCHAR(20),
  ativo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE locais (
  id SERIAL PRIMARY KEY,
  categoria_id INTEGER REFERENCES categorias(id),
  nome VARCHAR(120) NOT NULL,
  descricao TEXT,
  endereco VARCHAR(255),
  latitude DECIMAL(10, 8) NOT NULL,
  longitude DECIMAL(11, 8) NOT NULL,
  horario_funcionamento VARCHAR(120),
  valor_entrada VARCHAR(80),
  avaliacao_media DECIMAL(3,1) DEFAULT 0,
  imagem_principal VARCHAR(255),
  ativo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE local_tags (
  local_id INTEGER REFERENCES locais(id) ON DELETE CASCADE,
  tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (local_id, tag_id)
);

CREATE TABLE usuario_tags (
  usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
  tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (usuario_id, tag_id)
);

CREATE TABLE favoritos (
  usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
  local_id INTEGER REFERENCES locais(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, local_id)
);

CREATE TABLE avaliacoes (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
  local_id INTEGER REFERENCES locais(id) ON DELETE CASCADE,
  nota INTEGER CHECK (nota BETWEEN 1 AND 5),
  comentario TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE eventos (
  id SERIAL PRIMARY KEY,
  categoria_id INTEGER REFERENCES categorias(id),
  local_id INTEGER REFERENCES locais(id) ON DELETE SET NULL,
  titulo VARCHAR(120) NOT NULL,
  descricao TEXT,
  data_inicio TIMESTAMP,
  data_fim TIMESTAMP,
  horario VARCHAR(50),
  imagem VARCHAR(255),
  ativo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roteiros (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
  titulo VARCHAR(120) NOT NULL,
  descricao TEXT,
  ativo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roteiro_locais (
  roteiro_id INTEGER REFERENCES roteiros(id) ON DELETE CASCADE,
  local_id INTEGER REFERENCES locais(id) ON DELETE CASCADE,
  ordem INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (roteiro_id, local_id)
);

CREATE TABLE notificacoes (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
  titulo VARCHAR(120) NOT NULL,
  mensagem TEXT NOT NULL,
  tipo VARCHAR(50),
  lida BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO categorias (id, nome, icone, cor, ativo) VALUES
(1, 'Local Teste', 'place', '#607D8B', true),
(2, 'Parques', 'park', '#4CAF50', true),
(3, 'Gastronomia', 'restaurant', '#FF9800', true),
(4, 'Cultura', 'museum', '#9C27B0', true),
(5, 'Compras', 'shopping_bag', '#2196F3', true),
(6, 'Monumentos', 'account_balance', '#795548', true),
(8, 'Pontos Turísticos', 'location_on', '#E91E63', true),
(10, 'Eventos', 'event', '#3F51B5', true),
(14, 'Hospedagem', 'hotel', '#00BCD4', true),
(15, 'Vida Noturna', 'nightlife', '#673AB7', true),
(16, 'Passeios', 'tour', '#009688', true);

SELECT setval('categorias_id_seq', (SELECT MAX(id) FROM categorias));

INSERT INTO tags (nome) VALUES
('turismo'),
('família'),
('natureza'),
('história'),
('cultura'),
('gastronomia'),
('compras'),
('mirante'),
('arquitetura'),
('lazer');

INSERT INTO locais
(categoria_id, nome, descricao, endereco, latitude, longitude, horario_funcionamento, valor_entrada, avaliacao_media, imagem_principal, ativo)
VALUES
(6, 'Catedral Metropolitana', 'Um dos principais cartões-postais de Brasília, projetada por Oscar Niemeyer.', 'Esplanada dos Ministérios, Brasília - DF', -15.79840000, -47.87580000, '08:00 às 18:00', 'Gratuito', 4.8, 'catedral.jpg', true),
(6, 'Congresso Nacional', 'Sede do Poder Legislativo brasileiro e um dos símbolos arquitetônicos da capital.', 'Praça dos Três Poderes, Brasília - DF', -15.79980000, -47.86450000, '09:00 às 17:00', 'Gratuito', 4.7, 'congresso.jpg', true),
(6, 'Palácio do Planalto', 'Sede oficial do Poder Executivo Federal.', 'Praça dos Três Poderes, Brasília - DF', -15.79920000, -47.86360000, '09:00 às 17:00', 'Gratuito', 4.6, 'palacio_planalto.jpg', true),
(6, 'Supremo Tribunal Federal', 'Sede do Poder Judiciário brasileiro.', 'Praça dos Três Poderes, Brasília - DF', -15.79940000, -47.86240000, '09:00 às 17:00', 'Gratuito', 4.5, 'stf.jpg', true),
(6, 'Palácio da Alvorada', 'Residência oficial da Presidência da República.', 'SHTN Trecho 1, Brasília - DF', -15.79200000, -47.82580000, 'Visitação externa', 'Gratuito', 4.6, 'palacio_alvorada.jpg', true),

(4, 'Memorial JK', 'Museu dedicado à memória de Juscelino Kubitschek.', 'Eixo Monumental Oeste, Brasília - DF', -15.78350000, -47.91390000, '09:00 às 18:00', 'Pago', 4.8, 'memorial_jk.jpg', true),
(4, 'Museu Nacional da República', 'Espaço cultural com exposições de arte, história e cultura.', 'Esplanada dos Ministérios, Brasília - DF', -15.79720000, -47.87830000, '09:00 às 18:30', 'Gratuito', 4.6, 'museu_nacional.jpg', true),
(4, 'Museu Vivo da Memória Candanga', 'Museu histórico sobre a construção de Brasília.', 'Núcleo Bandeirante, Brasília - DF', -15.87480000, -47.96440000, '09:00 às 17:00', 'Gratuito', 4.5, 'memoria_candanga.jpg', true),
(4, 'Espaço Lúcio Costa', 'Espaço dedicado ao urbanista responsável pelo Plano Piloto.', 'Praça dos Três Poderes, Brasília - DF', -15.79900000, -47.86270000, '09:00 às 18:00', 'Gratuito', 4.4, 'espaco_lucio_costa.jpg', true),
(4, 'CCBB Brasília', 'Centro cultural com exposições, cinema, teatro e eventos.', 'SCES Trecho 2, Brasília - DF', -15.81350000, -47.85680000, '09:00 às 21:00', 'Gratuito/Pago', 4.8, 'ccbb.jpg', true),

(2, 'Parque da Cidade Sarah Kubitschek', 'Grande parque urbano com áreas de lazer, esportes e ciclovias.', 'Asa Sul, Brasília - DF', -15.79780000, -47.91780000, 'Aberto 24 horas', 'Gratuito', 4.7, 'parque_cidade.jpg', true),
(2, 'Jardim Botânico de Brasília', 'Área verde com trilhas, jardins temáticos e cerrado.', 'SMDB Conjunto 12, Lago Sul, Brasília - DF', -15.86760000, -47.83560000, '09:00 às 17:00', 'Pago', 4.7, 'jardim_botanico.jpg', true),
(2, 'Parque Olhos dÁgua', 'Parque ecológico na Asa Norte, ideal para caminhadas.', 'Asa Norte, Brasília - DF', -15.74450000, -47.88420000, '06:00 às 19:00', 'Gratuito', 4.6, 'olhos_dagua.jpg', true),
(2, 'Parque Ecológico Águas Claras', 'Parque urbano com trilhas, lagos, esporte e lazer.', 'Águas Claras, Brasília - DF', -15.83430000, -48.02260000, '06:00 às 22:00', 'Gratuito', 4.6, 'parque_aguas_claras.jpg', true),
(15, 'Parque Nacional de Brasília', 'Unidade de conservação conhecida como Água Mineral.', 'BR-450, Brasília - DF', -15.74270000, -47.93880000, '08:00 às 16:00', 'Pago', 4.7, 'agua_mineral.jpg', true),

(8, 'Ermida Dom Bosco', 'Ponto turístico às margens do Lago Paranoá, conhecido pelo pôr do sol.', 'Lago Sul, Brasília - DF', -15.84760000, -47.83350000, '06:00 às 20:00', 'Gratuito', 4.8, 'ermida_dom_bosco.jpg', true),
(8, 'Torre de TV', 'Mirante e feira tradicional localizada no Eixo Monumental.', 'Eixo Monumental, Brasília - DF', -15.78900000, -47.88250000, '09:00 às 18:00', 'Gratuito', 4.6, 'torre_tv.jpg', true),
(8, 'Torre de TV Digital', 'Monumento e mirante localizado no Lago Norte.', 'Lago Norte, Brasília - DF', -15.69900000, -47.83120000, 'Visitação externa', 'Gratuito', 4.4, 'torre_digital.jpg', true),
(8, 'Praça dos Cristais', 'Praça paisagística projetada por Burle Marx.', 'Setor Militar Urbano, Brasília - DF', -15.75890000, -47.91980000, 'Aberto 24 horas', 'Gratuito', 4.5, 'praca_cristais.jpg', true),

(16, 'Pontão do Lago Sul', 'Área de lazer e gastronomia às margens do Lago Paranoá.', 'SHIS QL 10, Lago Sul, Brasília - DF', -15.82700000, -47.87480000, '10:00 às 00:00', 'Gratuito', 4.7, 'pontao.jpg', true),
(16, 'Zoológico de Brasília', 'Zoológico com diversas espécies e área de lazer familiar.', 'Avenida das Nações, Brasília - DF', -15.84450000, -47.94330000, '08:30 às 17:00', 'Pago', 4.4, 'zoologico.jpg', true),

(5, 'Terraço Shopping', 'Shopping com lojas, cinema, praça de alimentação e lazer.', 'Octogonal, Brasília - DF', -15.79820000, -47.94470000, '10:00 às 22:00', 'Gratuito', 4.4, 'terraco_shopping.jpg', true),
(5, 'Brasília Shopping', 'Centro comercial localizado no Setor Comercial Norte.', 'Asa Norte, Brasília - DF', -15.77920000, -47.88880000, '10:00 às 22:00', 'Gratuito', 4.5, 'brasilia_shopping.jpg', true),
(5, 'Conjunto Nacional', 'Shopping tradicional no centro de Brasília.', 'SDN CNB, Brasília - DF', -15.78070000, -47.88360000, '10:00 às 22:00', 'Gratuito', 4.4, 'conjunto_nacional.jpg', true),
(5, 'Pátio Brasil Shopping', 'Shopping localizado próximo ao centro da capital.', 'Asa Sul, Brasília - DF', -15.79240000, -47.89150000, '10:00 às 22:00', 'Gratuito', 4.3, 'patio_brasil.jpg', true),
(5, 'Iguatemi Brasília', 'Shopping premium localizado no Lago Norte.', 'Lago Norte, Brasília - DF', -15.72150000, -47.88660000, '10:00 às 22:00', 'Gratuito', 4.6, 'iguatemi.jpg', true),

(3, 'Coco Bambu Brasília', 'Restaurante conhecido por pratos variados e frutos do mar.', 'Setor de Clubes Sul, Brasília - DF', -15.81850000, -47.87450000, '11:00 às 00:00', 'Pago', 4.7, 'coco_bambu.jpg', true),
(3, 'Mangai Brasília', 'Restaurante de culinária nordestina muito conhecido em Brasília.', 'SCES Trecho 2, Brasília - DF', -15.81170000, -47.87170000, '11:00 às 23:00', 'Pago', 4.7, 'mangai.jpg', true),
(3, 'Beirute Asa Sul', 'Restaurante tradicional da Asa Sul, famoso por comida árabe.', 'CLS 109 Sul, Brasília - DF', -15.81290000, -47.89280000, '11:00 às 00:00', 'Pago', 4.6, 'beirute.jpg', true),
(3, 'Ernesto Cafés Especiais', 'Cafeteria conhecida por cafés especiais, brunch e ambiente aconchegante.', 'CLS 115 Sul, Brasília - DF', -15.81640000, -47.88930000, '08:00 às 20:00', 'Pago', 4.6, 'ernesto_cafe.jpg', true);

INSERT INTO eventos
(categoria_id, local_id, titulo, descricao, data_inicio, data_fim, horario, imagem, ativo)
VALUES
(10, 10, 'Mostra Cultural no CCBB', 'Evento cultural com exposições e atividades artísticas.', CURRENT_TIMESTAMP + INTERVAL '5 days', CURRENT_TIMESTAMP + INTERVAL '5 days 4 hours', '18:00', 'evento_ccbb.jpg', true),
(10, 2, 'Visita Guiada ao Congresso Nacional', 'Visita guiada por um dos principais símbolos de Brasília.', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP + INTERVAL '7 days 2 hours', '10:00', 'evento_congresso.jpg', true),
(10, 17, 'Feira da Torre de TV', 'Feira tradicional com artesanato, gastronomia e produtos locais.', CURRENT_TIMESTAMP + INTERVAL '3 days', CURRENT_TIMESTAMP + INTERVAL '3 days 8 hours', '09:00', 'evento_torre.jpg', true);

INSERT INTO notificacoes
(usuario_id, titulo, mensagem, tipo, lida)
SELECT id, 'Bem-vindo ao Turistei', 'Explore os principais locais turísticos de Brasília.', 'sistema', false
FROM usuarios;