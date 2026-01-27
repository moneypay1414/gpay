import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [react()],
  base: '/',
  cacheDir: './node_modules/.vite',
  build: {
    outDir: './dist'
  },
  server: {
    port: 5173,
    proxy: {
      '/api': {
        target: 'http://cw8goos8gg4gcw4c04ck8k4s.127.0.0.1.sslip.io',
        changeOrigin: true
      }
    }
  }
});
