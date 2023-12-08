import { createApp, h } from 'vue'
import { createPinia } from 'pinia'
import 'bulma/css/bulma.css'
import App from '@/layouts/App.vue'
import router from '@/router'
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import urlq, { cacheExchange, fetchExchange } from '@urql/vue'
import VueCookies from 'vue-cookies'
import { useAuthorizationStore } from '@/stores/useAuthorization'
import { retryExchange } from '@urql/exchange-retry'
import ErrorHandler from '@/errorHandler'

const vuetify = createVuetify({})
const retryOptions = {
  initialDelayMs: 1000,
  maxDelayMs: 15000,
  randomDelay: true,
  maxNumberAttempts: 2,
  retryIf: (err) => err && err.networkError
}

const app = createApp({
  setup() {
    const tokenId = localStorage.getItem('session') || window.location.search.split('=')[1]
    if (tokenId) {
      const authStore = useAuthorizationStore()
      authStore.setToken(tokenId)
      window.location = '/'
    }
  },
  render: () => h(App)
})

app.config.errorHandler = ErrorHandler

app.use(createPinia())
app.use(router)
app.use(VueCookies, { secure: true, expires: '1D' })
app.use(vuetify)
app.use(urlq, {
  url: 'http://localhost:3000/graphql',
  exchanges: [cacheExchange, fetchExchange, retryExchange(retryOptions)],
  fetchOptions: () => {
    return {
      headers: {
        'X-Auth-ID': app.$cookies.get('session') || ''
      }
    }
  }
})
app.mount('#app')
