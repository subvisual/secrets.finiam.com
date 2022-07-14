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
    @apply flex items-center rounded bg-brand p-3 text-white;
  }

  button.secondary {
    @apply border border-brand bg-white text-brand;
  }

  button:disabled {
    @apply cursor-not-allowed opacity-20;
  }

  button.loading {
    @apply cursor-wait opacity-20;
  }
</style>
