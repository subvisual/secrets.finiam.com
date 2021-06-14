<script lang="ts">
  export let secondary = false;
  export let loading = false;
  export let disabled = false;
</script>

<button {...$$restProps} class:secondary class:loading disabled={loading || disabled} on:click>
  {#if $$slots.leftIcon}
    <div class="mr-2">
      <slot name="leftIcon" />
    </div>
  {/if}

  <slot />
</button>

<style>
  button {
    @apply flex items-center p-3 rounded bg-brand text-white;
  }

  button.secondary {
    @apply bg-white text-brand border border-brand;
  }

  button:disabled {
    @apply opacity-20 cursor-not-allowed;
  }

  button.loading {
    @apply opacity-20 cursor-wait;
  }
</style>
