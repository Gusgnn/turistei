export default function LoginPage() {
  return (
    <main className="content">
      <h1>Login</h1>

      <div className="card form-card">
        <label>E-mail</label>
        <input type="email" placeholder="usuario@email.com" />

        <label>Senha</label>
        <input type="password" placeholder="Digite sua senha" />

        <button>Entrar</button>
      </div>
    </main>
  );
}