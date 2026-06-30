import { getCategories } from "@/lib/api";
import CategoryCard from "@/components/CategoryCard";

export default async function CategoriasPage() {
  const categories = await getCategories();

  return (
    <main className="content">
      <h1>Categorias</h1>

      <div className="grid">
        {categories.map((category: any) => (
          <CategoryCard key={category.id} category={category} />
        ))}
      </div>
    </main>
  );
}