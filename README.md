# Server-Just-Meat

## API documentation

Link Heroku: `http://just-feet.herokuapp.com`

#### Data 
- **GET** `/api/v1/get_supermarkets`: get all supermarkets;
- **GET** `/api/v1/get_products/:s_id`: get products by id;
- **GET** `/api/v1/get_departments/:s_id`: get all departments of a supermarket;
- **GET** `/api/v1/get_weights/:p_id`: get all weights for a product;
- **POST** `/api/v1/add_favourite`: inserts a favourite item:
```
{
  product_id: -1
}
```
- **POST** `/api/v1/del_favourite`: removes a favourite item;
```
{
  product_id: -1
}
```
- **POST** `/api/v1/add_order`: adds an order;
```
{
  pickup_time: "",
  supermarket_id: -1,
  shopping_cart: [
    {
      fk_product: -1,
      fk_weight: -1,
      quantity: -1
    },
    {
      ...
    }
  ],
  coupons: [
    "",
    "",
    ...
  ]
}
```
- **GET** `/api/v1/get_coupon/:code`: returns id and discount for a coupon, if not already used;

#### Authentication
- **POST** `/auth/signup`: for local signup, expects a JSON body;

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

- **POST** `/auth/login/local`: for local login, expects a JSON body;
```
{
  mail: "",
  psw: ""
}
```
- **POST** `/auth/login/google`: to implement;
- **POST** `/auth/login/facebook`: to implement;

## Uso su Android Studio

È possibile effettuare le chiamate http con la libreria `com.example.justmeat.utilities.HttpJsonRequest`.

La classe offre quattro costruttori, i quali si differenziano per la presenza/assenza di due parametri: la stringa `token`, che viene fornita al momento dell'autenticazione ed è necessaria per accedere alle API che forniscono i dati, e il JSONObject `body`, che contiene eventuali informazioni (es: i dati del form del login).

I quattro costruttori hanno i seguenti parametri:
- `Context context`: contesto;
- `String partialUrl`: l'API da richiamare, ad esempio "/api/v1/get_supermarkets";
- `int method`: metodo HTTP da richiamare, ad esempio "Request.Method.POST";
- `JSONObject body`: JSONObject contenente il body della richiesta Http **[OPZIONALE]**;
- `String token`: token dato dall'autenticazione **[OPZIONALE]**;
- `Response.Listener<JSONObject> onResponse`: callback chiamata al momento della risposta del server;
- `Response.ErrorListener onError`: callback chiamata in caso d'errore.

Un esempio di chiamata può essere il seguente:

```Java
    try {
        JSONObject body = new JSONObject();
        body.put("test", "Hello");
        new HttpJsonRequest(this, "/test", Request.Method.POST, body,
            new Response.Listener<JSONObject>() {
                @Override
                public void onResponse(JSONObject response) {
                    // Do something within context
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    // An error occurred
                }
            }
        ).run();
    } catch(JSONException ex) {
       return;
    }
```