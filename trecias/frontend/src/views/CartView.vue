<script setup>
import { cart } from "../cart.js"
import { user }from "../user.js"
import { ref } from "vue"
import { useRouter } from "vue-router"

const router = useRouter()
const products = ref([])

function getProducts() {
  fetch("http://localhost:3000/api/products")
    .then(async res => {
      let resJson = await res.json()
      if (!res.ok) {
        console.error(resJson)
      } else {
        products.value = resJson;
      }
    }).catch(err => console.error(err))
}

getProducts();
async function createOrder() {
    let order_id = await fetch("http://localhost:3000/api/orders/", {
        method: "POST",
        body: JSON.stringify({user_id: user.id, cart: cart.items}),
        headers: {
            "Content-Type": "application/json",
        }
    }).then(res => res.json())
    .catch(err => console.error(err))
    cart.clear()
    router.push("/order/"+order_id.order_id)
}

function getTotal() {
    let sum = 0;
    for (const index in cart.items) {
        sum += products.value.find(item => item.id == index).price * cart.items[index];
    }
    return Math.round((sum + Number.EPSILON) * 100) / 100;
}
</script>
<template>
<div class="container">
    <h1 class="title">Krėpšelis</h1>
    <button class="clear" @click="cart.clear()" v-if="cart.getLength() > 0">Išvalyti krėpšelį</button>
    <p class="empty" v-if="Object.keys(cart.items).length === 0">Jūsų krėpšelis tuščias.</p>
    <div v-if="products.length > 0 && cart.getLength() > 0" class="items">
        <div class="item" v-for="(quantity, index) in cart.items">
            <div class="img">
                <img :src="'./images/' + products.find(item => item.id == index).image_url + '.jpg'">
            </div>
            <p class="item_info">{{ products.find(item => item.id == index).name }} - {{ products.find(item => item.id == index).price }} &euro;</p>
            <select :value="quantity" @change="e => cart.setItem(index, e.target.value)">
                <option v-for="i in 10" :value="i">{{ i }}</option>
            </select>
            <p>{{ quantity * products.find(item => item.id == index).price }} &euro;</p>
            <button @click="delete cart.items[index]">Pašalinti</button>
        </div>
    </div>
    <p v-if="Object.keys(cart.items).length > 0 && products.length > 0" class="finalCost">Galutinė kaina: {{ getTotal() }} &euro;</p>
    <button v-if="Object.keys(cart.items).length > 0 && user.loggedIn" class="submit" @click="createOrder">Užsakyti</button>
    <p class="loginwarn" v-if="!user.loggedIn">Norint atlikti užsakymą, pirma reikia prisijungti.</p>
</div>
</template>
<style scoped>
    .finalCost {
        color: red;
        font-size: 24px;
        text-align: center;
    }
    .submit, .clear {
        width: 200px;
        height: 50px;
        margin: auto;
        background-color: whitesmoke;
        border-radius: 16px;
        border: 2px solid orangered;
        color: orange;
        font-size: 24px;
    }
    .submit:hover, .clear:hover {
        color: orangered;
        cursor: pointer;
    }
    .empty, .loginwarn {
        text-align: center;
        font-size: 32px;
    }
    .container {
        padding: 32px;
        width: 80%;
        min-height: 300px;
        margin: auto;
        background-color: orange;
        border: 2px solid orangered;
        border-radius: 15px;
        font-family: Arial, Helvetica, sans-serif
    }
    .title {
        text-align: center;
        font-size: 50px;
    }
    .items {
        display: grid;
        grid-template-columns: 1fr;
        gap: 32px;
        width: 80%;
        margin: auto;
    }
    .item {
        text-align: center;
        display: grid;
        grid-template-columns: 1fr 1fr 0.5fr 0.5fr 0.5fr;
        width: 100%;
        height: 200px;
        align-items: center;
        background-color: whitesmoke;
        padding: 15px;
        border: 2px solid orangered;
        border-radius: 15px;
    }
    .img {
        width: 100%;
        height: 100%;
    }
    img {
        height: 100%;
        max-height: 200px;
        margin: auto;
    }
</style>