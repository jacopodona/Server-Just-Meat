const insert_user = (name, last_name) => {
  return {
    text: 'INSERT INTO users(name, last_name, photo) VALUES($1, $2, \'no_image\') RETURNING id',
    values: [name, last_name]
  }
}

const insert_credentials = (fk_user, hash, mail) => {
  return {
    text: 'INSERT INTO credentials(fk_user, hashed_password, mail) VALUES($1, $2, $3)',
    values: [fk_user, hash, mail]
  }
}

const delete_user = (id) => {
  return {
    text: 'DELETE FROM users WHERE id = $1',
    values: [id]
  }
}

const exists_user = (mail) => {
  return {
    text: 'SELECT COUNT(*) FROM credentials WHERE mail = $1',
    values: [mail]
  }
}

const get_user_id = (mail) => {
  return {
    text: 'SELECT fk_user AS id FROM credentials WHERE mail = $1',
    values: [mail]
  }
}

const get_password_from_mail = (mail) => {
  return {
    text: 'SELECT fk_user, hashed_password FROM credentials WHERE mail = $1',
    values: [mail]
  }
}

const get_user = (id) => {
  return {
    text: 'SELECT U.name AS name, U.last_name AS last_name, U.photo AS photo, C.mail AS mail FROM users U JOIN credentials C ON U.id=C.fk_user WHERE U.id = $1',
    values: [id]
  }
}

const get_supermarkets = (offset, limit) => {
  return {
    text: 'SELECT * FROM supermarkets limit $1 offset $2;',
    values: [limit, offset]
  }

}

const get_products = (id_supermercato, limit, offset) => {
  return {
    text: 'SELECT P.id AS id, P.name AS name, price, barcode, discount, image, description, D.id AS department, M.name AS manufacturer, W.um AS um, MIN(W.value) AS weight, W.id AS fk_weight, LP.fk_user FROM products P JOIN has_product H ON P.id = H.fk_product JOIN supermarkets S ON H.fk_supermarket = S.id JOIN departments D ON D.id = H.fk_department JOIN manufacturers M ON M.id = P.fk_manufacturer JOIN has_weight HW ON HW.fk_product=P.id JOIN weights W ON HW.fk_weight=W.id LEFT JOIN love_products LP ON LP.fk_product = P.id WHERE S.id = 4 GROUP BY P.id, P.name, price, barcode, discount, image, description, D.id, M.name, W.um, W.id, LP.fk_user limit $2 offset $3',
    values: [id_supermercato, limit, offset]
  }
}

const get_weights = (id_prodotto, limit, offset) => {
  return {
    text: 'SELECT W.id AS id, W.value AS value, W.um AS um FROM weights W JOIN has_weight H ON H.fk_weight=W.id JOIN products P ON P.id=H.fk_product WHERE P.id=$1 limit $2 offset $3',
    values: [id_prodotto, limit, offset]
  }
}

const add_favourite = (id_utente, id_prodotto) => {
  return {
    text: 'INSERT INTO love_products(fk_user, fk_product) VALUES($1, $2)',
    values: [id_utente, id_prodotto]
  }
}

const del_favourite = (id_utente, id_prodotto) => {
  return {
    text: 'DELETE FROM love_products WHERE fk_user=$1 AND fk_product=$2',
    values: [id_utente, id_prodotto]
  }
}

const add_order = (creation_date, pickup_time, id_supermercato) => {
  return {
    text: 'INSERT INTO orders(creation_date, pickup_time, fk_supermarket, fk_status) VALUES($1, $2, $3, 1) RETURNING id',
    values: [creation_date, pickup_time, id_supermercato]
  }
}

const update_order = (order_id, status) => {
  return {
    text: 'UPDATE orders SET fk_status = $2 WHERE id = $1',
    values: [order_id, status]
  }
}

const add_has_order = (id_utente, id_ordine) => {
  return {
    text: 'INSERT INTO has_order(fk_user, fk_order) VALUES($1, $2)',
    values: [id_utente, id_ordine]
  }
}

const add_to_shopping_cart = (id_ordine, id_prodotto, id_peso, quantita) => {
  return {
    text: 'INSERT INTO shopping_cart(fk_order, fk_product, fk_weight, quantity) VALUES($1, $2, $3, $4)',
    values: [id_ordine, id_prodotto, id_peso, quantita]
  }
}

const get_coupon = (codice) => {
  return {
    text: 'SELECT * FROM coupons C LEFT JOIN has_coupon H ON C.code = H.fk_coupon WHERE C.code = $1',
    values: [codice]
  }
}

const add_coupon = (id_ordine, code_coupon) => {
  return {
    text: 'INSERT INTO has_coupon(fk_order, fk_coupon) VALUES($1, $2)',
    values: [id_ordine, code_coupon]
  }
}

const get_departments = (id_supermercato, limit, offset) => {
  return {
    text: 'SELECT DISTINCT D.name AS name, D.id AS id FROM departments D JOIN has_product H ON D.id = H.fk_department WHERE H.fk_supermarket = $1 limit $2 offset $3',
    values: [id_supermercato, limit, offset]
  }
}

const queries = {
  insert_user,
  insert_credentials,
  delete_user,
  exists_user,
  get_user_id,
  get_password_from_mail,
  get_user,
  get_supermarkets,
  get_products,
  get_departments,
  get_weights,
  add_favourite,
  del_favourite,
  add_order,
  add_has_order,
  add_to_shopping_cart,
  get_coupon,
  add_coupon,
  update_order
}

exports.queries = queries;