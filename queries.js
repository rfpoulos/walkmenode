require('dotenv').config()
const pg = require('pg-promise')();
const db = pg(process.env.DB_PATH);

let userByIdentifier = (identifier) =>
    db.query(`
        SELECT * FROM users
        WHERE username = '${identifier}'
        OR email = '${identifier}';
    `);

let createAccountInDb = (email, username, password) =>
    db.query(`
        INSERT INTO users (email, username, password)
        VALUES ('${email}', '${username}', '${password}');
    `);

module.exports = {
    userByIdentifier,
    createAccountInDb
}
