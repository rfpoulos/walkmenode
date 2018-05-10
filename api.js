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
        addWalkAudio,
        addWalkVideo,
        addPoiDb,
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
    addWalkThumbnail(walkId, 
        'uploads/walk-thumbnail/' + req.file.filename)
        .then(path => res.send(path[0].thumbnail));
});

api.post('/postwalkaudio', 
        multer({ dest: 'public/uploads/walk-audio'}).single('walk-audio'),
        (req, res) => {
    let walkId = req.body.id;
    addWalkAudio(walkId, 
        'uploads/walk-audio/' + req.file.filename);
    res.send('uploads/walk-audio/' + req.file.filename);
});

api.post('/postwalkvideo', 
        multer({ dest: 'public/uploads/walk-video'}).single('walk-video'),
        (req, res) => {
    let walkId = req.body.id;
    addWalkVideo(walkId, 
        'uploads/walk-video/' + req.file.filename);
    res.send('uploads/walk-video/' + req.file.filename);
});

api.post('/postpoi', (req, res) => {
    let { walkid, title, lat, long, address, position } = req.body;
    addPoiDb(walkid, title, 
            parseFloat(lat), parseFloat(long), address, parseInt(position))
    .then(data => res.send(data[0]));
});


module.exports = api;
