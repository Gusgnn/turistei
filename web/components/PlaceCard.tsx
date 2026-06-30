export default function PlaceCard({ place }: { place: any }) {
  return (
    <div className="card">
      <h2>{place.nome}</h2>
      <p>{place.descricao || "Sem descrição cadastrada."}</p>
      <p>
        <strong>Endereço:</strong> {place.endereco || "Não informado"}
      </p>
      <p>
        <strong>Avaliação:</strong> ⭐{" "}
        {place.avaliacao_media || "Sem avaliação"}
      </p>
    </div>
  );
}