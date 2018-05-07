const express = require('express');
const api = new express.Router();
const { userByIdFromDb } = require('./queries');

api.get('/user', (req, res) => {
    let { userId } = req.jwt;
    userByIdFromDb(userId)
    .then(data => res.send(data[0]));
});

module.exports = api;
