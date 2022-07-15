<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';
  import { getStats } from '$lib/api';

  export const load: Load = async () => {
    const stats = await getStats();

    return {
      props: stats
    };
  };
</script>

<script lang="ts">
  import FiniamLogo from '$lib/components/FiniamLogo.svelte';
  import '../app.css';

  export let secretsCounter: number;
</script>

<svelte:head>
  <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
</svelte:head>

<div class="mx-auto flex min-h-screen max-w-2xl flex-col">
  <main class="flex w-full flex-col items-center pt-16 pb-6">
    <FiniamLogo class="mb-20" />

    <slot />
  </main>

  <footer class="mt-auto">
    <p class="mx-auto mt-20 block text-center">
      Open source project. <a
        class="underline"
        href="https://github.com/finiam/secrets.finiam.com"
        target="_blank"
        rel="noopener"
        >Check the repository here
      </a>
    </p>

    <p class="mx-auto mt-8 mb-20 block text-center text-sm text-gray-500">
      Created secrets so far: {secretsCounter}
    </p>
  </footer>
</div>
