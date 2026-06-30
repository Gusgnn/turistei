const API_URL = "http://localhost:3000/api";

export async function getPlaces() {
  const res = await fetch(`${API_URL}/places`, { cache: "no-store" });
  const json = await res.json();
  return json.data || json;
}

export async function getEvents() {
  const res = await fetch(`${API_URL}/events`, { cache: "no-store" });
  const json = await res.json();
  return json.data || json;
}

export async function getCategories() {
  const res = await fetch(`${API_URL}/categories`, { cache: "no-store" });
  const json = await res.json();
  return json.data || json;
}