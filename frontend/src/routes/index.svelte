<script lang="ts">
  // @hmr:keep-all
  import { goto } from '$app/navigation';
  import { createSecret, deleteSecret } from '$lib/api';
  import Button from '$lib/components/Button.svelte';
  import CopyButton from '$lib/components/CopyButton.svelte';
  import IconChevron from '$lib/components/IconChevron.svelte';
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
  let toggleOpen = false;

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

  const toggleInfo = () => (toggleOpen = !toggleOpen);
</script>

<SEO
  title="Finiam Secrets"
  description="Finiam Secrets allows you to share information securely and ephemerally. The generated link will only work once and then it will disappear forever."
  keywords="secrets,share,end-to-end,encryption,finiam"
/>

{#if sharingUrl && !submitting}
  <div class="flex w-full flex-col items-center gap-8">
    <p class="w-4/5 max-w-lg text-center">
      As soon as someone opens the link, it will be destroyed automatically, ensuring full
      protection of your information.
    </p>

    <div class="w-4/5 rounded-xl bg-white p-4 md:w-7/12">
      <p class="w-full truncate font-sans tracking-tight">{sharingUrl}</p>
    </div>
    <div class="flex flex-wrap items-center justify-center gap-3 px-4 md:gap-5">
      <CopyButton value={sharingUrl}>Copy link</CopyButton>

      <Button class="bg-gray-200" secondary on:click={handleReset} loading={deleting}>
        Reset and try again
      </Button>
    </div>
  </div>
{:else}
  <div class="flex w-full grow flex-col items-center gap-6">
    <p class="text-md w-11/12 text-center md:text-lg">
      Share information securely and ephemerally. <br /> The generated link will only work once and then
      it will disappear forever.
    </p>
    <form class="relative flex w-full flex-col items-center justify-center gap-2">
      <textarea
        class="h-52 w-4/5 rounded-xl border-2 border-transparent p-4 font-sans tracking-tight outline-none focus:border-dark-grey md:h-64 md:w-7/12"
        name="secret"
        placeholder="Your information..."
        bind:value={textToEncrypt}
      />

      <div
        class="flex w-4/5 items-center gap-2 rounded-xl bg-white p-2 sm:items-center sm:p-3 md:absolute md:right-0 md:top-0 md:w-1/5 md:flex-col md:items-center lg:w-2/12"
      >
        <div class="flex w-1/2 flex-col p-1 sm:gap-2 md:w-full">
          <p class="text-md font-medium">Secret lifetime</p>
          <p class="text-sm">After this time, the secret will vanish.</p>
        </div>
        <div class="relative w-full">
          <select
            name="expiry"
            class="w-1/2 cursor-pointer appearance-none rounded-full bg-smoked-white py-2 px-3 text-sm tracking-tight outline-dark-grey md:w-full"
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
          <IconChevron class="pointer-events-none absolute right-2 top-2.5" />
        </div>
      </div>

      <div class="mt-6">
        {#if submitting}
          <Button loading={submitting}>Encrypting data...</Button>
        {:else}
          <Button on:click={handleClick} disabled={!textToEncrypt}>Create a secret link</Button>
        {/if}
      </div>
    </form>

    <div class="flex w-7/12 grow flex-col justify-end">
      <button
        on:click={toggleInfo}
        class="text-md flex items-center gap-1 self-center outline-dark-grey hover:text-green md:self-start"
        >How it works <IconChevron class={`${toggleOpen && 'rotate-180'} pointer-events-none`} />
      </button>
      <p
        class="{toggleOpen
          ? 'block'
          : 'hidden'} sm:text-md mx-auto my-2 w-full text-justify text-sm"
      >
        Finiam Secrets transmits E2E messages safely by encrypting the user info locally and then
        generating a URL with a private key embbeded on it. When you generate a secret, the webapp
        posts the encrypted information to our API, which in turn stores that encrypted information.
        Each secret can only be opened once - secrets get destroyed after they have been opened or
        after they expire.
      </p>
    </div>
  </div>
{/if}
