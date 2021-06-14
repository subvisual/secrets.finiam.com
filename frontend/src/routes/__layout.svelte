<script>
  import FiniamLogo from '$lib/components/FiniamLogo.svelte';
  import '../app.css';
</script>

<svelte:head>
  <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
</svelte:head>

<main class="max-w-2xl mx-auto pt-16 pb-6 flex flex-col items-center">
  <FiniamLogo class="mb-20" />

  <slot />
</main>
