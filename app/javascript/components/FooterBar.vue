<script setup lang="ts"></script>

<template>
  <v-footer class="d-flex flex-column w-100">
    <div class="bg-teal d-flex w-100 align-center px-4">
      <strong class="text-center">Coming Soon!</strong>

      <v-spacer></v-spacer>
    </div>

    <div class="px-4 py-2 bg-black text-center w-100">
      {{ new Date().getFullYear() }} — <strong>SVCK</strong>
    </div>
  </v-footer>
</template>

<style scoped></style>
