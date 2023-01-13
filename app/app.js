'use strict'

const express = require('express')
const openapi = require('express-openapi');
const bodyParser = require('body-parser')

const YAML = require('yamljs')
const apiDoc = YAML.load('./api-doc.yml');

const app = express()
const controllers = require('./controllers')
const openAPICustom = require('./lib/openAPI')

openapi.initialize({
  app,
  apiDoc: {
    ...apiDoc,
    'x-express-openapi-additional-middleware': [openAPICustom.validateAllResponses],
    'x-express-openapi-validation-strict': true
  },
  consumesMiddleware: {
    'application/json': bodyParser.json(),
    'text/text': bodyParser.text()
  },
  errorMiddleware: function(err, req, res, next) { 
    res.status(err.status || 400).json(err)
  },
  operations: controllers
}); 

module.exports = app
