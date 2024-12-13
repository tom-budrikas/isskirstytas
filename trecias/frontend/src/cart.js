import { reactive } from "vue"
import { user } from "./user.js"

export const cart = reactive({
    items: {},
    setItem(id, quantity = false) {
        if (!quantity) {
            if (this.items[id]) {
                this.items[id] += 1;
            } else {
                this.items[id] = 1;
            }
        } else {
            this.items[id] = quantity;
        }
        this.updateCartDB(cart.items)
    },
    removeItem(id) {
        delete this.items[id]
        this.updateCartDB()
    },
    getLength() {
        return Object.keys(this.items).length
    },
    updateCartDB() {
        if (user.loggedIn) {
            fetch("http://localhost:3000/api/carts/"+ user.id, {
                headers: {
                    "Content-Type": "application/json",
                },
                method: "PUT",
                body: JSON.stringify(this.items)
            }).catch(e => console.error(e))
        }
      },
    clear() {
        this.items = {}
        this.updateCartDB()
    },
    loadCart() {
        if (user.loggedIn) {
            fetch("http://localhost:3000/api/carts/" + user.id)
            .then(res => res.json())
            .then(data => {
                console.log(data)
                console.log(cart.items)
                for (const index in data) {
                    if (Object.keys(this.items).includes(index)) {
                        this.items[index] += data[index]
                    } else {
                        this.items[index] = data[index]
                    }
                }
                this.updateCartDB()
            })
            .catch(err => console.log(err))
        }
    }
})