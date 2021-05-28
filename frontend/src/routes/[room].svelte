<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';

  export const ssr = false;

  export const load: Load = async ({ page }) => {
    return { props: { room: page.params.room } };
  };
</script>

<script lang="ts">
  // @hmr:keep-all
  import { decryptData } from '$lib/crypto';
  import { getRoomSecret } from '$lib/api';
  import { onMount } from 'svelte';

  export let room: string;
  let loading = true;
  let decryptedSecret: string;
  let error: string;

  async function revealSecret() {
    const secret = await getRoomSecret(room);
    const encryptionKey = location.hash.substring(1);

    try {
      return await decryptData(secret, encryptionKey);
    } catch (_) {
      throw 'Hey, this private key is not correct!';
    }
  }

  onMount(() => {
    revealSecret()
      .then((res) => (decryptedSecret = res))
      .catch((res) => (error = res))
      .finally(() => (loading = false));
  });
</script>

<main class="max-w-2xl mx-auto pt-24 pb-6 flex flex-col items-center">
  {#if loading}
    Loading...
  {:else if decryptedSecret}
    <h1 class="font-bold text-xl mb-8">Your secret</h1>
    <div class="border-2 border-gray-300 rounded-md p-4 w-1/2 cursor-not-allowed">
      {decryptedSecret}
    </div>
  {:else}
    <div class="text-center">
      <p class="font-bold text-xl">Error</p>
      <p class="mt-8">{error}</p>
    </div>
  {/if}
</main>
