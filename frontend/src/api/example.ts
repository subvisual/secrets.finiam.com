import redaxios from "redaxios";

export default async function getExample(): Promise<any> {
  const response = await redaxios.get("/api/example");

  return response.data;
}
