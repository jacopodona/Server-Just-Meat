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

app.use('/auth', auth);
app.use('/api/v1', application);

// Enjoy
app.listen(8080, () => console.log('Server started on port 8080'));