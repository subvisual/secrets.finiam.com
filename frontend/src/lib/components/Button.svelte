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
    @apply flex items-center whitespace-nowrap rounded-full bg-green py-4 px-7 tracking-tight text-smoked-white outline-dark-grey;
  }

  button.secondary {
    @apply bg-pistachio text-dark-grey;
  }

  button:disabled {
    @apply cursor-not-allowed opacity-60;
  }

  button.loading {
    @apply cursor-wait opacity-60;
  }
</style>
