require('dotenv').config()
const pg = require('pg-promise')();
const db = pg(process.env.DB_PATH);

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

module.exports = {
    userByIdentifier,
    createAccountInDb,
    userByIdFromDb,
    addProfilePicture,
    postWalkDb,
    addWalkThumbnail,
    addWalkAudio,
    addWalkVideo,
    addPoiDb
}
