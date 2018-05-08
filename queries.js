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
        INSERT INTO users (email, username, password, aboutme, thumbnail)
        VALUES ('${email}', '${username}', '${password}', '${aboutMe}',
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

module.exports = {
    userByIdentifier,
    createAccountInDb,
    userByIdFromDb,
    addProfilePicture
}
