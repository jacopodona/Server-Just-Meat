const insert_user = (name, last_name, address, birth_date) => {
  return {
    text: 'INSERT INTO users(name, last_name, address, birth_date) VALUES($1, $2, $3, $4) RETURNING id',
    values: [name, last_name, address, birth_date]
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

const get_products = (id) => {
  return {
    text: 'SELECT P.id AS id, P.name AS name, price, barcode, available, category, department, discount, image FROM products P JOIN has_product H ON P.id = H.fk_product JOIN supermarkets S ON H.fk_supermarket = S.id WHERE S.id = $1',
    values: [id]
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
  get_products
}

exports.queries = queries;