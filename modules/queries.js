const insert_user = (name, last_name) => {
  return {
    text: 'INSERT INTO users(name, last_name) VALUES($1, $2) RETURNING id',
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

const get_password_from_mail = (mail) => {
  return {
    text: 'SELECT fk_user, hashed_password FROM credentials WHERE mail = $1',
    values: [mail]
  }
}

const get_user = (id) => {
  return {
    text: 'SELECT * FROM users WHERE id = $1',
    values: [id]
  }
}

const get_supermarkets = (offset,limit) => {
  return {
    text: 'SELECT * FROM supermarkets limit $1 offset $2;',
    values:[limit,offset]
  }

}

const get_products = (id_supermercato,limit,offset) => {
  return {
    text: 'SELECT P.id AS id, P.name AS name, price, barcode, discount, image, description, D.id AS department, M.name AS manufatcurer FROM products P JOIN has_product H ON P.id = H.fk_product JOIN supermarkets S ON H.fk_supermarket = S.id JOIN departments D ON D.id = H.fk_department JOIN manufacturers M ON M.id = P.fk_manufacturer WHERE S.id = $1 limit $2 offset $3',
    values: [id_supermercato,limit,offset]
  }
}

const get_departments = (id_supermercato,limit,offset) => {
  return {
    text: 'SELECT DISTINCT D.name AS name, D.id AS id FROM departments D JOIN has_product H ON D.id = H.fk_department WHERE H.fk_supermarket = $1 limit $2 offset $3',
    values: [id_supermercato,limit,offset]
  }
}

const queries = {
  insert_user,
  insert_credentials,
  delete_user,
  exists_user,
  get_password_from_mail,
  get_user,
  get_supermarkets,
  get_products,
  get_departments
}

exports.queries = queries;