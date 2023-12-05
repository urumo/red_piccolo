import { createApp, h } from 'vue'
import { createPinia } from 'pinia'
import 'bulma/css/bulma.css'
import App from '@/layouts/App.vue'
import router from '@/router'
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'
import { createVuetify } from 'vuetify'

const vuetify = createVuetify({})
import urlq, { cacheExchange, fetchExchange } from '@urql/vue'
import VueCookies from 'vue-cookies'
import { useAuthorizationStore } from '@/stores/useAuthorization'

const app = createApp({
  setup() {
    const tokenId = window.location.search.split('=')[1]
    const authStore = useAuthorizationStore()
    if (tokenId) {
      authStore.setToken(tokenId)
      window.location = '/'
    }
  },
  render: () => h(App)
})

app.use(createPinia())
app.use(router)
app.use(VueCookies)
app.use(vuetify)
app.use(urlq, {
  url: 'http://localhost:3000/graphql',
  exchanges: [cacheExchange, fetchExchange],
  fetchOptions: () => {
    return {
      headers: {
        'X-Auth-ID': localStorage.getItem('session') || '',
        'X-CSRF-Token':
          document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    }
  }
})
app.mount('#app')
