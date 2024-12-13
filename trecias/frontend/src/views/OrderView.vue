<script setup>
import { ref } from 'vue'
import { useRoute } from 'vue-router'
let order_id = useRoute().params.id;
let order_info = ref({})
let order_items = ref([])
let order_states = ref([])
let products = ref([])
function getOrderInfo() {
    fetch("http://localhost:3000/api/orders/"+order_id)
    .then(res => res.json())
    .then(data => {
        order_info.value = data[0]
        order_info.value.date_created = order_info.value.date_created.replace(/T|\.000Z/g, " ")
        order_info.value.date_updated = order_info.value.date_updated.replace(/T|\.000Z/g, " ")
    })
    .catch(err => console.error(err))
}
function getOrderItems() {
    fetch("http://localhost:3000/api/orders/"+order_id + "/items")
    .then(res => res.json())
    .then(data => order_items.value = data)
    .catch(err => console.error(err))
}
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
function getOrderStates() {
    fetch("http://localhost:3000/api/order_states")
    .then(res => res.json())
    .then(data => order_states.value = data)
    .catch(err => console.error(err))
}
function getTotal() {
    let sum = 0;
    for (const order_item of Object.values(order_items.value)) {
        sum += products.value.find(item => item.id == order_item.item_id).price * order_item.quantity;
    }
    return Math.round((sum + Number.EPSILON) * 100) / 100;
}
getProducts();
getOrderInfo();
getOrderItems();
getOrderStates();
</script>
<template>
    <div class="container">
        <h1 v-if="products.length > 0 && Object.keys(order_info).length > 0" class="title">Užsakymas #{{ order_info.id }}</h1>
        <div class="order">
            <div class="order_info">
                <p v-if="products.length > 0 && Object.keys(order_info).length > 0">Sukurtas: {{ order_info.date_created }}</p>
                <p v-if="products.length > 0 && Object.keys(order_info).length > 0">Paskutinis būsėnos pasikeitimas: {{ order_info.date_updated }}</p>
                <p v-if="products.length > 0 && Object.keys(order_info).length > 0">Dabartinė būsėna: {{ order_states.find(state => state.id == order_info.state_id).state }}</p>
            </div>
            <div v-if="products.length > 0 && Object.keys(order_info).length > 0" class="items">
                <div class="item" v-for="order_item of order_items">
                    <div class="img">
                        <img :src="'/images/' + products.find(item => order_item.item_id == item.id).image_url + '.jpg'">
                    </div>
                    <p class="item_info">{{ products.find(item => order_item.item_id == item.id).name }} - {{ Math.round((products.find(item => order_item.item_id == item.id).price + Number.EPSILON) * 100) / 100 }} &euro;</p>
                    <p>{{ order_item.quantity }} vnt.</p>
                    <p>{{ order_item.quantity * products.find(item => order_item.item_id == item.id).price }} &euro;</p>
                </div>
            </div>
            <p v-if="products.length > 0 && Object.keys(order_info).length > 0" class="finalCost">Sumokėta kaina: {{ getTotal() }} &euro;</p>
        </div>
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
        .item {
            text-align: center;
            display: grid;
            grid-template-columns: 1fr 1fr 0.5fr 0.5fr;
            width: 100%;
            height: 200px;
            align-items: center;
            padding: 15px;
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
        .order_info {
            margin: auto;
            font-size: 20px;
            line-height: 2;
            text-align: center;
        }
        .order {
            display: flex;
            flex-direction: column;
            gap: 32px;
            background-color: whitesmoke;
            border-radius: 15px;
            border: 2px solid orangered;
            padding: 24px;
            width: 80%;
            margin: auto;
            box-sizing: border-box;
        }
    </style>