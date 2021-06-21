<script lang="ts">
  // @hmr:keep-all
  import { goto } from '$app/navigation';
  import { createSecret, deleteSecret } from '$lib/api';
  import Button from '$lib/components/Button.svelte';
  import CopyButton from '$lib/components/CopyButton.svelte';
  import SEO from '$lib/components/SEO.svelte';

  import { encryptData, generatePassphrase } from '$lib/crypto';

  let textToEncrypt: string;
  let encryptedText: string;
  let encryptionKey: string;
  let sharingUrl: string;
  let submitting: boolean;
  let deleting: boolean;
  let roomId: string;
  let expiry: string;

  async function handleClick(event: { preventDefault: () => void }) {
    try {
      event.preventDefault();
      submitting = true;
      encryptionKey = generatePassphrase();
      encryptedText = await encryptData(textToEncrypt, encryptionKey);
      roomId = await createSecret({ secret: encryptedText, expiry: Number(expiry) });
      sharingUrl = `${location.protocol}//${location.host}/${roomId}#${encryptionKey}`;
      submitting = false;
    } catch (_) {
      goto('/error');
    }
  }

  async function handleReset() {
    deleting = true;
    await deleteSecret(roomId);
    deleting = false;
    textToEncrypt = '';
    encryptedText = '';
    encryptionKey = '';
    sharingUrl = '';
    submitting = false;
  }
</script>

<SEO
  title="Finiam Secrets"
  description="Finiam Secrets allows you to share information securely and ephemerally. The generated link will only work once and then it will disappear forever."
  keywords="secrets,share,end-to-end,encryption,finiam"
/>

{#if sharingUrl && !submitting}
  <div class="flex flex-col items-center w-full">
    <p class="max-w-lg w-4/5 text-center mb-10">
      As soon as someone opens the link, it will be destroyed automatically, ensuring full
      protection of your information.
    </p>

    <div class="border-2 border-gray-300 rounded-md p-4 w-4/5 mb-10">
      <p class="w-full truncate">{sharingUrl}</p>
    </div>
    <div class="flex flex-row items-center px-4 space-x-4">
      <CopyButton value={sharingUrl}>Copy link</CopyButton>

      <Button class="bg-gray-200" secondary on:click={handleReset} loading={deleting}
        >Reset and try again</Button
      >
    </div>
  </div>
{:else}
  <div class="flex flex-col items-center w-full">
    <p class="max-w-lg w-4/5 text-center mb-10">
      Finiam Secrets allows you to share information securely and ephemerally. The generated link
      will only work once and then it will disappear forever.
    </p>
    <form class="flex flex-col items-center w-full">
      <textarea
        class="border-2 border-gray-300 rounded-md p-4 w-4/5 h-64"
        name="secret"
        placeholder="Your information..."
        bind:value={textToEncrypt}
      />

      <div class="w-full mx-8 mt-8">
        <p class="text-lg">Secret lifetime</p>

        <div class="flex">
          <p>
            This link is valid for
            <select
              name="expiry"
              class="border-gray-400 border-2 p-2 rounded cursor-pointer"
              bind:value={expiry}
            >
              <option value="900">15 min</option>
              <option value="1800">30 min</option>
              <option value="3600">1 hour</option>
              <option value="21600">6 hours </option>
              <option value="86400">1 day</option>
              <option value="604800">7 days</option>
            </select>
            or until revealed. After this date, it will be destroyed.
          </p>
        </div>
      </div>

      <div class="mt-10">
        {#if submitting}
          <Button loading={submitting}>Encrypting data...</Button>
        {:else}
          <Button on:click={handleClick} disabled={!textToEncrypt}>Create a secret link</Button>
        {/if}
      </div>
    </form>
  </div>
{/if}
