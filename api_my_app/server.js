require('rootpath')();
require = require('esm')(module);
const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
// const jwt = require('_helpers/jwt');
// const checkToken = require('_helpers/check-token');
// const errorHandler = require('_helpers/error-handler');
// const config = require('config');
const mongoose = require('./mongoose');
// const generateEndpoint = require('./utils/generate-endpoint-webhook')


app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

import {
  user,
  favorite,
  recipe
} from './src/models'

app.get('/user', async (req, res) => {
  console.log('[get] => user');
  const result = await user.findOne({
    ...req.query
  })
  return res.status(200).json(result)
})

app.post('/user', async (req, res) => {
  console.log('[post] => user');
  const {
    username,
    password,
    fname,
    lname,
    user_id
  } = req.body
  const result = await user.create({
    username,
    password,
    fname,
    lname,
    user_id
  })
  return res.status(201).json(result)
})

app.get('/recipe', async (req, res) => {
  console.log('[get] => recipe');
  const {
    recipe_id
  } = req.query
  let query = {}
  if(recipe_id){
    query = {
      ...req.query,
      _id:recipe_id
    }
    delete req.query.recipe_id
  } 
  const resRecipe = await recipe.find(query)
  return res.status(200).json(resRecipe)
})

app.get('/findrecipe', async (req, res) => {
  console.log(`${new Date()}[get] => findrecipe'`);
  const {
    name
  } = req.query
  let resRecipe;
  if(name !== ''){
    resRecipe = await recipe.find({
      title:{  $regex: name }
    })
  } else {
    resRecipe = await recipe.find({
      title:{  $regex: name }
    })
  }
  return res.status(200).json(resRecipe)
})


app.get('/findrecipeuser', async (req, res) => {
  console.log(`${new Date()}[get] => recipeuser'`);
  const {
    user_id
  } = req.query
  let query = {}
  const resUser = await user.findOne({
    user_id:user_id
  })
  const resRecipe = await recipe.find({
    user_id: resUser.id
  });
  console.log('[get] => recipe');
  return res.status(200).json(resRecipe)
})


app.post('/addRecipe', async (req, res) => {
  console.log(`${new Date()}[get] => addRecipe`);
  const {
    title,
    ingredient,
    method,
    descriotion,
    images,
    user_id
  } = req.body
  const parseIngredient = ingredient.split("\n");
  const parseMethod = method.split("\n");
  const resUser = await user.findOne({
    user_id: user_id,
  }) 
  const data = {
    title,
    ingredient: parseIngredient,
    method: parseMethod,
    descripttion: descriotion,
    images,
    user_id: resUser._id
  }
  const result = await recipe.create(data)
  return res.status(201).json(result)
})

app.post('/recipe', async (req, res) => {
  console.log(`${new Date()}[get] => addRecipe`);
  const {
    title,
      ingredient,
      method,
      descripttion,
      images,
      user_id
  } = req.body
  const result = await recipe.create({
    title,
    ingredient,
    method,
    descripttion,
    images,
    user_id
  })
  return res.status(201).json(result)
})

app.get('/deleteRecipe', async (req, res) => {
  console.log(`${new Date()}[get] => deleteRecipe'`);
  const {
    recipe_id
  } = req.query
  const resRecipe = await recipe.deleteMany({
    _id: recipe_id
  });
  console.log('[get] => deleteRecipe');
  return res.status(200).json({
    status: 'success',
    code: '200'
  })
})

// global error handler


// start server
const port = 30301;
const server = app.listen(port, function () {
  console.log('Server listening on port ' + port);
});
