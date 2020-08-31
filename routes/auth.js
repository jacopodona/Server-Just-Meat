const router = require('express').Router();
const passport = require('passport');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Custom modules
const constants = require('../config/constants');
const client = require('../config/postgres-config');
const { queries } = require('../modules/queries');
const { verifyEmail } = require('../modules/utilities');

// Account creation with username and password
router.post('/signup', (req, res) => {

    const user = {
      name: req.body.name,
      last_name: req.body.last_name,
      mail: req.body.mail,
      password: req.body.psw
    }
  
    // Parameters check
    if(!verifyEmail(user.mail)
      || user.password.length < 8
      || (user.password !== req.body.check_psw)
      || !user.name
      || !user.last_name
      || !user.mail)
      return res.status(200).json({ code: 500, message: 'Incorrect data.' });
  
  
    // Check if user already exists
    client.query(queries.exists_user(user.mail), (err, result) => {
      if(err) {
        return res.status(200).json({ code: 500, message: err.message });
      } else if (result.rows[0].count >= 1) {
        // User with such mail already exists
        return res.status(200).json({ code: 500, message: 'User with such mail already exists.'});
      } else {
        // Insert user in database
        client.query(queries.insert_user(user.name, user.last_name), (err, result) => {
          if(err) {
            return res.status(200).json({ code: 500, message: 'An user with such email is already registered.' });
          } else {
            const user_id = result.rows[0].id;
            // Hash its password
            bcrypt.hash(user.password, constants.SALT_ROUNDS, (err, hash) => {
              if(err) {
                return res.status(200).json({ code: 500, message: 'Couldn\'t properly compute an hash.' });
              } else {
                // Insert credentials in database
                client.query(queries.insert_credentials(user_id, hash, user.mail), (err, result) => {
                  if(err) {
                    return res.status(200).json({ code: 500, message: 'Couldn\'t insert credentials in database.'});
                  } else {
                    return res.status(200).json({ code: 200, message: 'OK.' });
                  }
                });
              }
            });
          }
        });
      }
    })
  });
  
router.post('/login/local', passport.authenticate('local', { session: false }), (req, res) => {
  if(req.user.message) {
    return res.status(500).send(req.user.message);
  }

  jwt.sign(req.user, constants.JWT_SECRET_KEY, (err, token) => {
    if(err) {
      return res.status(500).send('An error occured while generating session token.');
    }
    return res.status(200).json({
      user: req.user,
      token
    });
  });
});

router.post('/login/other', passport.authenticate('provider', { session: false }), (req, res) => {
  let user = {
    name: req.body.name.split(' ')[0],
    last_name: req.body.last_name,
    mail: req.body.mail,
    password: req.body.id
  }

  if(req.user.id == -1) {
    client.query(queries.insert_user(user.name, user.last_name), (err, result) => {
      if(err) {
        return res.status(200).json({ code: 500, message: 'An user with such email is already registered.' });
      } else {
        const user_id = result.rows[0].id;
        // Hash its password
        bcrypt.hash(user.password, constants.SALT_ROUNDS, (err, hash) => {
          if(err) {
            return res.status(200).json({ code: 500, message: 'Couldn\'t properly compute an hash.' });
          } else {
            // Insert credentials in database
            client.query(queries.insert_credentials(user_id, hash, user.mail), (err, result) => {
              if(err) {
                return res.status(200).json({ code: 500, message: 'Couldn\'t insert credentials in database.'});
              }
              user = {
                id: user_id,
                name: user.name,
                last_name: user.last_name,
                mail: user.mail,
              }

              jwt.sign(user, constants.JWT_SECRET_KEY, (err, token) => {
                if(err) {
                  return res.status(500).send('An error occured while generating session token.');
                }
                return res.status(200).json({
                  user: user,
                  token
                });
              });
            });
          }
        });
      }
    });
  } else {
    user = {
      id: req.user.id,
      name: user.name,
      last_name: user.last_name,
      mail: user.mail,
    }

    jwt.sign(user, constants.JWT_SECRET_KEY, (err, token) => {
      if(err) {
        return res.status(500).send('An error occured while generating session token.');
      }
      return res.status(200).json({
        user: user,
        token
      });
    });
  }
});
  
// router.post('/login/facebook', passport.authenticate('facebook-token', { session: false }), (req, res) => {
//   if(req.user.message) {
//     return res.status(500).send(req.user.message);
//   }

//   console.log(req.user);
  
//   return res.status(500).send('Service temporary unavailable.');

//   /*jwt.sign(req.user, constants.JWT_SECRET_KEY, (err, token) => {
//     if(err) {
//       return res.status(500).send('An error occured while generating session token.');
//     }
//     return res.status(200).json({
//       user: req.user,
//       token
//     });
//   });*/
// });

// router.post('/login/google', passport.authenticate('google-token', { session: false }), (req, res) => {
//   if(req.user.message) {
//     return res.status(500).send(req.user.message);
//   }

//   console.log(req.user);
  
//   return res.status(500).send('Service temporary unavailable.');

//   /*jwt.sign(req.user, constants.JWT_SECRET_KEY, (err, token) => {
//     if(err) {
//       return res.status(500).send('An error occured while generating session token.');
//     }
//     return res.status(200).json({
//       user: req.user,
//       token
//     });
//   });*/
// });

  module.exports = router;