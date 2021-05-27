<script lang="ts">
	import { decryptData } from '$lib/crypto';

	let encrypted;
	let key;
	let result;

	async function handleClick(event) {
		event.preventDefault();

		result = await decryptData(encrypted, key);
	}
</script>

<div>
	<label>Encrypted</label>
	<input bind:value={encrypted} />

	<label>Key</label>
	<input bind:value={key} />

	<button on:click={handleClick}>Decrypt</button>

	{result}
</div>
