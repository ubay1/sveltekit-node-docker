import { sveltekit } from '@sveltejs/kit/vite';
import type { UserConfig } from 'vite';

const config: UserConfig = {
	plugins: [sveltekit()],
	server: {
		hmr: {
			host: 'localhost'
		},
		watch: {
			usePolling: true
		}
	}
};

export default config;
