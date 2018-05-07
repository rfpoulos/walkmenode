const express = require('express');
const Router = express.Router;
const bodyParser = require('body-parser');

const app = express();
const router = new Router();

const { postTokens, createAccount, checkToken } = require('./authorization');
const api =  require('./api')

router.post('/signin', postTokens);
router.post('/createaccount', createAccount);
router.use('/', checkToken, api);

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    next();
  });
app.use(bodyParser.json());
app.use(router);
app.listen(process.env.PORT || 5000);
