import preprocess from 'svelte-preprocess';
import adapter from '@sveltejs/adapter-netlify';
import builtins from 'rollup-plugin-node-builtins';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  // Consult https://github.com/sveltejs/svelte-preprocess
  // for more information about preprocessors
  preprocess: preprocess(),

  kit: {
    target: '#svelte',
    adapter: adapter(),
    vite: {
      plugins: [builtins({ crypto: true })]
    }
  }
};

export default config;
