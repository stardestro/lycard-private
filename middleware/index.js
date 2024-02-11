const express = require('express');
const bodyParser = require('body-parser');
// const { Sequelize, Model, DataTypes } = require('sequelize');
const getloc = require('./models/vision')
const getBestCard = require('./models/bestcard')

require('dotenv').config()

const app = express();
const port = process.env.PORT;

// Create Sequelize instance
// const sequelize = new Sequelize({
//   dialect: 'sqlite',
//   storage: './database.sqlite'
// });

// Define User model
// class User extends Model {}
// User.init({
//   name: DataTypes.STRING,
//   email: DataTypes.STRING,
//   password: DataTypes.STRING,
// }, { sequelize, modelName: 'user' });

// Sync models with database
// sequelize.sync();

// Middleware for parsing request body
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('we up bois');
});

// Process Image
app.get('/processlocation', async (req, res) => {
  res.json(await getloc(req.query.image))
})

app.get('/bestcard', async (req, res) => {
  res.json(await getBestCard(req.query.category))
})

// Start server
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});