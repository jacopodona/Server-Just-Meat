// Passport configuration
const bcrypt = require('bcrypt');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const FacebookStrategy = require('passport-facebook-token');
const GoogleStrategy = require('passport-token-google2').Strategy;

// Custom modules
const client = require('../config/postgres-config');
const { queries } = require('../modules/queries');
const constants = require('./constants');

// Strategies
passport.use(new LocalStrategy({ usernameField: 'mail', passwordField: 'psw' },
  function(mail, psw, done) {
    client.query(queries.get_password_from_mail(mail), (err, result) => {
      if(err) return done(err);
      if(result.rowCount === 0) return done(null, { message: 'Email non corretta.' });
      bcrypt.compare(psw, result.rows[0].hashed_password, (err, res) => {
        if(err) return done(err);
        if(!res) return done(null, { message: 'Password non corretta.' });
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
// To implement
passport.use(new FacebookStrategy({
    clientID: constants.FACEBOOK_APP_ID,
    clientSecret: constants.FACEBOOK_APP_SECRET
  }, function(accessToken, refreshToken, profile, done) {
    return done(null, profile);
  }
));
// To implement
passport.use(new GoogleStrategy({
    clientID: constants.GOOGLE_CLIENT_ID,
    clientSecret: constants.GOOGLE_CLIENT_SECRET
  }, function(accessToken, refreshToken, profile, done) {
    fetchGoogleUser(profile, accessToken)
      .then((user) => done(null, user))
      .catch((err) => {
        return done(err)
      });
  }
));