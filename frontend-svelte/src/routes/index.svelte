<script lang="ts">
	import { encryptData, generatePassphrase } from '$lib/crypto';

	let secret: string;
	let key: string;
	let encrypted: string;

	async function handleClick(event) {
		event.preventDefault();

		key = generatePassphrase();
		encrypted = await encryptData(secret, key);
	}
</script>

<main>
	<h1>Go ahead, share your secrets :)</h1>

	<form>
		<textarea name="secret" bind:value={secret} />

		<div>
			<button on:click={handleClick}>Doom yourself to enternal suffering</button>
		</div>
	</form>

	<div class="result">
		{#if key}
			<p>Your key: {key}</p>
		{/if}

		{#if encrypted}
			<p>Your encrypted trash: {encrypted}</p>
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

	button {
		margin-top: 1rem;
		padding: 0.25rem;
	}

	.result {
		display: flex;
		flex-direction: column;
	}
</style>
