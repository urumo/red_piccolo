<script setup lang="ts">
import { RouterLink } from 'vue-router'
import { useAuthorizationStore } from '@/stores/useAuthorization'

const authStore = useAuthorizationStore()
authStore.authorize()
</script>

<template>
  <nav>
    <RouterLink to="/">Home</RouterLink>
    <RouterLink to="/about">About</RouterLink>
    <!--    <v-spacer></v-spacer>-->
    <div v-if="authStore.tokenId">
      <a href="/identity/logout" @click="authStore.logout" data-method="delete">Log Out</a>
      <a href="/identity">{{ authStore.user.fullName }}</a>
    </div>
    <div v-else>
      <a href="/identity/auth">Log In</a>
      <a href="/identity/auth?form_action=register">Register</a>
    </div>
  </nav>
</template>

<style scoped>
nav {
  width: 100%;
  font-size: 12px;
  text-align: center;
  margin-top: 2rem;
}

nav a.router-link-exact-active {
  color: var(--color-text);
}

nav a.router-link-exact-active:hover {
  background-color: transparent;
}

nav a {
  display: inline-block;
  padding: 0 1rem;
  border-left: 1px solid var(--color-border);
}

nav a:first-of-type {
  border: 0;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  nav {
    text-align: left;
    margin-left: -1rem;
    font-size: 1rem;

    padding: 1rem 0;
    margin-top: 1rem;
  }
}
</style>
