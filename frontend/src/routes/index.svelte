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
  <div class="flex w-full flex-col items-center">
    <p class="mb-10 w-4/5 max-w-lg text-center">
      As soon as someone opens the link, it will be destroyed automatically, ensuring full
      protection of your information.
    </p>

    <div class="mb-10 w-4/5 rounded-md border-2 border-gray-300 p-4">
      <p class="w-full truncate">{sharingUrl}</p>
    </div>
    <div class="flex flex-row items-center space-x-4 px-4">
      <CopyButton value={sharingUrl}>Copy link</CopyButton>

      <Button class="bg-gray-200" secondary on:click={handleReset} loading={deleting}
        >Reset and try again</Button
      >
    </div>
  </div>
{:else}
  <div class="flex w-full flex-col items-center">
    <p class="mb-10 w-4/5 max-w-lg text-center">
      Finiam Secrets allows you to share information securely and ephemerally. The generated link
      will only work once and then it will disappear forever.
    </p>
    <form class="flex w-full flex-col items-center">
      <textarea
        class="h-64 w-4/5 rounded-md border-2 border-gray-300 p-4"
        name="secret"
        placeholder="Your information..."
        bind:value={textToEncrypt}
      />

      <div class="mx-8 mt-8 w-full">
        <p class="text-lg">Secret lifetime</p>

        <div class="flex">
          <p>
            This link is valid for
            <select
              name="expiry"
              class="cursor-pointer rounded border-2 border-gray-400 p-2"
              bind:value={expiry}
            >
              <!-- Disable for now, while we use a non-persistent redis
                <option value="86400">1 day</option>
                <option value="604800">7 days</option>
              -->
              <option value="21600">6 hours </option>
              <option value="3600">1 hour</option>
              <option value="1800">30 min</option>
              <option value="900">15 min</option>
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
