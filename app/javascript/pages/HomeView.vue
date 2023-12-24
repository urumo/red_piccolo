<script async setup lang="ts">
import { useCounterStore } from '@/stores/counter';

const counter = useCounterStore();
</script>

<template>
  <main>
    <h1>Home!!</h1>
    <h2>{{ counter.count }}</h2>
    <h2>{{ counter.doubleCount }}</h2>
    <button @click="counter.increment">Increment</button>
  </main>
</template>
<style scoped></style>
