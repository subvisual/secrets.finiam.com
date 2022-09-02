const API_URL = import.meta.env.VITE_API_URL;

export type fetchType = (info: RequestInfo, init?: RequestInit) => Promise<Response>;

export async function createSecret(
  {
    secret,
    expiry
  }: {
    secret: string;
    expiry: number;
  },
  fetch = globalThis.fetch
): Promise<string> {
  const response = await fetch(`${API_URL}/api/secrets`, {
    method: 'POST',
    body: JSON.stringify({ secret, expiry }),
    headers: {
      'content-type': 'application/json'
    }
  });
  const body = await response.json();

  if (response.status !== 200) throw 'Something exploded!';

  return body.room_id;
}

export async function checkIfRoomExists(room: string, fetch = globalThis.fetch): Promise<boolean> {
  const response = await fetch(`${API_URL}/api/secrets/${room}`, { method: 'HEAD' });

  return response.status === 200;
}

export async function getRoomSecret(room: string, fetch = globalThis.fetch): Promise<string> {
  let response, body;

  try {
    response = await fetch(`${API_URL}/api/secrets/${room}`, { method: 'GET' });
    body = await response.json();
  } catch (error) {
    throw 'Something exploded!';
  }

  if (response.status === 404) throw 'No such secret!';
  else if (response.status !== 200) throw 'Something exploded!';

  return body.secret;
}

export async function deleteSecret(room: string, fetch = globalThis.fetch): Promise<void> {
  try {
    await fetch(`${API_URL}/api/secrets/${room}`, { method: 'DELETE' });
  } catch (error) {
    throw 'Something exploded!';
  }
}

export async function getStats(fetch = globalThis.fetch): Promise<{ secretsCounter: string }> {
  try {
    const response = await fetch(`${API_URL}/api/stats`);
    const json = await response.json();

    return { secretsCounter: json.secrets_counter };
  } catch (error) {
    throw 'Something exploded!';
  }
}
