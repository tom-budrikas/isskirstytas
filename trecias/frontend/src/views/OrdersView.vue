<script setup>
import { ref } from 'vue'
import { user } from '../user.js'
import { useRouter } from 'vue-router'
const router = useRouter()
const orders = ref([])
function getOrders() {
    if (user.loggedIn) {
        fetch("http://localhost:3000/api/orders/user/" + user.id)
        .then(res => res.json())
        .then(data => orders.value = data)
        .catch(err => console.error(err))
    }
}
getOrders()
</script>
<template>
    <div class="container">
        <h1 class="title">Užsakymai</h1>
        <p class="no_order" v-if="orders.length === 0">Jūs neturite užsakymų.</p>
        <div class="order" v-for="order of orders">
            <h1 class="order_title">Užsakymas #{{ order.id }}</h1>
            <p>Sukurtas: {{ order.date_created.replace(/T|\.000Z/g, " ") }}</p>
            <p>Paskutinis būsenos keitimas: {{ order.date_updated.replace(/T|\.000Z/g, " ") }}</p>
            <p>Būsėna: {{ order.state }}</p>
            <p>Prekių kiekis: {{ order.item_count }}</p>
            <p>Sumokėta kaina: {{ Math.round((order.total + Number.EPSILON) * 100) / 100 }} &euro;</p>
            <button @click="router.push('/order/' + order.id)" class="order_view">Peržiūrėti</button>
        </div>
    </div>
</template>
<style scoped>
.no_order {
    text-align: center;
    font-size: 24px;
}
.title {
    text-align: center;
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
.order_title {
    text-align: center;
}
.order_view {
    margin: auto;
    width: 200px;
    padding: 5px;
    background-color: whitesmoke;
    border-radius: 15px;
    border: 2px solid orangered;
    color: orange;
    font-size: 20px;
}
.order_view:hover {
    color: orangered;
    cursor: pointer;
}
.order {
    display: flex;
    flex-direction: column;
    width: 50%;
    margin: auto;
    background-color: whitesmoke;
    padding: 20px;
    border-radius: 15px;
    gap: 16px;
    border: 2px solid orangered;
}
</style>