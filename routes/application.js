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
      return res.status(403).send('Forbidden');
    }

    let offset, limit;

    if (req.query.offset == undefined) {
      offset = 0;
    } else {
      offset = req.query.offset;
    }
    if (req.query.offset == undefined) {
      limit = null;
    } else {
      limit = req.query.offset;
    }
    // get needed data
    client.query(queries.get_supermarkets(offset, limit), (err, result) => {
      if (err) {
        return res.status(500).send('Internal server error.');
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount, offset: parseInt(offset, 10), limit: parseInt(limit, 10) } });
    });
  });
});

router.get('/get_products/:s_id', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    let offset, limit;

    if (req.query.offset == undefined) {
      offset = 0;
    } else {
      offset = req.query.offset;
    }
    if (req.query.limit == undefined) {
      limit = null;
    } else {
      limit = req.query.limit;
    }

    // get needed data
    client.query(queries.get_products(req.params.s_id, limit, offset), (err, result) => {
      if (err) {
        return res.status(500).send('Internal server error.');
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount, offset: parseInt(offset, 10), limit: parseInt(limit, 10) } });
    });
  });
});

router.get('/get_departments/:s_id', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }
    let offset, limit;

    if (req.query.offset == undefined) {
      offset = 0;
    } else {
      offset = req.query.offset;
    }
    if (req.query.limit == undefined) {
      limit = null;
    } else {
      limit = req.query.limit;
    }

    // get needed data
    client.query(queries.get_departments(req.params.s_id, limit, offset), (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount, offset: parseInt(offset, 10), limit: parseInt(limit, 10) } });
    });
  });
});

router.get('/get_weights/:p_id', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }
    let offset, limit;

    if (req.query.offset == undefined) {
      offset = 0;
    } else {
      offset = req.query.offset;
    }
    if (req.query.limit == undefined) {
      limit = null;
    } else {
      limit = req.query.limit;
    }

    // get needed data
    client.query(queries.get_weights(req.params.p_id, limit, offset), (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount, offset: parseInt(offset, 10), limit: parseInt(limit, 10) } });
    });
  });
});

router.post('/add_favourite', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    // get needed data
    client.query(queries.add_favourite(req.body.uid, req.body.pid), (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount } });
    });
  });
});

router.post('/del_favourite', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    // get needed data
    client.query(queries.del_favourite(req.body.uid, req.body.pid), (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount } });
    });
  });
});

module.exports = router;