import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, type UserConfig } from 'vite';

export default defineConfig(({ mode }) => {
  function buildApiUrl() {
    if (mode === 'development') {
      return 'http://localhost:4000';
    }

      return `https://secrets-subvisual-com.fly.dev`;
}

  const apiUrl = buildApiUrl();
  console.log('RUNNING WITH THE FOLLOWING API_URL', apiUrl);
  process.env.VITE_API_URL = apiUrl;

  const config: UserConfig = {
    plugins: [...sveltekit()]
  };

  return config;
});
