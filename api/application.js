const router = require('express').Router();
const jwt = require('jsonwebtoken');

// Custom modules
const constants = require('../config/constants');
const client = require('../config/postgres-config');
const { queries } = require('../modules/queries');
const { verifyToken } = require('../modules/utilities');

router.get('/get_supermarkets', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      // Commented line for debug only
      // return res.status(403).send('Forbidden');
    }

    // get needed data
    client.query(queries.get_supermarkets(), (err, result) => {
      if (err) {
        return res.status(500).send('Internal server error.');
      }
      return res.status(200).json(result.rows);
    });
  });
});

router.get('/get_products/:s_id', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      // Commented line for debug only
      // return res.status(403).send('Forbidden');
    }

    // get needed data
    client.query(queries.get_products(req.params.s_id), (err, result) => {
      if (err) {
        return res.status(500).send('Internal server error.');
      }
      return res.status(200).json(result.rows);
    });
  });
});

module.exports = router;