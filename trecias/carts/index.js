const express = require('express')
const app = express()
app.use(express.json())
const port = 3000

const mysql = require('mysql2')
function createConnection(res) {
  try {
    return mysql.createConnection({
      host: 'mysql',
      user: 'root',
      password: 'root',
      database: 'mysql_db'
    })
  } catch(e) {
    res.status(500).send(err)
  }
} 

app.get('/carts/:id', async (req, res) => {
  const con = createConnection()
  let errors = []
  let cart_id = 0;
  await con.promise().query('SELECT * FROM `carts` WHERE `user_id`=?', [req.params.id])
    .then(([result, fields]) => {
      if (result.length > 0) {
        cart_id = result[0].id
      }
    })
    .catch (err => errors.push(err));

  if (cart_id === 0 && errors.length === 0) {
    await con.promise().query("INSERT INTO `carts` (`user_id`) VALUES (?)", [req.params.id])
    .then(([result, fields]) => {
      cart_id = result.insertId;
    })
    .catch(err => errors.push(err))
  }
  let cart = {}
  let temp_cart = []
  if (cart_id > 0 && errors.length === 0) {
    await con.promise().query("SELECT * FROM `cart_items` WHERE `cart_id`=?", cart_id)
    .then(([result, fields]) => {
      temp_cart = result
    })
    .catch(err => errors.push(err))
  }
  if (errors.length === 0) {
    temp_cart.forEach((val) => {
      cart[val.item_id] = val.quantity
    })
    res.json(cart);
  } else {
    res.json({errors})
  }
  con.end()
})

app.put('/carts/:id', async (req, res) => {
  const con = createConnection()
  let errors = []
  let cart_id = 0;
  await con.promise().query('SELECT * FROM `carts` WHERE `user_id`=?', [req.params.id])
    .then(([result, fields]) => {
      if (result.length > 0) {
        cart_id = result[0].id
      }
    })
    .catch (err => errors.push(err));

  if (cart_id === 0 && errors.length === 0) {
    await con.promise().query("INSERT INTO `carts` (`user_id`) VALUES (?)", [req.params.id])
    .then(([result, fields]) => {
      cart_id = result.insertId;
    })
    .catch(err => errors.push(err))
  }

  if (cart_id > 0 && errors.length === 0) {
    await con.promise().query("DELETE FROM `cart_items` WHERE `cart_id`=?", cart_id)
    .catch(err => errors.push(err))
  }

  let newCart = req.body;
  for (const index in newCart) {
    await con.promise().query("INSERT INTO `cart_items` (`cart_id`, `item_id`, `quantity`) VALUES (?, ?, ?)", [cart_id, index, newCart[index]])
    .catch(err => errors.push(err))
  }
  if (errors.length === 0) {
    res.json({cartid: cart_id})
  } else {
    res.json({errors})
  }
  con.end()
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
