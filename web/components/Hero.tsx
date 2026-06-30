import Link from "next/link";

export default function Hero() {
  return (
    <section className="hero">
      <h1>Turistei</h1>
      <p>Explore Brasília de forma inteligente.</p>

      <div className="buttons">
        <Link href="/locais">Ver locais</Link>
        <Link href="/eventos">Ver eventos</Link>
        <Link href="/sobre">Sobre o projeto</Link>
      </div>
    </section>
  );
}