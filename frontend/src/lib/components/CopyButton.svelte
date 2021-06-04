<script lang="ts">
  import copyToClipboard from '$lib/copyToClipboard';
  import IconCopy from '$lib/components/IconCopy.svelte';

  let className: string;

  export { className as class };
  export let value: string;
  export let copied = false;

  $: buttonType = !copied ? 'bg-brand text-white' : 'bg-white text-brand border border-brand';

  function handleCopyClick() {
    copied = true;
    copyToClipboard(value);
  }
</script>

<button
  class={`p-3 ${buttonType} rounded text-white disabled:opacity-20 disabled:cursor-not-allowed ${className}`}
  on:click={handleCopyClick}
  {...$$restProps}
>
  {#if !copied}
    <div class="flex items-center space-x-2">
      <IconCopy />
      <span><slot /></span>
    </div>
  {:else}
    Copied!
  {/if}
</button>
