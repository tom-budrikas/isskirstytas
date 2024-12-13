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
    res.status(500).json({errors: e})
  }
} 

app.get('/users', (req, res) => {
  const con = createConnection()
  con.query('SELECT * FROM `users`', (err, rows, fields) => {
    if (err) {
      res.status(500).json({errors: err})
    } else {
      res.json(rows)
    }  
  })
  con.end()
})

app.post('/users', async (req, res) => {
    const con = createConnection()
    let errors = [];
    let nameExists = false;
    await con.promise().query("SELECT * FROM `users` WHERE `name`=?", [req.body.name])
      .then(([rows, fields]) => {
        if (rows.length > 0) {
          nameExists = true;
          errors.push("Šis vartotojo vardas jau panaudotas. Bandykite kitą.")
        }
      }).catch(e => {
        errors.push(e)
      })
    if (!nameExists && errors.length === 0) {
      await con.promise().query('INSERT INTO `users` (`name`, `password`) VALUES (?, ?)', [req.body.name, req.body.password])
        .then(([rows, fields]) => {
          res.json({userid: rows.insertId})
        }).catch(e => {
          errors.push(e)
        })
    }
    if (errors.length > 0) {
      res.status(400).json({errors: errors})
    }
    con.end()
})

app.post('/login', async (req, res) => {
  const con = createConnection()
  let errors = [];
  await con.promise().query("SELECT * FROM `users` WHERE `name`=? AND `password`=?", [req.body.name, req.body.password])
    .then(([rows, fields]) => {
      if (rows.length > 0) {
        res.json({userid: rows[0].id, name: rows[0].name})
      } else {
        errors.push("Neteisingas vartotojo vardas arba slaptažodis.")
      }
    }).catch(e => {
      errors.push(e)
    })
  if (errors.length > 0) {
    res.status(400).json({errors: errors})
  }
  con.end()
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
