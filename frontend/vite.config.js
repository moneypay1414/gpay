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
    port: 5173
  },
  preview: {
  }
});
