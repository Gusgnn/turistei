INSERT INTO categorias (nome, icone, cor) VALUES
('Museus', 'museum', '#3F72AF'),
('Parques', 'park', '#5FAF8F'),
('Gastronomia', 'restaurant', '#D62828'),
('Cultura', 'theater_comedy', '#3F72AF'),
('Compras', 'shopping_bag', '#FFC857'),
('Monumentos', 'location_city', '#D62828');

INSERT INTO tags (nome) VALUES
('arquitetura'),
('natureza'),
('gastronomia'),
('cultura'),
('histórico'),
('família'),
('fotografia'),
('gratuito'),
('lazer');

INSERT INTO locais (
  categoria_id,
  nome,
  descricao,
  endereco,
  latitude,
  longitude,
  horario_funcionamento,
  preco,
  avaliacao_media
) VALUES
(6, 'Congresso Nacional', 'Um dos principais símbolos arquitetônicos de Brasília.', 'Praça dos Três Poderes, Brasília - DF', -15.7997, -47.8645, 'Aberto para visitação conforme agenda oficial', 'Gratuito', 4.9),
(1, 'Museu Nacional', 'Espaço cultural dedicado a exposições e eventos artísticos.', 'Setor Cultural Sul, Brasília - DF', -15.7975, -47.8783, 'Terça a domingo, 9h às 18h', 'Gratuito', 4.7),
(2, 'Parque da Cidade', 'Grande área verde para lazer, esportes e passeios em família.', 'Asa Sul, Brasília - DF', -15.8028, -47.9292, 'Todos os dias', 'Gratuito', 4.9),
(6, 'Catedral Metropolitana', 'Obra arquitetônica marcante projetada por Oscar Niemeyer.', 'Esplanada dos Ministérios, Brasília - DF', -15.7989, -47.8756, 'Todos os dias, 8h às 18h', 'Gratuito', 4.8),
(3, 'Pontão do Lago Sul', 'Complexo de lazer e gastronomia às margens do Lago Paranoá.', 'SHIS QL 10, Lago Sul, Brasília - DF', -15.8346, -47.8723, 'Todos os dias, 10h às 00h', 'Variável', 4.8);

INSERT INTO local_tags (local_id, tag_id) VALUES
(1, 1), (1, 5), (1, 7), (1, 8),
(2, 4), (2, 7), (2, 8),
(3, 2), (3, 6), (3, 9), (3, 8),
(4, 1), (4, 5), (4, 7), (4, 8),
(5, 3), (5, 9), (5, 6);

INSERT INTO eventos (local_id, titulo, descricao, data_evento, horario) VALUES
(3, 'Festival Cultural', 'Evento com música, gastronomia e atrações para toda a família.', '2026-07-10', '18:00'),
(2, 'Exposição de Arte', 'Mostra artística no Museu Nacional.', '2026-07-15', '10:00'),
(5, 'Feira Gastronômica', 'Evento com restaurantes e food trucks no Pontão.', '2026-07-20', '17:00');