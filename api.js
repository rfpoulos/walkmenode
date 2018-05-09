const express = require('express');
const bodyParser = require('body-parser');
const api = new express.Router();
const multer  = require('multer');
const fs = require('fs');
const { 
        userByIdFromDb,
        addProfilePicture,
        postWalkDb,
        addWalkThumbnail,
    } = require('./queries');

api.get('/user', (req, res) => {
    let { userId } = req.jwt;
    userByIdFromDb(userId)
    .then(data => res.send(data[0]));
});

api.post('/postprofilepic', 
            multer({ dest: 'public/uploads/profile-pics'}).single('thumbnail'), 
            (req, res) => {
    let { userId } = req.jwt;
    addProfilePicture(userId, 'uploads/profile-pics/' + req.file.filename);
    res.send('uploads/profile-pics/' + req.file.filename);
});

api.post('/postwalk', (req, res) => {
    let { userId } = req.jwt;
    let { title, description } = req.body;
    postWalkDb(userId, title, description)
    .then(data => res.send(data))
});

api.post('/postwalkthumbnail', 
        multer({ dest: 'public/uploads/walk-thumbnail'}).single('walk-thumbnail'),
        (req, res) => {
    let walkId = req.body.id;
    console.log(walkId);
    addWalkThumbnail(walkId, 'uploads/walk-thumbnail/' + req.file.filename);
    res.send('uploads/walk-thumbnail/' + req.file.filename);
});


module.exports = api;
