<script lang="ts">
  // @hmr:keep-all
  import { goto } from '$app/navigation';
  import { createSecret } from '$lib/api';
  import copyToClipboard from '$lib/copyToClipboard';
  import Button from '$lib/components/Button.svelte';

  import { encryptData, generatePassphrase } from '$lib/crypto';

  let textToEncrypt: string;
  let encryptedText: string;
  let encryptionKey: string;
  let sharingUrl: string;
  let submitting: boolean;

  async function handleClick(event) {
    try {
      event.preventDefault();
      submitting = true;
      encryptionKey = generatePassphrase();
      encryptedText = await encryptData(textToEncrypt, encryptionKey);
      const room = await createSecret(encryptedText);
      sharingUrl = `${location.protocol}//${location.host}/${room}#${encryptionKey}`;
      submitting = false;
    } catch (_) {
      goto('/error');
    }
  }

  async function handleReset() {
    textToEncrypt = '';
    encryptedText = '';
    encryptionKey = '';
    sharingUrl = '';
    submitting = false;
  }

  function handleCopyClick() {
    copyToClipboard(sharingUrl);
  }
</script>

<p class="max-w-lg text-center mb-10">
  Finiam Secrets allows you to share information securely and ephemerally. The generated link will
  only work once and then it will disappear forever.
</p>

{#if sharingUrl && !submitting}
  <div class="flex flex-row items-center px-4 space-x-4">
    <button class="p-2 rounded-md bg-gray-200 mt-4" type="button" on:click={handleCopyClick}>
      Copy url to clipboard
    </button>

    <button class="p-2 rounded-md bg-gray-200 mt-4" on:click={handleReset}>
      Reset and try again
    </button>
  </div>
{:else}
  <form class="flex flex-col items-center w-full">
    <textarea
      class="border-2 border-gray-300 rounded-md p-4 w-4/5 h-64"
      name="secret"
      bind:value={textToEncrypt}
    />

    <div class="mt-4">
      {#if submitting}
        <div>Encrypting data...</div>
      {:else}
        <Button on:click={handleClick} disabled={!textToEncrypt}>Submit</Button>
      {/if}
    </div>
  </form>
{/if}
