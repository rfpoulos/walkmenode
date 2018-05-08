const express = require('express');
const bodyParser = require('body-parser');
const api = new express.Router();
const multer  = require('multer');
const upload = multer({ dest: 'public/uploads/profile-pics'});
const fs = require('fs');
const { 
        userByIdFromDb,
        addProfilePicture
    } = require('./queries');

api.get('/user', (req, res) => {
    let { userId } = req.jwt;
    userByIdFromDb(userId)
    .then(data => res.send(data[0]));
});

api.post('/postprofilepic', upload.single('thumbnail'), (req, res) => {
    let { userId } = req.jwt;
    addProfilePicture(userId, 'uploads/profile-pics/' + req.file.filename);
    console.log(req.file.filename);
    res.send('uploads/profile-pics/' + req.file.filename);
});


module.exports = api;
