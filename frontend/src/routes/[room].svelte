<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';

  export const load: Load = async ({ params }) => {
    return {
      props: { room: params.room, roomExists: await checkIfRoomExists(params.room) }
    };
  };
</script>

<script lang="ts">
  // @hmr:keep-all
  import SEO from '$lib/components/SEO.svelte';
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

<SEO
  title="Finiam Secrets"
  description="Finiam Secrets allows you to share information securely and ephemerally. The generated link will only work once and then it will disappear forever."
  keywords="secrets,share,end-to-end,encryption,finiam"
/>

<div class="flex w-full flex-col items-center">
  {#if !roomExists}
    <div class="flex w-full flex-col items-center space-y-10">
      <p class="w-4/5 text-center">
        This secret was either already revealed or never existed in the first place!
      </p>
      <Button on:click={createNewSecret}>Create a new secret</Button>
    </div>
  {:else if !loading && !decryptedSecret}
    <p class="mb-10 w-4/5 text-center">The following secret can only be revealed once!</p>

    <Button on:click={revealSecret}>Reveal the secret</Button>
  {:else if loading}
    Loading...
  {:else if decryptedSecret}
    <p class="mb-10 w-4/5 text-center">
      Your secret was revealed and permanently deleted from the system 🔥
    </p>
    <div
      class="w-4/5 cursor-not-allowed whitespace-pre-wrap break-words rounded-md border border-gray-300 p-4"
    >
      {decryptedSecret}
    </div>

    <div class="mt-10 flex flex-row space-x-4">
      <CopyButton value={decryptedSecret}>Copy information</CopyButton>
      <Button on:click={createNewSecret} secondary>Create a new secret</Button>
    </div>
  {/if}
</div>
