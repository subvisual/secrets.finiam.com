<script lang="ts">
  let className: string;

  export { className as class };
  export let secondary = false;

  $: buttonType = !secondary ? "bg-brand text-white" : "bg-white text-brand border border-brand"
</script>

<button
  class={`p-3 ${buttonType} rounded text-white disabled:opacity-20 disabled:cursor-not-allowed ${className}`}
  on:click
  {...$$restProps}
>
  <slot />
</button>
