<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';

  export const load: Load = async ({ page }) => {
    return {
      props: { room: page.params.room, roomExists: await checkIfRoomExists(page.params.room) }
    };
  };
</script>

<script lang="ts">
  // @hmr:keep-all
  import Button from '$lib/components/Button.svelte';
  import CopyButton from '$lib/components/CopyButton.svelte';
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

  function createNewSecret() {
    goto('/');
  }
</script>

<div class="w-full flex flex-col items-center">
  {#if !roomExists}
    <div class="w-full flex flex-col items-center space-y-10">
      <p class="w-4/5 text-center">
        This secret was either already revealed or never existed in the first place!
      </p>
      <Button on:click={createNewSecret}>Create a new secret</Button>
    </div>
  {:else if !loading && !decryptedSecret}
    <p class="w-4/5 text-center mb-10">The following secret can only be revealed once!</p>

    <Button on:click={revealSecret}>Reveal the secret</Button>
  {:else if loading}
    Loading...
  {:else if decryptedSecret}
    <p class="w-4/5 text-center mb-10">
      Your secret was revealed and permanently deleted from the system 🔥
    </p>
    <div class="border border-gray-300 rounded-md p-4 w-4/5 cursor-not-allowed">
      {decryptedSecret}
    </div>

    <div class="flex flex-row space-x-4 mt-10">
      <CopyButton value={decryptedSecret}>Copy information</CopyButton>
      <Button on:click={createNewSecret} secondary>Create a new secret</Button>
    </div>
  {/if}
</div>
