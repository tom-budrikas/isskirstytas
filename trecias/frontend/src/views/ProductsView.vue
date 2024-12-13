<script setup>
import { ref } from 'vue'
import { cart } from '../cart.js'
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

</script>
<template>
  <div>
    <div class="products">
      <div v-if="products.length > 0" class="product" v-for="product in products">
        <div class="productImage"><img :src="'/images/' + product.image_url + '.jpg'"></div>
        <h1 class="productName">{{ product.name }}</h1>
        <p class="productDescription">{{ product.description }}</p>
        <p class="productPrice">{{ product.price }} &euro;</p>
        <button class="productAddToCart" @click="cart.setItem(product.id)">Pridėti į krėpšelį</button>
      </div>
    </div>
  </div>
</template>
<style scoped>
.products {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  width: 80%;
  padding: 20px;
  gap: 20px;
  margin: auto;
  background-color: orange;
  border-radius: 15px;
  border: 2px solid orangered;
}
.product {
  background-color: white;
  border-radius: 15px;
  border: 2px solid orangered;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 600px;
}
.productImage {
  background-color: whitesmoke;
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
  padding: 10px;
  height: 300px;
}
.productImage img {
  height: 100%;
  width: 100%;
  margin: auto;
}
.productName {
  font-size: 28px;
}
.productDescription {
  font-size: 20px;
}
.productPrice {
  font-size: 20px;
  color: red
}
.productName, .productDescription, .productPrice {
  font-family: Arial, Helvetica, sans-serif
}
.productAddToCart {
  background: whitesmoke;
  border: 2px solid orangered;
  margin-bottom: 10px;
  color: orange;
  padding: 10px 0px;
  border-radius: 15px;
  font-size: 24px;
  width: 80%;
  margin: 20px auto;
  text-decoration: none;
}
.productAddToCart:hover {
  color: orangeRed;
  cursor: pointer;
}
</style>