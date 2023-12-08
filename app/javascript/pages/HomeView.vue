<script async setup lang="ts">
import { useCounterStore } from '@/stores/counter'
import { useAuthorizationStore } from '@/stores/useAuthorization'

const counter = useCounterStore()
const auth = useAuthorizationStore()
</script>

<template>
  <main>
    <h1>Home!!</h1>
    <h2>{{ counter.count }}</h2>
    <h2>{{ counter.doubleCount }}</h2>
    <v-btn @click="counter.increment">Increment</v-btn>
    <v-btn v-if="auth.userIsSet" @click="auth.authorize">Authorize</v-btn>
  </main>
</template>
<style scoped></style>
