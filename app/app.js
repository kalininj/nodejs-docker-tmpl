'use strict'

const express = require('express')
const openapi = require('express-openapi');
const bodyParser = require('body-parser')
const path = require('path');
const YAML = require('yamljs')
const swaggerUi = require("swagger-ui-express")

const apiDocPath = path.resolve(__dirname, './api-doc.yml')
const apiDoc = YAML.load(apiDocPath);

const app = express()
const controllers = require('./controllers')
const openAPICustom = require('./lib/openAPI')

if (process.env.SHOW_DOCS) {
  app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(apiDoc));
}

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
