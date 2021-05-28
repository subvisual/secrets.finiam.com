<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';

  export const ssr = false;

  export const load: Load = async ({ page }) => {
    return { props: { room: page.params.room } };
  };
</script>

<script lang="ts">
  import { decryptData } from '$lib/crypto';
  import { getRoomSecret } from '$lib/api';

  export let room: string;

  async function revealSecret() {
    const secret = await getRoomSecret(room);
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
