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

<div class="flex flex-col max-w-2xl min-h-screen mx-auto">
  <main class="w-full pt-16 pb-6 flex flex-col items-center">
    <FiniamLogo class="mb-20" />

    <slot />
  </main>

  <footer class="mt-auto">
    <p class="block mt-20 mx-auto text-center">
      Open source project. <a
        class="underline"
        href="https://github.com/finiam/secrets.finiam.com"
        target="_blank"
        rel="noopener"
        >Check the repository here
      </a>
    </p>

    <p class="block mt-4 mb-20 mx-auto text-center">
      Created secrets so far: {secretsCounter}
    </p>
  </footer>
</div>
