<script lang="ts">
  import type { LayoutData } from './$types';
  import SecretsLogo from '$lib/components/SecretsLogo.svelte';
  import FiniamI from '$lib/components/FiniamI.svelte';
  import FiniamM from '$lib/components/FiniamM.svelte';
  import '../app.css';

  export let data: LayoutData;
  let { secretsCounter } = data;
</script>

<svelte:head>
  <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
</svelte:head>

<div
  class="h-full w-full overflow-hidden bg-smoked-white font-body tracking-tight text-dark-grey antialiased outline-dark-grey"
>
  <div class="relative float-left hidden h-full w-1/5 md:block ">
    <FiniamI class="pointer-events-none absolute -top-20 -left-12 lg:-left-0 lg:-top-20" />
  </div>
  <div class="relative float-right hidden h-full w-1/5 md:block">
    <FiniamM class="pointer-events-none absolute -right-16 -top-8 lg:-right-10 lg:-top-6" />
  </div>

  <div
    class="mx-auto flex min-h-screen w-full flex-col justify-between gap-6 py-6 sm:w-5/6 md:gap-0 md:pt-8"
  >
    <main class="flex w-full grow flex-col items-center md:mb-3">
      <a href="/" class="outline-dark-grey">
        <SecretsLogo class="mb-6 w-36 fill-green md:mb-6 md:w-48" />
      </a>
      <slot />
    </main>

    <footer
      class="mx-auto flex w-7/12 flex-col items-center justify-between gap-6 justify-self-end text-sm tracking-tight md:flex-row"
    >
      <p class="whitespace-nowrap text-center">
        <a
          class="underline decoration-1 underline-offset-1 outline-dark-grey hover:text-green"
          href="https://github.com/finiam/secrets.finiam.com"
          target="_blank"
          rel="noopener"
          >Open source project
        </a>
        powered by
        <a
          class="font-medium outline-dark-grey hover:text-green"
          href="https://finiam.com/"
          target="_blank"
          rel="noreferrer"
          >Finiam
        </a>
      </p>

      <p
        class="flex items-center justify-center gap-1 whitespace-nowrap text-center md:flex-row md:gap-2"
      >
        Secrets created so far:
        <span class="inline-flex h-11 w-11 items-center justify-center rounded-full bg-pink">
          {secretsCounter}
        </span>
      </p>
    </footer>
  </div>
</div>
