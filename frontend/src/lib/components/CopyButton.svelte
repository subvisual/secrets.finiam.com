<script lang="ts">
  import copyToClipboard from '$lib/copyToClipboard';
  import IconCopy from './IconCopy.svelte';
  import IconCopySuccess from './IconCopySuccess.svelte';
  import Button from './Button.svelte';

  export let value: string;
  export let copied = false;

  function handleCopyClick() {
    copied = true;
    copyToClipboard(value);
  }
</script>

{#if !copied}
  <Button {...$$restProps} on:click={handleCopyClick}>
    <IconCopy slot="leftIcon" />
    <slot />
  </Button>
{:else}
  <Button {...$$restProps} on:click={handleCopyClick}>
    <IconCopySuccess slot="leftIcon" />
    Copied!
  </Button>
{/if}
