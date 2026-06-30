import Link from "next/link";

export default function Navbar() {
  return (
    <nav className="navbar">
      <Link href="/" className="logo">
        Turistei
      </Link>

      <div>
        <Link href="/">Home</Link>
        <Link href="/locais">Locais</Link>
        <Link href="/eventos">Eventos</Link>
        <Link href="/categorias">Categorias</Link>
        <Link href="/sobre">Sobre</Link>
        <Link href="/login">Login</Link>
      </div>
    </nav>
  );
}