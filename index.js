const express = require('express');
var bodyParser = require('body-parser');

// For authorization
const jwt = require('jsonwebtoken');

// For postgres connection
const { Client } = require('pg');

// Hashing library
const bcrypt = require('bcrypt');

// Custom modules
const { verifyEmail } = require('./modules/utilities');
const { queries } = require('./modules/queries');

// Database configuration
const connection_string = 'postgressql://admin:admin@localhost:5432/just_meat';
const client = new Client({
  connectionString: connection_string,
})
client.connect();

// Bcrypt configuration
const saltRounds = 8;

// Passport configuration
var passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const FacebookStrategy = require('passport-facebook-token');
const FACEBOOK_APP_ID = "asd";
const FACEBOOK_APP_SECRET = "asd";

const GoogleStrategy = require('passport-token-google2').Strategy;
const GOOGLE_CLIENT_ID = "asd";
const GOOGLE_CLIENT_SECRET = "asd";

// JWT secret key
const jwt_secret_key = 'C4ERJydv5yFZBz9iMBhK'; // random string



const app = express();

// server options
app.use(bodyParser.json());
app.use(passport.initialize());

// Account creation with username and password
app.post('/api/signup', (req, res) => {

  const user = {
    name: req.body.name,
    last_name: req.body.last_name,
    address: req.body.address,
    birth_date: req.body.birth_date.toString(),
    mail: req.body.mail,
    password: req.body.psw
  }

  // Parameters check
  if(!verifyEmail(user.mail)
    || user.password.length < 8
    || (user.password !== req.body.check_psw)
    || !user.name
    || !user.last_name
    || !user.mail
    || !user.birth_date
    || !user.address)
    return res.status(500).send('Incorrect data.');


  // Check if user already exists
  client.query(queries.exists_user(user.mail), (err, result) => {
    if(err) {
      return res.status(500).send(err.message);
    } else if (result.rows[0].count >= 1) {
      // User with such mail already exists
      return res.status(500).send('User with such mail already exists.');
    } else {
      // Insert user in database
      client.query(queries.insert_user(user.name, user.last_name, user.address, user.birth_date), (err, result) => {
        if(err) {
          return res.status(500).send('An user with such email is already registered.');
        } else {
          const user_id = result.rows[0].id;
          // Hash its password
          bcrypt.hash(user.password, saltRounds, (err, hash) => {
            if(err) {
              return res.status(500).send('Couldn\'t properly compute an hash.');
            } else {
              // Insert credentials in database
              client.query(queries.insert_credentials(user_id, hash, user.mail), (err, result) => {
                if(err) {
                  return res.status(500).send('Couldn\'t insert credentials in database.');
                } else {
                  return res.status(200).send('OK.');
                }
              });
            }
          });
        }
      });
    }
  })
});

app.post('/api/login/local', passport.authenticate('local', { session: false }), (req, res) => {
  if(req.user.message) {
    return res.status(500).send(req.user.message);
  }

  jwt.sign(req.user, jwt_secret_key, (err, token) => {
    if(err) {
      return res.status(500).send('An error occured while generating session token.');
    }
    return res.status(200).json({
      user: req.user,
      token
    });
  });
});

app.post('/api/login/facebook', passport.authenticate('facebook-token', { session: false }), (req, res) => {
  if(req.user.message) {
    return res.status(500).send(req.user.message);
  }

  console.log(req.user);
  
  return res.status(500).send('Service temporary unavailable.');

  /*jwt.sign(req.user, jwt_secret_key, (err, token) => {
    if(err) {
      return res.status(500).send('An error occured while generating session token.');
    }
    return res.status(200).json({
      user: req.user,
      token
    });
  });*/
});

app.post('/api/login/google', passport.authenticate('google-token', { session: false }), (req, res) => {
  if(req.user.message) {
    return res.status(500).send(req.user.message);
  }

  console.log(req.user);
  
  return res.status(500).send('Service temporary unavailable.');

  /*jwt.sign(req.user, jwt_secret_key, (err, token) => {
    if(err) {
      return res.status(500).send('An error occured while generating session token.');
    }
    return res.status(200).json({
      user: req.user,
      token
    });
  });*/
});

app.get('/api/protected_data', verifyToken, (req, res) => {
  jwt.verify(req.token, jwt_secret_key, (err, auth_data) => {
    if(err) {
      return res.status(403).send('Forbidden');
    }
    //get needed data
    return res.json(auth_data);
  });
});

// Verify JSON Web Token
function verifyToken(req, res, next) {
  const bearerHeader = req.headers['authorization'];
  if(bearerHeader) {
    req.token = bearerHeader.split(' ')[1];
    next();
  } else {
    res.status(403).send('Forbidden');
  }
}

// Passport strategies
passport.use(new LocalStrategy({ usernameField: 'mail', passwordField: 'psw' },
  function(mail, psw, done) {
    client.query(queries.get_password_from_mail(mail), (err, result) => {
      if(err) return done(err);
      if(!result) return done(null, { message: 'An user with such email is not registered.' });
      if(result.rowCount === 0) return done(null, { message: 'Incorrect email.' });
      bcrypt.compare(psw, result.rows[0].hashed_password, (err, res) => {
        if(err) return done(err);
        if(!res) return done(null, { message: 'Incorrect password.' });
        client.query(queries.get_user(result.rows[0].fk_user), (err, res) => {
          if(err) return done(err)
          return done(null, {
            name: res.rows[0].name,
            last_name: res.rows[0].last_name,
            address: res.rows[0].address,
            birth_date: res.rows[0].birth_date.toString(),
            mail: mail,
          });
        });
      });
    });
  }
));

passport.use(new FacebookStrategy({
    clientID: FACEBOOK_APP_ID,
    clientSecret: FACEBOOK_APP_SECRET
  }, function(accessToken, refreshToken, profile, done) {
    return done(null, profile);
    /*User.findOrCreate({facebookId: profile.id}, function (error, user) {
      return done(error, user);
    });*/
  }
));

passport.use(new GoogleStrategy({
    clientID: GOOGLE_CLIENT_ID,
    clientSecret: GOOGLE_CLIENT_SECRET
  }, function(accessToken, refreshToken, profile, done) {
    fetchGoogleUser(profile, accessToken)
      .then((user) => done(null, user))
      .catch((err) => {
        return done(err)
      });
  }
));

app.listen(5000, () => console.log('Server started on port 5000'));