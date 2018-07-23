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
        updatePoiPositionDb,
        getWalkPoisDb,
        removePoiDb,
        addPoiThumbnail,
        addPoiAudio,
        addPoiVideo,
        addPoiNextAudio,
        addPoiTitle,
        addPoiDescription,
        addUserAboutMe,
        addUserLocation,
        getContributedWalksDb,
        updateWalkLengthDb,
        deleteWalkDb,
        updatePublicStatusDb,
        getGuideOrTitleDb,
        getResultClickDb,
        getResultsWithinDistance,
        getWalkDb,
        getProfileDb,
    } = require('./queries');

api.get('/user', async (req, res) => {
    let { userId } = req.jwt;
    try {
        let userData = await userByIdFromDb(userId)
        res.send(userData[0])
    } catch (err) {
        res.status(400);
    }
});

api.post('/postprofilepic', 
            multer({ dest: 'public/uploads/profile-pics'}).single('thumbnail'), 
            (req, res) => {
    let { userId } = req.jwt;
    addProfilePicture(userId, 'uploads/profile-pics/' + req.file.filename);
    res.send('uploads/profile-pics/' + req.file.filename);
});

api.post('/userlocation', async (req, res) => {
    let { userId } = req.jwt;
    let { location } = req.body;
    let result = await addUserLocation(userId, location);
    delete result[0].password;
    res.send(result[0]);
})

api.post('/useraboutme', async (req, res) => {
    let { userId } = req.jwt;
    let { aboutMe } = req.body;
    let result = await addUserAboutMe(userId, aboutMe);
    delete result[0].password;
    res.send(result[0]);
})

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

api.post('/updatepoipositions', async (req, res) => {
    [firstPoi, secondPoi] = req.body;
    await Promise.all([updatePoiPositionDb(firstPoi.id, firstPoi.position),
        updatePoiPositionDb(secondPoi.id, secondPoi.position)]);
    let newList = await getWalkPoisDb(firstPoi.walkid)
    res.send(newList);
})

api.delete('/deletepoi/:id', async (req, res) => {
    walkId = await removePoiDb(parseInt(req.params.id));
    id = walkId[0].walkid;
    let updatedPois = await getWalkPoisDb(id);
    let newPositions = updatedPois.map((element, i) => {
        element.position = i;
        return element;
    })
    await Promise.all(
        newPositions.map(element =>
            updatePoiPositionDb(element.id, element.position)));
    let newList = await getWalkPoisDb(id);
    res.send(newList);
})

api.post('/poidescription', async (req, res) => {
    let { id, description } = req.body;
    let updatedPoi = await addPoiDescription(id, description);
    res.send(updatedPoi[0]);
})

api.post('/poititle', async (req, res) => {
    let { id, title } = req.body;
    let updatedPoi = await addPoiTitle(id, title);
    res.send(updatedPoi[0]);
})

api.post('/postpoithumbnail', 
        multer({ dest: 'public/uploads/poi-thumbnail'}).single('poi-thumbnail'),
        (req, res) => {
    let poiId = req.body.id;
    addPoiThumbnail(poiId, 
        'uploads/poi-thumbnail/' + req.file.filename)
        .then(path => res.send(path[0].thumbnail));
});

api.post('/postpoiaudio', 
        multer({ dest: 'public/uploads/poi-audio'}).single('poi-audio'),
        (req, res) => {
    let poiId = req.body.id;
    addPoiAudio(poiId, 
        'uploads/poi-audio/' + req.file.filename);
    res.send('uploads/poi-audio/' + req.file.filename);
});

api.post('/postpoivideo', 
        multer({ dest: 'public/uploads/poi-video'}).single('poi-video'),
        (req, res) => {
    let poiId = req.body.id;
    addPoiVideo(poiId, 
        'uploads/poi-video/' + req.file.filename);
    res.send('uploads/poi-video/' + req.file.filename);
});

api.post('/postpoinextaudio', 
        multer({ dest: 'public/uploads/poi-next-audio'}).single('poi-next-audio'),
        (req, res) => {
    let poiId = req.body.id;
    addPoiNextAudio(poiId, 
        'uploads/poi-next-audio/' + req.file.filename);
    res.send('uploads/poi-next-audio/' + req.file.filename);
});

api.get('/getwalkpois/:id', async (req, res) => {
    let walkid = req.params.id;
    let result = await getWalkPoisDb(parseInt(walkid));
    res.send(result);
})

api.get('/getcontributedwalks', async (req, res) => {
    let { userId } = req.jwt;
    let results = await getContributedWalksDb(userId);
    res.send(results);
})

api.post('/updatewalklength', async (req, res) => {
    let { length, walkid } = req.body;
    await updateWalkLengthDb(length, walkid);
    res.send('Updated.')
})

api.delete('/deletewalk/:id', async (req, res) => {
    let walkid = req.params.id;
    let { userId } = req.jwt
    await deleteWalkDb(walkid);
    let results = await getContributedWalksDb(userId);
    res.send(results);
})

api.put('/updatepublicstatus/:id', async (req, res) => {
    let walkId = req.params.id;
    await updatePublicStatusDb(walkId);
    let { userId } = req.jwt
    let results = await getContributedWalksDb(userId);
    res.send(results);
})

api.get('/getguideortitle/:search', async (req, res) => {
    let search = req.params.search;
    if (search) {
        let results = await getGuideOrTitleDb(search);
        if (results) {
            res.send(results);
        } else {
            res.send([]);
        }
    } else {
        res.send([]);
    }
})

api.get('/getresultclick/:search', async (req, res) => {
    let search = req.params.search;
    let results = await getResultClickDb(search);
    res.send(results);
})

api.get('/getresultswithindistance/:lat/:lng/:miles/:limit/:sortBy', async (req, res) => {
    let { lat, lng, miles, limit, sortBy } = req.params;
    let milesClause = '';
    if (miles !== 'all') {
        milesClause = `AND distance <= ${parseInt(miles)}`
    }
        let results = await getResultsWithinDistance(
            parseFloat(lat), 
            parseFloat(lng), 
            milesClause,
            sortBy,            
            parseInt(limit)
        );
        res.send(results);

})

api.get('/getwalk/:id', async (req, res) => {
    let { id } = req.params;
    let results = await Promise.all([getWalkDb(id), getWalkPoisDb(id)]);
    [resultArray, pois] = results;
    res.send({ walk: resultArray[0], pois })
})

api.get('/getprofile/:username', async (req, res) => {
    let { username } = req.params;
    let result = await getProfileDb(username);
    delete result[0].password;
    res.send(result[0]);
})

module.exports = api;
