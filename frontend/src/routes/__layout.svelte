<script>
  import FiniamLogo from '$lib/components/FiniamLogo.svelte';
  import '../app.css';
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
    <p class="block my-20 mx-auto text-center">
      Open source project. <a
        class="underline"
        href="https://github.com/finiam/secrets.finiam.com"
        target="_blank"
        rel="noopener"
        >Check the repository here
      </a>
    </p>
  </footer>
</div>
