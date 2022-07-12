<script context="module" lang="ts">
  import type { Load } from '@sveltejs/kit';
  import Button from '$lib/components/Button.svelte';
  import { getStats } from '$lib/api';
  export const load: Load = async () => {
    const stats = await getStats();

    return {
      props: stats
    };
  };
</script>

<script lang="ts">
  import SecretsLogo from '$lib/components/SecretsLogo.svelte';
  import FiniamI from '$lib/components/FiniamI.svelte';
  import FiniamM from '$lib/components/FiniamM.svelte';
  import '../app.css';

  export let secretsCounter: number;

  let isPopupOpen = false;
  const togglePopup = () => (isPopupOpen = !isPopupOpen);
</script>

<svelte:head>
  <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
</svelte:head>

<div
  class="bg-smoked-white font-body outline-dark-grey text-dark-grey h-full w-full overflow-hidden tracking-tighter antialiased"
>
  <div class="relative float-left hidden h-full w-1/5 md:block ">
    <FiniamI class="absolute -left-10 -top-12" />
  </div>
  <div class="relative float-right hidden h-full w-1/5 md:block">
    <FiniamM class="absolute -right-8" />
  </div>

  <div class="mx-auto flex min-h-screen w-full flex-col py-6 sm:w-5/6 md:pt-10">
    <main class="mb-16 flex w-full grow flex-col items-center md:mb-4">
      <a href="/" class="outline-dark-grey">
        <SecretsLogo class="mb-6 w-36 md:mb-10 md:w-48" />
      </a>
      <slot />
    </main>

    <footer
      class="m-auto flex w-full flex-col items-center justify-around gap-4 px-5 tracking-tight md:flex-row md:gap-12"
    >
      <p class="text-center text-sm decoration-1">
        <a
          class="outline-dark-grey hover:text-green underline"
          href="https://github.com/finiam/secrets.finiam.com"
          target="_blank"
          rel="noopener"
          >Open source project
        </a>
        powered by
        <a
          class="outline-dark-grey hover:text-green font-medium"
          href="https://finiam.com/"
          target="_blank"
          rel="noreferrer"
          >Finiam
        </a>
      </p>

      <p class="flex items-center justify-center gap-2 text-center text-sm md:flex-row md:gap-3">
        Secrets created so far:
        <span class="bg-pink inline-flex h-12 w-12 items-center justify-center rounded-full">
          {secretsCounter}
        </span>
      </p>
    </footer>
  </div>
</div>
