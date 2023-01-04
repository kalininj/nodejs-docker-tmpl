const express = require('express');

const app = express();

app.get('/', (req, res) => {
  console.log(process.env)
  res.send('hello world ' + process.env.TEST_VAR)
});

module.exports = app;
