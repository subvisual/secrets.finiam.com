<script>
  import FiniamLogo from '$lib/components/FiniamLogo.svelte';
  import '../app.css';
</script>

<svelte:head>
  <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
</svelte:head>

<main class="max-w-2xl mx-auto pt-16 pb-6 flex flex-col items-center min-h-screen">
  <FiniamLogo class="mb-20" />

  <slot />

  <p class="block mt-auto pt-20 mb-20 mx-auto text-center">
    Open source project. <a
      class="underline"
      href="https://github.com/finiam/secrets.finiam.com"
      target="_blank"
      rel="noopener"
      >Check the repository here
    </a>
  </p>
</main>
