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

app.get('/products', (req, res) => {
  const con = createConnection()
  con.query('SELECT * FROM `products`', (err, rows, fields) => {
    if (err) {
      res.status(500).send(err)
    } else {
      res.json(rows)
    }  
  })
  con.end()
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
