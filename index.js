const express = require('express');
const bodyParser = require('body-parser');
const passport = require('passport');

// Configuration files
require('./config/passport-config');
require('./config/postgres-config');

// Routes
const auth = require('./routes/auth');
const application = require('./routes/application');

const app = express();

// Server options
app.use(bodyParser.json());
app.use(passport.initialize());

app.post('/test', (req, res) => {
  res.json({ code: 200, message: req.body.test + " from server!" });
})

app.use('/auth', auth);
app.use('/api/v1', application);

// Enjoy
app.listen(process.env.PORT || 5000)