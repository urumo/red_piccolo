import { defineConfig } from 'vite'
import { fileURLToPath, URL } from 'node:url'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import vue from '@vitejs/plugin-vue'
import StimulusHMR from 'vite-plugin-stimulus-hmr'
import vueJsx from '@vitejs/plugin-vue-jsx'
import vuetify, { transformAssetUrls } from 'vite-plugin-vuetify'
import dns from 'dns'

dns.setDefaultResultOrder('ipv4first')

export default defineConfig({
  plugins: [
    RubyPlugin(),
    StimulusHMR(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 200 }),
    vue(),
    vueJsx(),
    vuetify({autoImport: true}),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./app/javascript', import.meta.url))
    }
  }
})
