import { defineConfig } from 'vite'
import { fileURLToPath, URL } from 'node:url'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from "vite-plugin-full-reload";
import vue from "@vitejs/plugin-vue";
import vueJsx from '@vitejs/plugin-vue-jsx';
export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(["config/routes.rb", "app/views/**/*"], { delay: 200 }),
    vue(),
    vueJsx(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
