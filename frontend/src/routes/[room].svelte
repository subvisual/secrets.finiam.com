<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';

  export const ssr = false;

  export const load: Load = async ({ page }) => {
    return { props: { room: page.params.room } };
  };
</script>

<script lang="ts">
  import { decryptData } from '$lib/crypto';

  export let room: string;
  let secret: string;

  async function getRoomSecret(): Promise<string> {
    let response: Response;

    try {
      response = await fetch(`/api/secrets?id=${room}`, { method: 'GET' });
      secret = (await response.json()).secret;
    } catch (_) {
      throw 'Something exploded!';
    }

    if (response.status === 404) throw 'No such secret!';
    else if (response.status !== 200) throw 'Something exploded!';

    return secret;
  }

  async function revealSecret() {
    const secret = await getRoomSecret();
    const encryptionKey = location.hash.substring(1);

    try {
      return await decryptData(secret, encryptionKey);
    } catch (_) {
      throw 'Hey, this private key is not correct!';
    }
  }
</script>

{#await revealSecret()}
  Loading...
{:then revealedSecret}
  Your secret:
  <p>{revealedSecret}</p>
{:catch error}
  Error: {error}
{/await}
