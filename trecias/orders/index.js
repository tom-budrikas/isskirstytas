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

app.get('/orders', (req, res) => {
  const con = createConnection()
  con.query('SELECT * FROM `orders`', (err, rows, fields) => {
    if (err) {
      res.status(500).send(err)
    } else {
      res.json(rows)
    }  
  })
  con.end()
})

app.get('/orders/:id', (req, res) => {
  const con = createConnection()
  con.query('SELECT * FROM `orders` WHERE `id`=?', [req.params.id], (err, rows, fields) => {
    if (err) {
      res.status(500).send(err)
    } else {
      res.json(rows)
    }  
  })
  con.end()
})

app.get('/orders/user/:id', (req, res) => {
  const con = createConnection()
  con.query('SELECT `orders`.`id` as `id`, `orders`.`user_id` as `user_id`, `order_state`.`state` as `state`, count(`order_items`.`id`) as `item_count`, `orders`.`date_created` as `date_created`, `orders`.`date_updated` as `date_updated`, SUM(`products`.`price` * `order_items`.`quantity`) as `total` FROM `orders` INNER JOIN `order_state` ON `orders`.`state_id` = `order_state`.`id` INNER JOIN `order_items` ON `order_items`.`order_id` = `orders`.`id` INNER JOIN `products` ON `products`.`id` = `order_items`.`item_id` WHERE `orders`.`user_id` = ? GROUP BY `orders`.`id`;', [req.params.id], (err, rows, fields) => {
    if (err) {
      res.status(500).send(err)
    } else {
      res.json(rows)
    }  
  })
  con.end()
})

app.get('/orders/:id/items', (req, res) => {
  const con = createConnection()
  con.query('SELECT * FROM `order_items` WHERE `order_id`=?', [req.params.id], (err, rows, fields) => {
    if (err) {
      res.status(500).send(err)
    } else {
      res.json(rows)
    }  
  })
  con.end()
})

app.get('/order_states', (req, res) => {
  const con = createConnection()
  con.query('SELECT * FROM `order_state`', (err, rows, fields) => {
    if (err) {
      res.status(500).send(err)
    } else {
      res.json(rows)
    }  
  })
  con.end()
})

app.post('/orders', async (req, res) => {
    const con = createConnection()
    let errors = [];
    let order_id = 0;
    await con.promise().query('INSERT INTO `orders` (`user_id`, `state_id`, `date_created`, `date_updated`) VALUES (?, ?, ?, ?)', [req.body.user_id, 1, new Date(), new Date()])
    .then(([result, fields]) => {
      order_id = result.insertId;
    }).catch(e => errors.push(e))

    if (order_id !== 0) {
      for (const index in req.body.cart) {
        await con.promise().query('INSERT INTO `order_items` (`order_id`, `item_id`, `quantity`) VALUES (?, ?, ?)', [order_id, index, req.body.cart[index]])
        .catch(err => errors.push(err))
      }
    }
    if (errors.length > 0) {
      res.json({errors})
    } else {
      res.json({order_id: order_id})
    }
    con.end()
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
