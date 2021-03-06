require('dotenv').config()
const pg = require('pg-promise')();
const db = pg(process.env.DATABASE_URL);

let getWalkByTitle = (search) =>
    db.query(`
        SELECT * FROM walks
        WHERE title ILIKE '%${search}%';
    `)

let userByIdentifier = (identifier) =>
    db.query(`
        SELECT * FROM users
        WHERE username = '${identifier}'
        OR email = '${identifier}';
    `);

let createAccountInDb = (email, username, password, aboutMe) =>
    db.query(`
        INSERT INTO users (email, username, password, thumbnail)
        VALUES ('${email}', '${username}', '${password}',
                'uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf');
    `);

let userByIdFromDb = (id) =>
    db.query(`
        SELECT id, username, email, thumbnail, aboutme 
        FROM users
        WHERE id = ${id};
    `);
let addProfilePicture = (id, path) =>
    db.query(`
        UPDATE users
        SET thumbnail = '${path}'
        WHERE id = '${id}';
    `)

let postWalkDb = (userId, title, description) =>
    db.query(`
        INSERT INTO walks (userid, title, description, thumbnail)
        VALUES ('${userId}', '${title}', '${description}', 'defaults/walkme_icon.png')
        RETURNING *;
    `)
let addWalkThumbnail = (walkId, path) =>
    db.query(`
    UPDATE walks
    SET thumbnail = '${path}'
    WHERE id = '${walkId}'
    RETURNING thumbnail;
    `)

let addWalkAudio = (walkId, path) =>
    db.query(`
    UPDATE walks
    SET audio = '${path}'
    WHERE id = '${walkId}';
    `)

let addWalkVideo = (walkId, path) =>
    db.query(`
    UPDATE walks
    SET video = '${path}'
    WHERE id = '${walkId}';
    `)

let addPoiDb = (walkid, title, lat, long, address, position) =>
    db.query(`
        INSERT INTO pois (walkid, title, lat, long, address, position, thumbnail)
        VALUES ('${walkid}', '${title}', 
                '${lat}', '${long}', '${address}', '${position}',
                 'defaults/walkme_icon.png')
        RETURNING *;
    `)

let updatePoiPositionDb = (id, position) =>
    db.query(`
        UPDATE pois
        SET position = ${position}
        WHERE id = ${id};
    `)

let getWalkPoisDb = (walkid) =>
    db.query(`
        SELECT * FROM pois
        WHERE walkid = ${walkid}
        ORDER BY position;
    `)

let removePoiDb = (id) =>
    db.query(`
        DELETE FROM pois
        WHERE id = ${id}
        RETURNING walkid;
    `)

let addPoiThumbnail = (poiId, path) =>
    db.query(`
    UPDATE pois
    SET thumbnail = '${path}'
    WHERE id = '${poiId}'
    RETURNING thumbnail;
    `)

let addPoiAudio = (poiId, path) =>
    db.query(`
    UPDATE pois
    SET audio = '${path}'
    WHERE id = '${poiId}';
    `)

let addPoiVideo = (poiId, path) =>
    db.query(`
    UPDATE pois
    SET video = '${path}'
    WHERE id = '${poiId}';
    `)

let addPoiNextAudio = (poiId, path) =>
    db.query(`
    UPDATE pois
    SET next_audio = '${path}'
    WHERE id = '${poiId}';
    `)

let addPoiDescription = (id, description) =>
    db.query(`
    UPDATE pois
    SET description = '${description}'
    WHERE id = '${id}'
    RETURNING *;
    `)

let addPoiTitle = (id, title) =>
    db.query(`
    UPDATE pois
    SET title = '${title}'
    WHERE id = '${id}'
    RETURNING *;
    `)

let addUserAboutMe = (id, aboutMe) =>
    db.query(`
    UPDATE users
    SET aboutme = '${aboutMe}'
    WHERE id = '${id}'
    RETURNING *;
    `)

let addUserLocation = (id, location) =>
    db.query(`
    UPDATE users
    SET location = '${location}'
    WHERE id = '${id}'
    RETURNING *;
    `)

let getContributedWalksDb = (userId) =>
    db.query(`
    SELECT walks.id, walks.thumbnail, walks.description,
    length, public, walks.title, address, username,
    users.thumbnail as guidethumbnail, lat, long
    FROM walks
    JOIN pois ON (pois.walkid = walks.id)
    JOIN users ON (users.id = walks.userid)
    WHERE userid = ${userId} AND position = 0;
    `)

let updateWalkLengthDb = (length, walkid) =>
    db.query(`
    UPDATE walks
    SET length = ${length}
    WHERE id = ${walkid};
    `)

let deleteWalkDb = (walkId) =>
    db.query(`
        DELETE FROM walks
        WHERE walks.id = ${walkId} 
    `)

let updatePublicStatusDb = (walkId) =>
    db.query(`
    UPDATE walks
    SET public = NOT public
    WHERE id = ${walkId};
    `)

let getGuideOrTitleDb = (input) =>
    db.query(`
    SELECT title as result
    FROM walks
    WHERE title ILIKE '%${input}%'
    UNION 
    SELECT username as result
    FROM users
    JOIN walks ON (users.id = walks.userid)
    WHERE username ILIKE '%${input}%'
    AND public = true
    FETCH NEXT 5 ROWS ONLY;
    `)

let getResultClickDb = (search, lat, lng) =>
    db.query(`
SELECT inner_table.walkid, 
    walks.thumbnail, 
    walks.description, 
    (length / 1609.334) as length, 
    walks.title, 
    users.thumbnail as guidethumbnail, 
    walks.video, 
    walks.audio,
    inner_table.address, 
    distance,   
    COUNT(pois.audio) + COUNT(pois.next_audio) as poisaudio, 
    COUNT(pois.video) as poisvideo, 
    AVG(rating) as ratingavg, 
    COUNT(rating) as ratingcount
FROM (
    SELECT address, 
        walkid,
        (acos(sin(radians($1)) * sin(radians(lat)) + 
        cos(radians($1)) * cos(radians(lat)) * 
        cos(radians(long) - radians(($2)))) * 6371) AS distance
    FROM pois
    WHERE position = 0
) as inner_table
JOIN walks ON (inner_table.walkid = walks.id)
JOIN users ON (walks.userid = users.id)
JOIN ratings ON (inner_table.walkid = ratings.walkid)
JOIN pois ON (inner_table.walkid = pois.walkid)
WHERE public = true
AND (walks.title = '${search}'
OR users.username = '${search}')
GROUP BY inner_table.walkid, 
    walks.thumbnail, 
    walks.description, 
    length, 
    public, 
    walks.title, 
    guidethumbnail, 
    walks.video, 
    walks.audio,
    inner_table.address, 
    distance
    ;`, [lat, lng]);

let getClickNoLocDb = (search) =>
    db.query(`
SELECT inner_table.walkid, 
    walks.thumbnail, 
    walks.description, 
    (length / 1609.334) as length, 
    walks.title, 
    users.thumbnail as guidethumbnail, 
    walks.video, 
    walks.audio,
    inner_table.address, 
    COUNT(pois.audio) + COUNT(pois.next_audio) as poisaudio, 
    COUNT(pois.video) as poisvideo, 
    AVG(rating) as ratingavg, 
    COUNT(rating) as ratingcount
FROM (
    SELECT address, walkid
    FROM pois
    WHERE position = 0
) as inner_table
JOIN walks ON (inner_table.walkid = walks.id)
JOIN users ON (walks.userid = users.id)
JOIN ratings ON (inner_table.walkid = ratings.walkid)
JOIN pois ON (inner_table.walkid = pois.walkid)
WHERE public = true
AND (walks.title = '${search}'
OR users.username = '${search}')
GROUP BY inner_table.walkid, 
    walks.thumbnail, 
    walks.description, 
    length, 
    public, 
    walks.title, 
    guidethumbnail, 
    walks.video, 
    walks.audio,
    inner_table.address 
    ;`);
    
let getResultsWithinDistance = (
    lat, 
    lng, 
    milesClause, 
    sortBy, 
    limit, 
    audioVideoClause
) => db.query(`
SELECT inner_table.walkid, 
    walks.thumbnail, 
    walks.description, 
    (length / 1609.334) as length, 
    walks.title, 
    users.thumbnail as guidethumbnail, 
    walks.video, 
    walks.audio,
    inner_table.address, 
    distance,   
    COUNT(pois.audio) + COUNT(pois.next_audio) as poisaudio, 
    COUNT(pois.video) as poisvideo, 
    AVG(rating) as ratingavg, 
    COUNT(rating) as ratingcount
FROM (
    SELECT address, 
        walkid,
        (acos(sin(radians($1)) * sin(radians(lat)) + 
        cos(radians($1)) * cos(radians(lat)) * 
        cos(radians(long) - radians(($2)))) * 6371) AS distance
    FROM pois
    WHERE position = 0
) as inner_table
JOIN walks ON (inner_table.walkid = walks.id)
JOIN users ON (walks.userid = users.id)
JOIN ratings ON (inner_table.walkid = ratings.walkid)
JOIN pois ON (inner_table.walkid = pois.walkid)
WHERE public = true
${milesClause}
GROUP BY inner_table.walkid, 
    walks.thumbnail, 
    walks.description, 
    length, 
    public, 
    walks.title, 
    guidethumbnail, 
    walks.video, 
    walks.audio,
    inner_table.address, 
    distance
${audioVideoClause}
ORDER BY ${sortBy}
LIMIT ${limit};
    `, [lat, lng])

let getWalkDb = (id) =>
    db.query(`
    SELECT walks.id, walks.thumbnail, walks.description,
    length, public, walks.title, address, username,
    users.thumbnail as guidethumbnail, lat, long, 
    walks.video, walks.audio
    FROM walks
    JOIN pois ON (pois.walkid = walks.id)
    JOIN users ON (users.id = walks.userid)
    WHERE walks.id = ${id}; 
    `)

let getProfileDb = (username) =>
    db.query(`
    SELECT * FROM users
    WHERE username = '${username}';
    `)

module.exports = {
    userByIdentifier,
    createAccountInDb,
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
    addPoiDescription,
    addPoiTitle,
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
    getWalkByTitle,
    getClickNoLocDb,
}
