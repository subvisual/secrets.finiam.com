<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';

  export const load: Load = async ({ page, fetch }) => {
    const response = await fetch(`/api/secrets?id=${page.params.room}`, { method: 'GET' });
    const body = await response.json();

    return { props: { secret: body.secret } };
  };
</script>

<script lang="ts">
  import { decryptData } from '$lib/crypto';
  import { onMount } from 'svelte';

  export let secret: string;
  let revealedSecret: string;

  onMount(async () => {
    const encryptionKey = location.hash.substring(1);
    revealedSecret = await decryptData(secret, encryptionKey);
  });
</script>

{#if revealedSecret}
  Your secret:
  <p>{revealedSecret}</p>
{:else}
  Loading...
{/if}
