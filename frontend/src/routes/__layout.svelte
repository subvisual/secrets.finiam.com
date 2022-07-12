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
  import SecretsLogo from '$lib/components/SecretsLogo.svelte';
  import IconChevron from '$lib/components/IconChevron.svelte';
  import FiniamI from '$lib/components/FiniamI.svelte';
  import FiniamM from '$lib/components/FiniamM.svelte';
  import '../app.css';

  export let secretsCounter: number;

  let toggleOpen = false;
  const toggleInfo = () => (toggleOpen = !toggleOpen);
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

  <div
    class="mx-auto flex min-h-screen w-full flex-col justify-between py-6 sm:w-5/6 md:gap-6 md:pt-8"
  >
    <main class="mb-16 flex w-full flex-col items-center md:mb-3">
      <a href="/" class="outline-dark-grey">
        <SecretsLogo class="fill-green mb-6 w-36 md:mb-6 md:w-48" />
      </a>
      <slot />
    </main>

    <footer
      class="mx-auto grid w-full grid-flow-row grid-cols-none gap-6 self-end justify-self-end px-5 tracking-tight md:grid-cols-2 md:grid-rows-none"
    >
      <div class="flex flex-col {toggleOpen ? 'self-start' : 'self-end'}">
        <button on:click={toggleInfo} class="mx-auto flex items-center gap-1 text-sm"
          >How it works <IconChevron class="{toggleOpen && 'rotate-180'} transition-all " />
        </button>

        <p
          id="info"
          class="{toggleOpen
            ? 'block'
            : 'hidden'}  mx-auto my-3 w-4/5 text-justify text-xs sm:text-xs"
        >
          Finiam Secrets transmits E2E messages safely by encrypting the user info locally and then
          generating a URL with a private key embbeded on it, through the hash in the URL, which is
          never sent to servers by browsers or any HTTP client. When you generate a secret, the
          webapp posts the encrypted information to our API, which in turn stores that encrypted
          information. Each secret can only be opened once - secrets get destroyed after they have
          been opened or after they expire.
        </p>
      </div>

      <div class="flex flex-col gap-3 sm:relative">
        <p class="flex items-center justify-center gap-1 text-center text-xs md:flex-row md:gap-2">
          Secrets created so far:
          {secretsCounter}
        </p>
        <p class="text-center text-xs decoration-1">
          <a
            class="outline-dark-grey hover:text-green underline underline-offset-1 "
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
      </div>
    </footer>
  </div>
</div>
