import preprocess from 'svelte-preprocess';
import adapter from '@sveltejs/adapter-netlify';

function buildApiUrl() {
  if (process.env.NODE_ENV === 'development') {
    return 'http://localhost:4000';
  }

  const prNumber = process.env['REVIEW_ID'];

  if (prNumber) return `https://finiam-secrets-pr-${prNumber}.herokuapp.com`;

  return `https://finiam-secrets.herokuapp.com`;
}

const API_URL = buildApiUrl();

console.log('RUNNING WITH THE FOLLOWING API_URL', API_URL);

process.env.VITE_API_URL = API_URL;

/** @type {import('@sveltejs/kit').Config} */
const config = {
  // Consult https://github.com/sveltejs/svelte-preprocess
  // for more information about preprocessors
  preprocess: [
		preprocess({
			postcss: true
		}),
	],

  kit: {
    target: '#svelte',
    adapter: adapter()
  }
};

export default config;
