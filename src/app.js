const express = require('express');

const app = express();

app.get('/', (req, res) => res.send('hello world3'));

module.exports = app;
