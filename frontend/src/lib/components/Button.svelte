<script lang="ts">
  import IconCopy from '$lib/components/IconCopy.svelte';

  let className: string;

  export { className as class };
  export let secondary = false;
  export let copy = false;

  $: buttonType = !secondary ? 'bg-brand text-white' : 'bg-white text-brand border border-brand';
</script>

<button
  class={`p-3 ${buttonType} rounded text-white disabled:opacity-20 disabled:cursor-not-allowed ${className}`}
  on:click
  {...$$restProps}
>
  {#if copy}
    <div class="flex items-center space-x-2">
      <IconCopy />
      <span><slot /></span>
    </div>
  {:else}
    <slot />
  {/if}
</button>
