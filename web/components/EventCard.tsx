export default function EventCard({ event }: { event: any }) {
  return (
    <div className="card">
      <h2>{event.titulo || event.nome}</h2>
      <p>{event.descricao || "Sem descrição cadastrada."}</p>
      <p>
        <strong>Data:</strong>{" "}
        {event.data_evento || event.data_inicio || "Não informada"}
      </p>
    </div>
  );
}