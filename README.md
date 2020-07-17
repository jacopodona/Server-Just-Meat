# Server-Just-Meat

## API documentation

Link Heroku: `http://just-feet.herokuapp.com`

#### Data 
- **GET** `/api/v1/get_supermarkets`: get all supermarkets;
- **GET** `/api/v1/get_products/:s_id`: get products by id;
- **GET** `/api/v1/get_departments/:s_id`: get all departments of a supermarket;

#### Authentication
- **POST** `/auth/signup`: for local signup, expects a JSON body:

```
{
  name: "",
  last_name: "",
  address: "",
  birth_date: "",
  mail: "",
  password: "",
  check_psw: ""
}
```

- **POST** `/auth/login/local`: for local login, expects a JSON body:
```
{
  mail: "",
  psw: ""
}
```
- **POST** `/auth/login/google`: to implement
- **POST** `/auth/login/facebook`: to implement