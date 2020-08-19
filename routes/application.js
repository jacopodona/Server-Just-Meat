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
    client.query(queries.add_favourite(auth_data.id, req.body.product_id), (err, result) => {
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
    client.query(queries.del_favourite(auth_data.id, req.body.product_id), (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount } });
    });
  });
});

router.post('/add_order', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.add_order(new Date(), req.body.pickup_time, req.body.supermarket_id), (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      const order_id = result.rows[0].id;
      client.query(queries.add_has_order(auth_data.id, order_id, req.body.is_favourite), (err, result) => {
        if (err) {
          return res.status(500).json({ "Error message": "Internal server error:"+err });
        }
        const products = req.body.shopping_cart;
        const coupons = req.body.coupons;
        let i = 0;
        for(i = 0; i < products.length; i++) {
          client.query(queries.add_to_shopping_cart(order_id, products[i].fk_product, products[i].fk_weight, products[i].quantity), (err, result) => {
            if(err) {
              i = products.length + 1;
            }
          })
        }
        if(i === products.length + 1) {
          return res.status(500).json({ "Error message": "Internal server error:"+err });
        }

        if(coupons) {
          i = 0;
          for(i = 0; i < coupons.length; i++) {
            client.query(queries.add_coupon(order_id, coupons[i]), (err, result) => {
              if(err) {
                i = coupons.length + 1;
              }
            })
          }
          if(i === coupons.length + 1) {
            return res.status(500).json({ "Error message": "Internal server error:"+err });
          }
        }
        return res.status(200).json({ "results": result.rows });
      });
    });
  });
});

router.get('/get_order/:id_order', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_order_by_id(order_id, (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount } });
    }));
  });
});

router.get('/get_user_orders', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }
    
    client.query(queries.get_user_orders(auth_data.id, (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount } });
    }));
  });
});

router.get('/get_orders', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_all_orders((err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount } });
    }));
  });
});

router.get('/get_favourite_orders', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_favourite_orders(auth_data.id), (err, result) => {
      if (err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      return res.status(200).json({ "results": result.rows, metadata: { returned: result.rowCount } });
    });
  });
});

router.get('/get_coupon/:code', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_coupon(req.params.code), (err, result) => {
      if(err) {
        return res.status(500).json({ "Error message": "Internal server error:"+err });
      }
      if(result.length == 0 || result.rows[0].fk_order != null) return res.status(200).json({ code: 500, discount: -1.0 });
      return res.status(200).json({ code: 200, percentage: result.rows[0].percentage });
    });
  });
});

module.exports = router;