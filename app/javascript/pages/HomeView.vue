<script async setup lang="ts">
import { useCounterStore } from '@/stores/counter'
import { useClientHandle } from '@urql/vue'
import { watch } from 'vue'

const counter = useCounterStore()
const handle = useClientHandle()
</script>

<template>
  <main>
    <h1>Home!!</h1>
    <h2>{{ counter.count }}</h2>
    <h2>{{ counter.doubleCount }}</h2>
    <v-btn @click="counter.increment">Increment</v-btn>
  </main>
</template>
<style scoped></style>
