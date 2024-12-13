<script setup>
import { ref } from "vue"
import { user } from "../user.js"
import { cart } from "../cart.js"
import { useRouter } from "vue-router"
const router = useRouter()
const username = ref("")
const password = ref("")
const errors = ref([])

async function handleSubmit() {
    errors.value = []

    let result = await fetch("http://localhost:3000/api/login", {
        method: "POST",
        body: JSON.stringify({name: username.value, password: password.value}),
        headers: {
            "Content-Type": "application/json",
        },
    }).then(res => res.json())

    if (result.errors) {
        for (let error of result.errors) {
            errors.value.push(error)
        }
    } else if (result.userid) {
        user.id = result.userid;
        user.name = username.value;
        user.loggedIn = true;
        cart.loadCart()
        router.push('/')
    } else {
        errors.value.push("Nepavyko prisijungti prie paskyros.")
    }
}
</script>
<template>
<form class="form" @submit="e => e.preventDefault()">
    <ul v-if="errors.length > 0">
        <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
    </ul>
    <label for="name">Įveskite vardą:</label>
    <input type="name" id="name" v-model="username" required>
    <label for="password">Įveskite slaptažodį:</label>
    <input type="password" id="password" v-model="password" required>
    <button @click="handleSubmit()">Prisijungti prie paskyros</button>
</form>
</template>
<style scoped>
.form {
    width: 80%;
    background-color: whitesmoke;
    display: flex;
    flex-direction: column;
    padding: 32px;
    gap: 16px;
    margin: auto;
    border: 2px solid orangered;
    border-radius: 15px;
    align-items: center;
    box-sizing: border-box;
}
ul > li {
    font-size: 24px;
    color: red;
    margin-bottom: 32px;
}
.form input {
    width: 300px;
    height: 30px;
    padding: 5px 20px;
    border-radius: 15px;
    border: 2px solid orangered;
    font-size: 20px;
}
.form label {
    font-size: 24px;
    font-family: Arial, Helvetica, sans-serif;
}
.form button {
    margin-top: 100px;
    width: 300px;
    border: 2px solid orangered;
    background: white;
    border-radius: 15px;
    padding: 10px 0px;
    font-size: 24px;
    color: orange;
}
.form button:hover {
    color: orangered;
    cursor: pointer;
}
</style>