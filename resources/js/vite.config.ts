import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    outDir: './dist',
    emptyOutDir: true,
    lib: {
      entry: './src/main.ts',
      name: 'app',
      fileName: (format) => `app.${format}.js`
    },
  }
})