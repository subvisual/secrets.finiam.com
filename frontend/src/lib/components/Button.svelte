<script lang="ts">
  let className: string;

  export { className as class };
</script>

<button
  class={`p-3 bg-brand rounded text-white disabled:opacity-40 disabled:cursor-not-allowed ${className}`}
  {...$$restProps}
>
  <slot />
</button>
