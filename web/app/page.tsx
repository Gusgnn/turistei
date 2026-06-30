import Link from "next/link";

export default function Home() {
  return (
    <main className="app-home">
      <section className="app-hero">
        <div className="app-text">
          <span className="badge">Turistei</span>

          <h1>
            Explore Brasília
            <br />
            de forma inteligente
          </h1>

          <p>
            Encontre pontos turísticos, eventos, categorias, roteiros e
            recomendações em um único lugar.
          </p>

          <div className="buttons">
            <Link href="/locais">Explorar locais</Link>
            <Link href="/eventos">Ver eventos</Link>
          </div>
        </div>

        <div className="phone">
          <div className="phone-top"></div>

          <div className="phone-content">
            <h3>Olá, viajante 👋</h3>
            <p>O que deseja conhecer hoje?</p>

            <div className="search-box">Pesquisar em Brasília...</div>

            <div className="mini-grid">
              <div>🏛️ Cultura</div>
              <div>🌳 Parques</div>
              <div>🍽️ Gastronomia</div>
              <div>🎭 Eventos</div>
            </div>

            <div className="place-preview">
              <strong>Pontão do Lago Sul</strong>
              <span>⭐ 4.9 • Brasília</span>
            </div>

            <div className="place-preview">
              <strong>Catedral Metropolitana</strong>
              <span>⭐ 4.8 • Turismo cívico</span>
            </div>
          </div>
        </div>
      </section>
    </main>
  );
}