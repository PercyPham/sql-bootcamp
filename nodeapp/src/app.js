import express from "express"
import sequelize from "./config/db.js"

sequelize.authenticate()
  .then(() => console.log('Connection has been established successfully.'))
  .catch(err => console.error('Unable to connect to the database:', err));

const app = express()

app.get("/", (req, res) => {
  res.send("OK")
})

const port = process.env.PORT || 5000
app.listen(port, () => console.log("Server is listenning on port", port))