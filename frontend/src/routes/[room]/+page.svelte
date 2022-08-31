<script lang="ts">
  import type { PageData } from './$types';
  import SEO from '$lib/components/SEO.svelte';
  import Button from '$lib/components/Button.svelte';
  import CopyButton from '$lib/components/CopyButton.svelte';
  import { decryptData } from '$lib/crypto';
  import { getRoomSecret } from '$lib/api';
  import { goto } from '$app/navigation';

  export let data: PageData;
  let { room, roomExists } = data;
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

<div class="flex w-full flex-col items-center justify-between gap-8">
  {#if !roomExists}
    <p class="w-4/5 text-center md:w-7/12">
      This secret was either already revealed or never existed in the first place!
    </p>
    <Button on:click={createNewSecret}>Create a new secret</Button>
  {:else if !loading && !decryptedSecret}
    <p class="w-4/5 text-center md:w-7/12">The following secret can only be revealed once!</p>
    <Button on:click={revealSecret}>Reveal the secret</Button>
  {:else if loading}
    Loading...
  {:else if decryptedSecret}
    <p class="w-4/5 text-center md:w-7/12">
      Your secret was revealed and permanently deleted from the system 🔥
    </p>

    <div
      class="w-4/5 cursor-not-allowed whitespace-pre-wrap break-words rounded-xl bg-white p-4 font-sans tracking-tight md:w-7/12"
    >
      {decryptedSecret}
    </div>
    <div class="flex flex-wrap items-center justify-center gap-3 px-4 md:gap-5">
      <CopyButton value={decryptedSecret}>Copy information</CopyButton>
      <Button on:click={createNewSecret} secondary>Create a new secret</Button>
    </div>
  {/if}
</div>
