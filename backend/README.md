# 🗺️ Turistei - Backend

## Sobre o Projeto

O **Turistei** é uma API REST desenvolvida como parte do **Projeto Integrador IV** do curso de **Análise e Desenvolvimento de Sistemas do UniCEUB**.

O sistema tem como objetivo centralizar informações sobre pontos turísticos, eventos e serviços turísticos de Brasília, permitindo que aplicações Web e Mobile consumam esses dados por meio de uma API segura, organizada e documentada.

---

## Funcionalidades

- Cadastro e autenticação de usuários
- Gerenciamento de categorias
- Cadastro de pontos turísticos
- Busca e consulta de locais
- Sistema de favoritos
- Avaliações de locais
- Gerenciamento de eventos
- Notificações para usuários
- Roteiros personalizados
- Documentação da API com Swagger

---

## Tecnologias Utilizadas

- Node.js
- Express.js
- PostgreSQL
- JWT (JSON Web Token)
- bcrypt
- Jest
- Supertest
- Swagger (OpenAPI)

---

## Estrutura do Projeto

```text
backend/
│
├── src/
│   ├── auth/
│   ├── users/
│   ├── categories/
│   ├── places/
│   ├── favorites/
│   ├── reviews/
│   ├── events/
│   ├── notifications/
│   ├── itineraries/
│   └── common/
│
├── database/
│   ├── migrations/
│   └── seeds/
│
├── tests/
│
├── app.js
├── server.js
└── package.json
```

---

## Pré-requisitos

Antes de executar o projeto é necessário possuir instalado:

- Node.js
- PostgreSQL
- npm

---

## Instalação

Clone o repositório:

```bash
git clone https://github.com/Gusgnn/turistei
```

Entre na pasta do projeto:

```bash
cd backend
```

Instale as dependências:

```bash
npm install
```

---

## Configuração

Crie um arquivo `.env` na raiz do projeto contendo as configurações do banco de dados e da aplicação.

Exemplo:

```env
PORT=3000

DB_HOST=localhost
DB_PORT=5432
DB_NAME=turistei
DB_USER=postgres
DB_PASSWORD=sua_senha

JWT_SECRET=sua_chave_secreta
```

---

## Banco de Dados

Após criar o banco de dados e executar as migrations, utilize o comando abaixo para inserir dados de exemplo:

```bash
npm run seed
```

---

## Executando o Projeto

Modo desenvolvimento:

```bash
npm run dev
```

Modo produção:

```bash
npm start
```

---

## Testes

Executar todos os testes:

```bash
npm test
```

Gerar relatório de cobertura:

```bash
npm run test:coverage
```

Atualmente o projeto possui:

- 9 suítes de testes
- 38 testes automatizados

---

## Documentação da API

Após iniciar o servidor, a documentação da API estará disponível em:

```text
http://localhost:3000/api-docs
```

---

## Arquitetura

O projeto utiliza arquitetura em camadas:

```text
Routes
   ↓
Validation
   ↓
Controller
   ↓
Service
   ↓
Repository
   ↓
PostgreSQL
```

Além disso, utiliza DTOs, Mappers, Middlewares e tratamento centralizado de erros para manter a organização e facilitar a manutenção do código.

---

## Equipe

Projeto desenvolvido para a disciplina **Projeto Integrador IV** – UniCEUB.

Integrantes:

- Gustavo Gerhardt Neumann
- Artur Allan de Souza Goes
- Gabriel Negreiros dos Santos
- Douglas Amori Ribeiro

---

## Licença

Este projeto foi desenvolvido para fins acadêmicos.