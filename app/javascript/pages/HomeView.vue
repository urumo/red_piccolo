<script setup lang="ts">
import { useCounterStore } from '../stores/counter'

const counter = useCounterStore()
const incrementCounter = () => {
  console.log('incrementing')
  console.log(counter.count)
  counter.increment()
}
</script>

<template>
  <main>
    <h1>Home!!!</h1>
    <h2>{{ counter.count }}</h2>
    <h2>{{ counter.doubleCount }}</h2>
    <button @click="incrementCounter">Increment</button>
  </main>
</template>
