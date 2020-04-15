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

    let offset,limit;
    
    if (req.query.offset == undefined) {
      offset=0;
    }else{
      offset=req.query.offset;
    }
    if (req.query.offset == undefined) {
      limit=null;
    }else{
      limit = req.query.offset;
    }
    // get needed data
    client.query(queries.get_supermarkets(offset,limit), (err, result) => {
      if (err) {
        return res.status(500).send('Internal server error.');
      }
      return res.status(200).json({"results":result.rows, metadata:{returned:result.rowCount, offset : parseInt(offset,10), limit : parseInt(limit,10)}});
    });



  });
});

router.get('/get_products/:s_id', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      // Commented line for debug only
      // return res.status(403).send('Forbidden');
    }

    let offset,limit;
    
    if (req.query.offset == undefined) {
      offset=0;
    }else{
      offset=req.query.offset;
    }
    if (req.query.offset == undefined) {
      limit=null;
    }else{
      limit = req.query.offset;
    }

    // get needed data
    client.query(queries.get_products(req.params.s_id, limit, offset), (err, result) => {
      if (err) {
        return res.status(500).send('Internal server error.');
      }
      return res.status(200).json(result.rows);
    });
  });
});

module.exports = router;