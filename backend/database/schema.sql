CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  icone VARCHAR(80),
  cor VARCHAR(20)
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
  preco VARCHAR(80),
  avaliacao_media DECIMAL(2,1) DEFAULT 0,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, local_id)
);

CREATE TABLE avaliacoes (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
  local_id INTEGER REFERENCES locais(id) ON DELETE CASCADE,
  nota INTEGER CHECK (nota BETWEEN 1 AND 5),
  comentario TEXT,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE eventos (
  id SERIAL PRIMARY KEY,
  local_id INTEGER REFERENCES locais(id) ON DELETE SET NULL,
  titulo VARCHAR(120) NOT NULL,
  descricao TEXT,
  data_evento DATE,
  horario VARCHAR(50),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roteiros (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
  titulo VARCHAR(120) NOT NULL,
  descricao TEXT,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roteiro_locais (
  roteiro_id INTEGER REFERENCES roteiros(id) ON DELETE CASCADE,
  local_id INTEGER REFERENCES locais(id) ON DELETE CASCADE,
  ordem INTEGER NOT NULL,
  PRIMARY KEY (roteiro_id, local_id)
);