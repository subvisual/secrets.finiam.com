<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';

  export const ssr = false;

  export const load: Load = async ({ page }) => {
    return {
      props: { room: page.params.room, roomExists: await checkIfRoomExists(page.params.room) }
    };
  };
</script>

<script lang="ts">
  // @hmr:keep-all
  import { decryptData } from '$lib/crypto';
  import { getRoomSecret, checkIfRoomExists } from '$lib/api';
  import { goto } from '$app/navigation';

  export let room: string;
  export let roomExists: boolean;
  let loading = false;
  let decryptedSecret: string;

  async function revealSecret() {
    loading = true;
    const secret = await getRoomSecret(room);
    const encryptionKey = location.hash.substring(1);

    try {
      decryptedSecret = await decryptData(secret, encryptionKey);
      loading = false;
    } catch (_) {
      goto('/error');
    }
  }
</script>

<main class="max-w-2xl mx-auto pt-24 pb-6 flex flex-col items-center">
  {#if !roomExists}
    <p>This secret was either already revealed or never existed in the first place!</p>
  {:else if !loading && !decryptedSecret}
    <p class="mb-10">The following secret can only be revealed once!</p>

    <button on:click={revealSecret}>Reveal the secret</button>
  {:else if loading}
    Loading...
  {:else if decryptedSecret}
    <h1 class="font-bold text-xl mb-8">Your secret</h1>
    <div class="border-2 border-gray-300 rounded-md p-4 w-1/2 cursor-not-allowed">
      {decryptedSecret}
    </div>
  {/if}
</main>
