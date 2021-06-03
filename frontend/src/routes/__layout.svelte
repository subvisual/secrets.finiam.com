<script>
  import FiniamLogo from '$lib/components/FiniamLogo.svelte';
  import '../app.css';
</script>

<main class="max-w-2xl mx-auto pt-24 pb-6 flex flex-col items-center">
  <FiniamLogo class="mb-20" />

  <slot />
</main>
