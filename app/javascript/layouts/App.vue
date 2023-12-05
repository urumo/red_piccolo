<script setup lang="ts">
import { RouterView } from 'vue-router'
import NavBar from '@/components/NavBar.vue'
import Footer from '@/components/FooterBar.vue'
</script>

<template>
  <v-app>
    <header>
      <NavBar />
    </header>
    <div id="main">
      <RouterView />
    </div>
    <Footer />
  </v-app>
</template>

<style scoped>
header {
  line-height: 1.5;
  max-height: 100vh;
}

@media (min-width: 1024px) {
  #main {
    min-height: 80%;
  }
}
</style>
