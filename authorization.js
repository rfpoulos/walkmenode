require('dotenv').config()
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const signature = process.env.SIGNATURE;

const { userByIdentifier, createAccountInDb } = require('./queries');

let checkToken = async (req, res, next) => {
  let { authorization: token } = req.headers;
  let payload;
  try {
    payload = await jwt.verify(token, signature);
  } catch(err) {
    console.log(err);
  }

  if (payload) {
    req.jwt = payload;
    next();
  } else {
    res.send('Invalid Token');
  }
};

let createToken = user =>
  jwt.sign(
    { userId: user.id},
    signature,
    { expiresIn: '7d' }
  );

let postTokens = async (req, res) => {
  let { identifier, password } = req.body;
  let user = await userByIdentifier(identifier);
  user = user[0];
  let isValid = await bcrypt.compare(password, user.password);
  if (isValid) {
    let token = createToken(user);
    user.token = token;
    delete user.password;
    res.send(user);
  } else {
    res.send('Invalid identifier and/or password.');
  }
};

let saltAndHashPassword = (password) =>
  bcrypt.hash(password, 10);

let createAccount = (req, res) => {
    let { email, username, password } = req.body;
    saltAndHashPassword(password)
    .then(hashedPassword => {
        createAccountInDb(email, username, hashedPassword)
        .then(res.send('User added.'));
    })
}

module.exports = {
    createAccount,
    postTokens,
    checkToken
}