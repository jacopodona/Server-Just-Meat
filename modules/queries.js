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
    text: 'SELECT P.id AS id, P.name AS name, price, barcode, discount, image, description, D.id AS department, M.name AS manufacturer, W.um AS um, W.value AS weight, W.id AS fk_weight, LP.fk_user AS favourite FROM products P JOIN has_product H ON P.id = H.fk_product JOIN supermarkets S ON H.fk_supermarket = S.id JOIN departments D ON D.id = H.fk_department JOIN manufacturers M ON M.id = P.fk_manufacturer JOIN has_weight HW ON HW.fk_product=P.id JOIN weights W ON HW.fk_weight=W.id LEFT JOIN love_products LP ON LP.fk_product = P.id WHERE S.id = $1 AND W.value = (SELECT MIN(W1.value) FROM weights W1 JOIN has_weight HW1 ON W1.id=HW1.fk_weight JOIN products P1 ON P1.id=HW1.fk_product WHERE P1.id=P.id) ORDER BY id LIMIT $2 OFFSET $3',
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

const add_has_order = (id_utente, id_ordine, favourite) => {
  return {
    text: 'INSERT INTO has_order(fk_user, fk_order, favourite) VALUES($1, $2, $3)',
    values: [id_utente, id_ordine, favourite]
  }
}

const get_order_by_id = (id_ordine) => {
  return {
    text: 'SELECT O.creation_date, O.pickup_time, S.name, ST.name AS status, P.name AS product_name, P.price FROM orders O JOIN supermarkets S ON S.id=O.fk_supermarket JOIN status ST ON O.fk_status=ST.id JOIN shopping_cart SC ON SC.fk_order=O.id JOIN products P ON P.id=SC.fk_product WHERE O.id=$1',
    values: [id_ordine]
  }
}

const get_coupon_for_order = (id_ordine) => {
  return {
    text: 'SELECT C.percentage FROM coupons C JOIN has_coupon H ON H.fk_coupon=C.code WHERE H.fk_order=$1',
    values: [id_ordine]
  }
}

const get_user_orders = (id_utente) => {
  return {
    text: 'SELECT O.id AS order_id, S.name AS supermarket, S.address AS supermarket_address, O.pickup_time AS pickup_time, ST.name AS status FROM orders O JOIN has_order HO ON O.id=HO.fk_order JOIN supermarkets S ON S.id=O.fk_supermarket JOIN status ST ON ST.id=O.fk_status WHERE HO.fk_user=$1',
    values: [id_utente]
  }
}

const get_all_orders = () => {
  return {
    text: 'SELECT O.id, ST.name AS status, ST.id AS status_code FROM orders O JOIN status ST ON O.fk_status=ST.id',
    values: []
  }
}

const get_favourite_orders = (id_utente) => {
  return {
    text: 'SELECT HO.fk_order AS order_id, HO.favourite AS favourite, S.id AS supermarket_id, S.name AS supermarket_name FROM has_order HO JOIN orders O ON O.id=HO.fk_order JOIN supermarkets S ON S.id=O.fk_supermarket WHERE HO.fk_user=$1 AND HO.favourite IS NOT NULL',
    values: [id_utente]
  }
}

const get_ordered_products = (id_ordine) => {
  return {
    text: 'SELECT P.id AS id, P.name AS name, P.price AS price, SC.quantity AS quantity, SC.fk_weight AS weight FROM orders O JOIN shopping_cart SC ON SC.fk_order=O.id JOIN products P ON P.id=SC.fk_product WHERE O.id=$1',
    values: [id_ordine]
  }
}

const add_address = (nome, indirizzo, latitudine, longitudine) => {
  return {
    text: 'INSERT INTO addresses (name, address, latitude, longitude) VALUES ($1, $2, $3, $4) RETURNING id',
    values: [nome, indirizzo, latitudine, longitudine]
  }
}

const add_has_address = (id_utente, id_indirizzo) => {
  return {
    text: 'INSERT INTO has_address (fk_user, fk_address) VALUES ($1, $2)',
    values: [id_utente, id_indirizzo]
  }
}

const get_favourite_addresses = (id_utente) => {
  return {
    text: 'SELECT A.id, A.name, A.address, A.latitude, A.longitude FROM addresses A JOIN has_address HA ON HA.fk_address=A.id WHERE HA.fk_user=$1',
    values: [id_utente]
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
    text: 'SELECT percentage, fk_order AS order FROM coupons C LEFT JOIN has_coupon H ON C.code=H.fk_coupon WHERE C.code=$1',
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
  update_order,
  get_order_by_id,
  get_user_orders,
  get_all_orders,
  get_favourite_orders,
  get_ordered_products,
  get_coupon_for_order,
  add_address,
  add_has_address,
  get_favourite_addresses
}

exports.queries = queries;