const router = require('express').Router();
const jwt = require('jsonwebtoken');

// Custom modules
const constants = require('../config/constants');
const client = require('../config/postgres-config');
const {
  queries
} = require('../modules/queries');
const {
  verifyToken,
  haversine_distance
} = require('../modules/utilities');

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
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount,
          offset: parseInt(offset, 10),
          limit: parseInt(limit, 10)
        }
      });
    });
  });
});

router.post('/get_supermarkets_in_range', verifyToken, (req, res) => {
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

      var data = result.rows.filter((supermarket) =>
        haversine_distance(req.body.latitude, supermarket.latitude, req.body.longitude, supermarket.longitude) < req.body.range);

      return res.status(200).json({
        "results": data,
        metadata: {
          returned: data.length,
          offset: parseInt(offset, 10),
          limit: parseInt(limit, 10)
        }
      });
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
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount,
          offset: parseInt(offset, 10),
          limit: parseInt(limit, 10)
        }
      });
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
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount,
          offset: parseInt(offset, 10),
          limit: parseInt(limit, 10)
        }
      });
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
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount,
          offset: parseInt(offset, 10),
          limit: parseInt(limit, 10)
        }
      });
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
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount
        }
      });
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
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount
        }
      });
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
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      const order_id = result.rows[0].id;
      client.query(queries.add_has_order(auth_data.id, order_id, req.body.is_favourite), (err, result) => {
        if (err) {
          return res.status(500).json({
            "Error message": "Internal server error:" + err
          });
        }
        const products = req.body.shopping_cart;
        const coupons = req.body.coupons;
        let i = 0;
        for (i = 0; i < products.length; i++) {
          client.query(queries.add_to_shopping_cart(order_id, products[i].fk_product, products[i].fk_weight, products[i].quantity), (err, result) => {
            if (err) {
              i = products.length + 1;
            }
          })
        }
        if (i === products.length + 1) {
          return res.status(500).json({
            "Error message": "Internal server error:" + err
          });
        }

        if (coupons) {
          i = 0;
          for (i = 0; i < coupons.length; i++) {
            client.query(queries.add_coupon(order_id, coupons[i]), (err, result) => {
              if (err) {
                i = coupons.length + 1;
              }
            })
          }
          if (i === coupons.length + 1) {
            return res.status(500).json({
              "Error message": "Internal server error:" + err
            });
          }
        }
        return res.status(200).json({
          "results": result.rows
        });
      });
    });
  });
});

router.get('/get_orders', verifyToken, (req, res) => {
  if (req.token === "justmeat") {
    client.query(queries.get_all_orders(), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount
        }
      });
    });
  } else {
    return res.status(403).send('Forbidden');
  }
});

router.get('/get_order/:id_order', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err && req.token !== "justmeat") {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_order_by_id(req.params.id_order), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }

      if (result.rowCount > 0) {
        client.query(queries.get_coupon_for_order(req.params.id_order), (err, result_2) => {
          if (err) {
            return res.status(500).json({
              "Error message": "Internal server error:" + err
            });
          }

          let data = {
            creation_date: result.rows[0].creation_date,
            pickup_time: result.rows[0].pickup_time,
            supermarket: result.rows[0].name,
            status: result.rows[0].status,
            products: result.rows.map(item => {
              return {
                product_name: item.product_name,
                price: item.price
              }
            }),
            coupons_discounts: result_2.rows.map(item => item.percentage)
          }

          return res.status(200).json({
            "results": data,
            metadata: {
              returned: result.rowCount
            }
          });
        });
      } else {
        return res.status(200).json({
          "results": {},
          metadata: {
            returned: result.rowCount
          }
        });
      }
    });
  });
});

router.get('/get_user_orders', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_user_orders(auth_data.id), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount
        }
      });
    });
  });
});

router.post('/set_order_status', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err && req.token !== "justmeat") {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.update_order(req.body.order_id, req.body.status), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": { },
        metadata: {
          returned: result.rowCount
        }
      });
    });
  });
});

router.get('/get_favourite_orders', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    var data = []
    client.query(queries.get_favourite_orders(auth_data.id), async (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      for(let i = 0; i < result.rowCount; i++) {
        let products = await client.query(queries.get_ordered_products(result.rows[i].order_id));
        data.push({
          order_id: result.rows[i].order_id,
          supermarket_id: result.rows[i].supermarket_id,
          supermarket_name: result.rows[i].supermarket_name,
          favourite: result.rows[i].favourite,
          products: products.rows
        });
      }

      return res.status(200).json({
        "results": data,
        metadata: {
          returned: result.rowCount
        }
      });
    });
  });
});

router.post('/add_favourite_address', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }
    
    client.query(queries.add_address(req.body.name, req.body.address, req.body.latitude, req.body.longitude), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      const address_id = result.rows[0].id;
      
      client.query(queries.add_has_address(auth_data.id, address_id), (err, result) => {
        if (err) {
          return res.status(500).json({
            "Error message": "Internal server error:" + err
          });
        }

        return res.status(200).json({
          results: {
            message: "OK."
          },
          metadata: {
            returned: result.rowCount
          }
        });
      })
    });
  });
});

router.get('/get_favourite_addresses', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }
    
    client.query(queries.get_favourite_addresses(auth_data.id), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
        
      }

      return res.status(200).json({
        results: result.rows,
        metadata: {
          returned: result.rowCount
        }
      });
    })
  });
});

router.post('/del_favourite_address', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }
    
    client.query(queries.del_has_address(req.body.address_id), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }

      client.query(queries.del_favourite_address(req.body.address_id), (err, result) => {
        if (err) {
          return res.status(500).json({
            "Error message": "Internal server error:" + err
          });
        }
        
        return res.status(200).json({
          results: {
            message: "OK."
          },
          metadata: {
            returned: result.rowCount
          }
        });
      });
    });
  });
});

router.get('/get_coupon/:code', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_coupon(req.params.code), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      if (result.rowCount === 0 || result.rows[0].order != null) return res.status(200).json({
        code: 500,
        discount: -1.0
      });
      return res.status(200).json({
        code: 200,
        percentage: result.rows[0].percentage
      });
    });
  });
});

router.get('/get_user_fidcards', verifyToken, (req, res) => {
  jwt.verify(req.token, constants.JWT_SECRET_KEY, (err, auth_data) => {
    if (err) {
      return res.status(403).send('Forbidden');
    }

    client.query(queries.get_user_fidcards(auth_data.id), (err, result) => {
      if (err) {
        return res.status(500).json({
          "Error message": "Internal server error:" + err
        });
      }
      return res.status(200).json({
        "results": result.rows,
        metadata: {
          returned: result.rowCount
        }
      });
    });
  });
});

module.exports = router;