import { reactive } from "vue"
import { cart } from "./cart.js"

export const user = reactive({
    id: 0,
    name: "",
    loggedIn: false,
    logout() {
        this.id = 0;
        this.name = "";
        this.loggedIn = false;
        cart.clear()
    }
})