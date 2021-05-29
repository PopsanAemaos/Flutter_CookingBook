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
    lname
  } = req.body
  const result = await user.create({
    username,
    password,
    fname,
    lname
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
  // const result  = {
  //   total: resRecipe.length,
  //   data: resRecipe
  // }
  // console.log('[get] => recipe', resRecipe);
  return res.status(200).json(resRecipe)
})

app.get('/recipeuser', async (req, res) => {
  console.log('[get] => recipe');
  const {
    recipe_id
  } = req.query
  let query = {}
  if(recipe_id){
    query = {
      _id:recipe_id
    }
    delete req.query.recipe_id
  } 
  const resRecipe = await recipe.find(query)
  // const result  = {
  //   total: resRecipe.length,
  //   data: resRecipe
  // }
  console.log('[get] => recipe', resRecipe);
  return res.status(200).json(resRecipe)
})


app.post('/recipe', async (req, res) => {
  console.log('[post] => recipe');
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


// global error handler


// start server
const port = 3030;
const server = app.listen(port, function () {
  console.log('Server listening on port ' + port);
});
