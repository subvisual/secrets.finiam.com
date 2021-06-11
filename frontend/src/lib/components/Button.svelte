<script lang="ts">
  export let secondary = false;

  $: buttonBaseClasses = !secondary
    ? 'bg-brand text-white'
    : 'bg-white text-brand border border-brand';
</script>

<button
  class={`p-3 ${buttonBaseClasses} rounded text-white disabled:opacity-20 disabled:cursor-not-allowed ${$$props.class}`}
  on:click
  {...$$restProps}
>
  <slot />
</button>
