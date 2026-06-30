import "./globals.css";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";

export const metadata = {
  title: "Turistei",
  description: "Explore Brasília de forma inteligente",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="pt-BR">
      <body>
        <Navbar />
        {children}
        <Footer />
      </body>
    </html>
  );
}