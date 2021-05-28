<script lang="ts">
  import { createSecret } from '$lib/api';

  import { encryptData, generatePassphrase } from '$lib/crypto';

  let textToEncrypt: string;
  let encryptedText: string;
  let encryptionKey: string;
  let sharingUrl: string;

  async function handleClick(event) {
    event.preventDefault();

    encryptionKey = generatePassphrase();
    encryptedText = await encryptData(textToEncrypt, encryptionKey);

    const room = await createSecret(encryptedText);

    sharingUrl = `${location.protocol}//${location.host}/${room}#${encryptionKey}`;
  }
</script>

<main>
  <h1>Go ahead, share your secrets :)</h1>

  <form>
    <textarea name="secret" bind:value={textToEncrypt} />

    <div class="submit">
      <button on:click={handleClick}>Submit</button>
    </div>
  </form>

  <div class="result">
    {#if sharingUrl}
      <div>Your url: <a href={sharingUrl}>{sharingUrl}</a></div>
    {/if}
  </div>
</main>

<style>
  main {
    display: flex;
    flex-direction: column;
    align-items: center;

    padding: 4rem;
    margin: 0 auto;
  }

  form {
    display: flex;
    flex-direction: column;
  }

  textarea {
    margin-top: 4rem;

    width: 30rem;
    height: 30rem;
  }

  .submit {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  button {
    margin-top: 1rem;
    padding: 0.25rem;
  }

  .result {
    display: flex;
    flex-direction: column;
  }
</style>
