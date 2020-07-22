CREATE TABLE "users" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"last_name" VARCHAR(255) NOT NULL,
	"photo" VARCHAR(255) NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "credentials" (
	"fk_user" integer NOT NULL,
	"hashed_password" VARCHAR(255) NOT NULL,
	"mail" VARCHAR(255) NOT NULL,
	CONSTRAINT "credentials_pk" PRIMARY KEY ("fk_user")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "orders" (
	"id" serial NOT NULL,
	"creation_date" TIMESTAMP NOT NULL,
	"pickup_time" TIMESTAMP NOT NULL,
	"amount" integer NOT NULL,
	"discount" DECIMAL NOT NULL,
	"fk_supermarket" integer NOT NULL,
	"fk_status" integer NOT NULL,
	"fk_coupon" integer,
	CONSTRAINT "orders_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "has_order" (
	"fk_user" integer NOT NULL,
	"fk_order" integer NOT NULL,
	CONSTRAINT "has_order_pk" PRIMARY KEY ("fk_user","fk_order")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "status" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	CONSTRAINT "status_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "supermarkets" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"address" VARCHAR(255) NOT NULL,
	CONSTRAINT "supermarkets_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "has_product" (
	"fk_supermarket" integer NOT NULL,
	"fk_product" integer NOT NULL,
	"fk_department" integer NOT NULL,
	CONSTRAINT "has_product_pk" PRIMARY KEY ("fk_supermarket","fk_product")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "departments" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	CONSTRAINT "departments_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "products" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"price" DECIMAL NOT NULL,
	"barcode" VARCHAR(255) NOT NULL,
	"discount" DECIMAL NOT NULL,
	"image" VARCHAR(255) NOT NULL,
	"description" VARCHAR(255) NOT NULL,
	"fk_manufacturer" integer NOT NULL,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "manufacturers" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	CONSTRAINT "manufacturers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "shopping_cart" (
	"fk_order" integer NOT NULL,
	"fk_product" integer NOT NULL,
	"fk_weight" integer NOT NULL,
	"quantity" integer NOT NULL,
	CONSTRAINT "shopping_cart_pk" PRIMARY KEY ("fk_order","fk_product")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "love_products" (
	"fk_user" integer NOT NULL,
	"fk_product" integer NOT NULL,
	CONSTRAINT "love_products_pk" PRIMARY KEY ("fk_user","fk_product")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "coupons" (
	"id" integer NOT NULL,
	"code" VARCHAR(255) NOT NULL,
	"percentage" DECIMAL NOT NULL,
	"used" boolean NOT NULL,
	CONSTRAINT "coupons_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "weights" (
	"id" integer NOT NULL,
	"um" VARCHAR(255) NOT NULL,
	"value" integer NOT NULL,
	CONSTRAINT "weights_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "has_weight" (
	"fk_product" integer NOT NULL,
	"fk_weight" integer NOT NULL,
	CONSTRAINT "has_weight_pk" PRIMARY KEY ("fk_product", "fk_weight")
) WITH (
  OIDS=FALSE
);


ALTER TABLE "credentials" ADD CONSTRAINT "credentials_fk0" FOREIGN KEY ("fk_user") REFERENCES "users"("id");

ALTER TABLE "orders" ADD CONSTRAINT "orders_fk0" FOREIGN KEY ("fk_supermarket") REFERENCES "supermarkets"("id");
ALTER TABLE "orders" ADD CONSTRAINT "orders_fk1" FOREIGN KEY ("fk_status") REFERENCES "status"("id");
ALTER TABLE "orders" ADD CONSTRAINT "orders_fk2" FOREIGN KEY ("fk_coupon") REFERENCES "coupons"("id");

ALTER TABLE "has_order" ADD CONSTRAINT "has_order_fk0" FOREIGN KEY ("fk_user") REFERENCES "users"("id");
ALTER TABLE "has_order" ADD CONSTRAINT "has_order_fk1" FOREIGN KEY ("fk_order") REFERENCES "orders"("id");


ALTER TABLE "has_product" ADD CONSTRAINT "has_product_fk0" FOREIGN KEY ("fk_supermarket") REFERENCES "supermarkets"("id");
ALTER TABLE "has_product" ADD CONSTRAINT "has_product_fk1" FOREIGN KEY ("fk_product") REFERENCES "products"("id");
ALTER TABLE "has_product" ADD CONSTRAINT "has_product_fk2" FOREIGN KEY ("fk_department") REFERENCES "departments"("id");


ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("fk_manufacturer") REFERENCES "manufacturers"("id");


ALTER TABLE "shopping_cart" ADD CONSTRAINT "shopping_cart_fk0" FOREIGN KEY ("fk_order") REFERENCES "orders"("id");
ALTER TABLE "shopping_cart" ADD CONSTRAINT "shopping_cart_fk1" FOREIGN KEY ("fk_product") REFERENCES "products"("id");
ALTER TABLE "shopping_cart" ADD CONSTRAINT "shopping_cart_fk2" FOREIGN KEY ("fk_weight") REFERENCES "weights"("id");


ALTER TABLE "love_products" ADD CONSTRAINT "love_products_fk0" FOREIGN KEY ("fk_user") REFERENCES "users"("id");
ALTER TABLE "love_products" ADD CONSTRAINT "love_products_fk1" FOREIGN KEY ("fk_product") REFERENCES "products"("id");


ALTER TABLE "has_weight" ADD CONSTRAINT "has_weight_fk0" FOREIGN KEY ("fk_product") REFERENCES "products"("id");
ALTER TABLE "has_weight" ADD CONSTRAINT "has_weight_fk1" FOREIGN KEY ("fk_weight") REFERENCES "weights"("id");


COPY public.users (id, name, last_name, address, birth_date, photo) FROM stdin;
1	Davide	Farina	Via Fratelli Perini, 159, 38122 Trento TN	1998-11-27	no_image
2	Michele	Rigo	Piazza Lodron, 31, 38122 Trento TN	1999-01-12	no_image
3	Gabriele	Pasquali	Via alla Pelegrina, 3, 38121, Trento TN	2000-08-30	no_image
\.



COPY public.manufacturers (id, name) FROM stdin;
1	Dio
\.



COPY public.credentials (fk_user, hashed_password, mail) FROM stdin;
1	$2b$08$E/1wZrQ4Z/w9/lWAJ4JoHuSBfTUCaA6Nnfl31FdabK7Qa9ca.lcLK	davide.farina@gmail.com
2	$2b$08$HxiPzp52k91sOB7HZ3yWee4TwvLrRdF1/Km1O3NCiVxexOrB.edkS	michele.rigo@gmail.com
3	$2b$08$08RIDdF2U0OYfTbfUTR2LuJN8Pa3xP01IpkiV454fiOvryChT6VW.	gabriele.pasquali@gmail.com
\.



COPY public.departments (id, name) FROM stdin;
1	Carne
2	Pesce
3	Formaggi
4	Uova
5	Condimenti
6	Creme spalmabili
7	Dolcificanti e affini
8	Frutta
9	Gelateria
10	Gelatine
11	Fritture
12	Funghi commestibili
13	Legumi e derivati
14	Molluschi e derivati
15	Noci e semi oleaginosi
16	Ortaggi
17	Pasta
18	Pasticceria
19	Prodotti da forno
20	Salse
21	Snack
\.



COPY public.products (id, name, price, barcode, discount, image, description, fk_manufacturer) FROM stdin;
1	Tisana bio	5.50	to_implement	0	no_image	description	1
2	Lattuga nostrana bio 0.5kg	2.50	to_implement	0	no_image	description	1
3	Peperoni nostrani bio 0.5kg	2.30	to_implement	0	no_image	description	1
4	Formaggio casolet 0.4kg	4.25	to_implement	0	no_image	description	1
5	Formaggio Trentingrana 1.5kg	9.60	to_implement	0	no_image	description	1
6	Speck Alto-Adige 0.2kg	2.20	to_implement	0	no_image	description	1
7	Soppressa nostrana 0.2kg	2.65	to_implement	0	no_image	description	1
8	Tè alla pesca San Benedetto 1.5l	1.50	to_implement	0	no_image	description	1
9	Yogurt Mila	0.25	to_implement	0	no_image	description	1
10	Pizza surgelata Buitoni	3.25	to_implement	0	no_image	description	1
11	Ananas	1.99	to_implement	0	no_image	description	1
12	Pere william 1kg	2.99	to_implement	0.25	no_image	description	1
13	Fragole in vaschetta 0.5kg	1.5	to_implement	0.25	no_image	description	1
14	Finocchio 1kg	1.8	to_implement	0.1	no_image	description	1
15	Insalata misticanza 0.125kg	1.3	to_implement	0.3	no_image	description	1
16	Insalata arcobaleno 0.5kg	2.29	to_implement	0.4	no_image	description	1
17	Zucchine 1kg	2.39	to_implement	0.4	no_image	description	1
18	Tagliata di bovino adulta 0.5kg	17.50	to_implement	0.3	no_image	description	1
19	Fette sceltissime di vitello 0.5kg	23.9	to_implement	0.25	no_image	description	1
20	Spiedini di pollo x4 0.5kg	11.9	to_implement	0.1	no_image	description	1
21	Lonza di suino 0.5kg	8.8	to_implement	0.5	no_image	description	1
22	Chicken burger 0.2kg	2.98	to_implement	0.3	no_image	description	1
23	Seppia pulita fresca 1kg	20.9	to_implement	0.3	no_image	description	1
24	Spiedino di pesce 1kg	17.9	to_implement	0.2	no_image	description	1
25	Trota salmonata	10.9	to_implement	0.15	no_image	description	1
26	Orata fresca 1kg	8.5	to_implement	0.5	no_image	description	1
\.



COPY public.supermarkets (id, name, address) FROM stdin;
1	NaturaSi	Via del Brennero, 138, 38121 Trento TN
2	ALDI	Via del Brennero, 111, 38122 Trento TN
3	Tito Speck - Il Maso dello Speck	Via Giuseppe Mazzini, 2, 38122 Trento TN
4	MiniPoli	Via Benedetto Giovanelli, 25, 38122 Trento TN
\.



COPY public.has_product (fk_supermarket, fk_product, fk_department) FROM stdin;
1	1	1
1	2	12
1	3	3
3	5	4
3	6	21
3	4	16
3	7	14
2	8	1
2	9	13
2	10	12
4	11	1
4	12	10
4	13	5
4	14	8
4	15	7
4	16	17
4	17	15
4	18	15
4	19	13
4	20	13
4	21	7
4	22	9
4	23	4
4	24	21
4	25	21
4	26	19
\.



COPY public.status (id, name) FROM stdin;
1	Ricevuto
2	Pronto
3	Ritirato
\.


COPY public.weights (id, um, value) FROM stdin;
1	Litri	1
2	Grammi	100
3	Grammi	150
4	Grammi	200
\.

COPY public.has_weight (fk_product, fk_weight) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
11	1
12	1
13	1
14	1
15	1
16	1
17	1
18	1
19	1
20	1
21	1
22	1
23	1
24	1
25	2
25	3
25	4
26	1
\.


