export default function CategoryCard({ category }: { category: any }) {
  return (
    <div className="card category-card">
      <h2>{category.nome}</h2>
      <p>{category.descricao || "Categoria turística do Turistei."}</p>
    </div>
  );
}