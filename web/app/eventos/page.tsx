import { getEvents } from "@/lib/api";
import EventCard from "@/components/EventCard";

export default async function EventosPage() {
  const events = await getEvents();

  return (
    <main className="content">
      <h1>Eventos</h1>

      <div className="grid">
        {events.map((event: any) => (
          <EventCard key={event.id} event={event} />
        ))}
      </div>
    </main>
  );
}