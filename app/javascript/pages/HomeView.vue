<script async setup lang="ts">
import { useCounterStore } from '@/stores/counter';
import { useAuthorizationStore } from '@/stores/useAuthorization';

const counter = useCounterStore();
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
