const express = require('express');
const bodyParser = require('body-parser');
const { Sequelize, Model, DataTypes } = require('sequelize');
const getloc = require('./models/vision')
const getBestCard = require('./models/bestcard')

require('dotenv').config()

const app = express();
const port = process.env.PORT | 7123;

// Create Sequelize instance
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: './database.sqlite'
});

// Define User model
class User extends Model {}
User.init({
  name: DataTypes.STRING,
  email: DataTypes.STRING,
  password: DataTypes.STRING,
}, { sequelize, modelName: 'user' });

// Sync models with database
sequelize.sync();

// Middleware for parsing request body
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Process Image
app.get('/processlocation', async (req, res) => {
  res.json(await getloc(req.query.image))
})

app.get('/bestcard', async (req, res) => {
  res.json(await getBestCard(req.query.category))
})

// CRUD routes for User model
// app.get('/users', async (req, res) => {
//   const users = await User.findAll();
//   res.json(users);
// });

// app.get('/users/:id', async (req, res) => {
//   const user = await User.findByPk(req.params.id);
//   res.json(user);
// });

// app.post('/users', async (req, res) => {
//   const user = await User.create(req.body);
//   res.json(user);
// });

// app.put('/users/:id', async (req, res) => {
//   const user = await User.findByPk(req.params.id);
//   if (user) {
//     await user.update(req.body);
//     res.json(user);
//   } else {
//     res.status(404).json({ message: 'User not found' });
//   }
// });

// app.delete('/users/:id', async (req, res) => {
//   const user = await User.findByPk(req.params.id);
//   if (user) {
//     await user.destroy();
//     res.json({ message: 'User deleted' });
//   } else {
//     res.status(404).json({ message: 'User not found' });
//   }
// });

// Start server
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});