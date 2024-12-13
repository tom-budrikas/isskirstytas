<script setup>
import { RouterLink, RouterView, useRouter, useRoute } from 'vue-router'
import { user } from "./user.js"
import { cart } from "./cart.js"
const router = useRouter()
const route = useRoute()
console.log(route.name)

</script>

<template>
  <div class="container">
    <header>
      <nav class="links">
        <RouterLink class="link" v-if="route.name !== 'products'" to="/">Produktai</RouterLink>
        <RouterLink class="link" v-if="!user.loggedIn && route.name !== 'login'" to="/login">Prisijungti</RouterLink>
        <RouterLink class="link" v-if="!user.loggedIn && route.name !== 'register'" to="/register">Registruotis</RouterLink>
        <RouterLink class="link" v-if="user.loggedIn && route.name !== 'orders'" to="/orders">Užsakymai</RouterLink>
        <RouterLink class="link" v-if="route.name !== 'cart'" to="/cart">Krėpšelis ({{ cart.getLength() }})</RouterLink>
        <a class="link" v-if="user.loggedIn" @click="user.logout()">Atsijungti</a>
      </nav>
    </header>
    <main>
      <RouterView />
    </main>
    <footer>
      Tomas Budrikas &copy; 2024
    </footer>
  </div>
</template>

<style scoped>
  .links {
    display: flex;
    gap: 16px;
    justify-content: center;
    align-items: center;
    height: 100px;
    background-color: orange;
    border-bottom: 2px solid orangered;
  }
  .link {
    padding: 10px 30px;
    border: 2px solid orangered;
    background: whitesmoke;
    font-size: 20px;
    font-family: Arial, Helvetica, sans-serif;
    border-radius: 15px;
    color: orange;
    text-decoration: none;
  }
  .link:hover {
    color: orangered;
    cursor: pointer;
  }
  footer {
    background-color: orange;
    height: 100px;
    justify-content: center;
    align-items: center;
    display: flex;
    color: black;
    font-size: 24px;
    border-top: 2px solid orangered;
    margin-top: auto;
  }
  .container {
    display: flex;
    flex-direction: column;
    gap: 64px;
    min-height: 100vh;
  }
</style>
