const express = require('express');
const bodyParser = require('body-parser');
const passport = require('passport');
const jwt = require('jsonwebtoken');

// Configuration files
require('./config/passport-config');
require('./config/postgres-config');
const constants = require('./config/constants');
const { verifyToken } = require('./modules/utilities');

// Routes
const auth = require('./routes/auth');
const application = require('./routes/application');

const app = express();

// Server options
app.use(bodyParser.json());
app.use(passport.initialize());
app.use(express.static('public'));

app.post('/test', (req, res) => {
  res.json({ code: 200, message: req.body.test + " from server!" });
})

app.get('/authenticationtest', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if(err) {
      res.json({ code: 200, message: err })
    } else {
      res.json({ code: 200, message: auth_data })
    }
  });
})

app.use('/auth', auth);
app.use('/api/v1', application);

// Enjoy
app.listen(process.env.PORT || 8080)