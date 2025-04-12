// import { defineConfig } from 'vite';
// import path from 'path';

// export default defineConfig({
//   build: {
//     outDir: './dist',
//     emptyOutDir: true,
//     rollupOptions: {
//       input: {
//         cart: path.resolve(__dirname, 'src/cart/index.ts'),
//         product: path.resolve(__dirname, 'src/product/index.ts'),
//         bind: path.resolve(__dirname, 'src/bind/index.ts'),
//       },
//       output: {
//         entryFileNames: '[name].js', // hasil: cart.js, product.js, etc
//       }
//     }
//   }

// });
import { defineConfig } from 'vite'
import path from 'path'
import { glob } from 'glob'

export default defineConfig({
  build: {
    rollupOptions: {
      input: Object.fromEntries(
        glob.sync('src/**/index.ts').map(file => [
          // Nama entry point (misal: 'cart' untuk 'src/cart/index.ts')
          path.relative('src', path.dirname(file)),
          // Path absolut ke file
          path.resolve(__dirname, file)
        ])
      ),
      output: {
        entryFileNames: '[name].js',
        preserveModulesRoot: 'src',
        preserveModules: true,
      },
      preserveEntrySignatures: 'allow-extension'
    }
  }
})