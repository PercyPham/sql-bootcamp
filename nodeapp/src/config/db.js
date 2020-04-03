import Sequelize from "sequelize"

const dbName = process.env.DB_NAME || "database"
const username = process.env.DB_USER || "user"
const password = process.env.DB_USER_PASSWORD || "password"
const host = process.env.DB_HOST || "localhost"

const sequelize = new Sequelize(dbName, username, password, {
  host,
  dialect: 'postgres',
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000
  }
});

export default sequelize
