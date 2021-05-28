const API_URL = import.meta.env.VITE_API_URL;

export async function createSecret(secret: string): Promise<string> {
  const response = await fetch(`${API_URL}/api/secrets`, {
    method: 'POST',
    body: JSON.stringify({ secret }),
    headers: {
      'content-type': 'application/json'
    }
  });
  const body = await response.json();

  return body.room_id;
}

export async function getRoomSecret(room: string): Promise<string> {
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
