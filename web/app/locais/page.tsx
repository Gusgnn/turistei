import { getPlaces } from "@/lib/api";
import PlaceCard from "@/components/PlaceCard";

export default async function LocaisPage() {
  const places = await getPlaces();

  return (
    <main className="content">
      <h1>Locais turísticos</h1>

      <div className="grid">
        {places.map((place: any) => (
          <PlaceCard key={place.id} place={place} />
        ))}
      </div>
    </main>
  );
}