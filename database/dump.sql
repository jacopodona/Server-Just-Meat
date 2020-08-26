--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7 (Ubuntu 11.7-0ubuntu0.19.10.1)
-- Dumped by pg_dump version 11.7 (Ubuntu 11.7-0ubuntu0.19.10.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: coupons; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.coupons (
    code character varying(255) NOT NULL,
    percentage numeric NOT NULL
);


ALTER TABLE public.coupons OWNER TO admin;

--
-- Name: credentials; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.credentials (
    fk_user integer NOT NULL,
    hashed_password character varying(255) NOT NULL,
    mail character varying(255) NOT NULL
);


ALTER TABLE public.credentials OWNER TO admin;

--
-- Name: departments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.departments (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.departments OWNER TO admin;

--
-- Name: has_coupon; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_coupon (
    fk_order integer NOT NULL,
    fk_coupon character varying(255) NOT NULL
);


ALTER TABLE public.has_coupon OWNER TO admin;

--
-- Name: has_order; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_order (
    fk_user integer NOT NULL,
    fk_order integer NOT NULL,
    favourite boolean DEFAULT false NOT NULL
);


ALTER TABLE public.has_order OWNER TO admin;

--
-- Name: has_product; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_product (
    fk_supermarket integer NOT NULL,
    fk_product integer NOT NULL,
    fk_department integer NOT NULL
);


ALTER TABLE public.has_product OWNER TO admin;

--
-- Name: has_weight; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_weight (
    fk_product integer NOT NULL,
    fk_weight integer NOT NULL
);


ALTER TABLE public.has_weight OWNER TO admin;

--
-- Name: love_products; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.love_products (
    fk_user integer NOT NULL,
    fk_product integer NOT NULL
);


ALTER TABLE public.love_products OWNER TO admin;

--
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.manufacturers OWNER TO admin;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    pickup_time timestamp without time zone NOT NULL,
    fk_supermarket integer NOT NULL,
    fk_status integer NOT NULL
);


ALTER TABLE public.orders OWNER TO admin;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO admin;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    price numeric NOT NULL,
    barcode character varying(255) NOT NULL,
    discount numeric NOT NULL,
    image character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    fk_manufacturer integer NOT NULL
);


ALTER TABLE public.products OWNER TO admin;

--
-- Name: shopping_cart; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shopping_cart (
    fk_order integer NOT NULL,
    fk_product integer NOT NULL,
    fk_weight integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.shopping_cart OWNER TO admin;

--
-- Name: status; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.status (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.status OWNER TO admin;

--
-- Name: supermarkets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.supermarkets (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);


ALTER TABLE public.supermarkets OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    photo character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: weights; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.weights (
    id integer NOT NULL,
    um character varying(255) NOT NULL,
    value integer NOT NULL
);


ALTER TABLE public.weights OWNER TO admin;

--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.coupons (code, percentage) FROM stdin;
abc	0.2
def	0.4
ghi	0.5
\.


--
-- Data for Name: credentials; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credentials (fk_user, hashed_password, mail) FROM stdin;
1	$2b$08$E/1wZrQ4Z/w9/lWAJ4JoHuSBfTUCaA6Nnfl31FdabK7Qa9ca.lcLK	davide.farina@gmail.com
2	$2b$08$HxiPzp52k91sOB7HZ3yWee4TwvLrRdF1/Km1O3NCiVxexOrB.edkS	michele.rigo@gmail.com
3	$2b$08$08RIDdF2U0OYfTbfUTR2LuJN8Pa3xP01IpkiV454fiOvryChT6VW.	gabriele.pasquali@gmail.com
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: admin
--

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


--
-- Data for Name: has_coupon; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.has_coupon (fk_order, fk_coupon) FROM stdin;
2	abc
\.


--
-- Data for Name: has_order; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.has_order (fk_user, fk_order, favourite) FROM stdin;
1	1	f
1	2	f
\.


--
-- Data for Name: has_product; Type: TABLE DATA; Schema: public; Owner: admin
--

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


--
-- Data for Name: has_weight; Type: TABLE DATA; Schema: public; Owner: admin
--

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


--
-- Data for Name: love_products; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.love_products (fk_user, fk_product) FROM stdin;
\.


--
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.manufacturers (id, name) FROM stdin;
1	Dio
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orders (id, creation_date, pickup_time, fk_supermarket, fk_status) FROM stdin;
1	2020-08-26 14:44:58.961	2020-09-15 15:00:00	4	1
2	2020-08-26 14:56:22.285	2020-11-22 15:00:00	1	1
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products (id, name, price, barcode, discount, image, description, fk_manufacturer) FROM stdin;
1	Tisana bio	5.50	to_implement	0	no_image	description	1
2	Lattuga nostrana bio 0.5kg	2.50	to_implement	0.40	no_image	description	1
3	Peperoni nostrani bio 0.5kg	2.30	to_implement	0.40	no_image	description	1
4	Formaggio casolet 0.4kg	4.25	to_implement	0.40	no_image	description	1
5	Formaggio Trentingrana 1.5kg	9.60	to_implement	0.40	no_image	description	1
6	Speck Alto-Adige 0.2kg	2.20	to_implement	0.40	no_image	description	1
7	Soppressa nostrana 0.2kg	2.65	to_implement	0.40	no_image	description	1
8	Tè alla pesca San Benedetto 1.5l	1.50	to_implement	0.40	no_image	description	1
9	Yogurt Mila	0.25	to_implement	0.40	no_image	description	1
10	Pizza surgelata Buitoni	3.25	to_implement	0	no_image	description	1
11	Ananas	1.99	to_implement	0	no_image	description	1
12	Pere william 1kg	2.99	to_implement	0	no_image	description	1
13	Fragole in vaschetta 0.5kg	1.5	to_implement	0	no_image	description	1
14	Finocchio 1kg	1.8	to_implement	0.30	no_image	description	1
15	Insalata misticanza 0.125kg	1.3	to_implement	0.20	no_image	description	1
16	Insalata arcobaleno 0.5kg	2.29	to_implement	0.40	no_image	description	1
17	Zucchine 1kg	2.39	to_implement	0.50	no_image	description	1
18	Tagliata di bovino adulta 0.5kg	17.50	to_implement	0.30	no_image	description	1
19	Fette sceltissime di vitello 0.5kg	23.9	to_implement	0.20	no_image	description	1
20	Spiedini di pollo x4 0.5kg	11.9	to_implement	0.40	no_image	description	1
21	Lonza di suino 0.5kg	8.8	to_implement	0.40	no_image	description	1
22	Chicken burger 0.2kg	2.98	to_implement	0.40	no_image	description	1
23	Seppia pulita fresca 1kg	20.9	to_implement	0.80	no_image	description	1
24	Spiedino di pesce 1kg	17.9	to_implement	0.70	no_image	description	1
25	Trota salmonata	10.9	to_implement	0.60	no_image	description	1
26	Orata fresca 1kg	8.5	to_implement	0.20	no_image	description	1
\.


--
-- Data for Name: shopping_cart; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.shopping_cart (fk_order, fk_product, fk_weight, quantity) FROM stdin;
1	11	1	2
1	25	3	1
2	1	1	2
2	2	3	1
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.status (id, name) FROM stdin;
1	Ricevuto
2	Pronto
3	Ritirato
\.


--
-- Data for Name: supermarkets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.supermarkets (id, name, address, latitude, longitude) FROM stdin;
1	NaturaSi	Via del Brennero, 138, 38121 Trento TN	46.0794688000000008	11.1205184999999993
2	ALDI	Via del Brennero, 111, 38122 Trento TN	46.0860180000000028	11.1152423999999996
3	Tito Speck - Il Maso dello Speck	Via Giuseppe Mazzini, 2, 38122 Trento TN	46.0663178000000002	11.1203757999999997
4	MiniPoli	Via Benedetto Giovanelli, 25, 38122 Trento TN	46.0646391000000008	11.1294193000000003
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, name, last_name, photo) FROM stdin;
1	Davide	Farina	no_image
2	Michele	Rigo	no_image
3	Gabriele	Pasquali	no_image
\.


--
-- Data for Name: weights; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.weights (id, um, value) FROM stdin;
1	ml	1000
2	g	100
3	g	150
4	g	200
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_id_seq', 3, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 4, false);


--
-- Name: coupons coupons_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pk PRIMARY KEY (code);


--
-- Name: credentials credentials_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_pk PRIMARY KEY (fk_user);


--
-- Name: departments departments_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pk PRIMARY KEY (id);


--
-- Name: has_coupon has_coupon_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_coupon
    ADD CONSTRAINT has_coupon_pk PRIMARY KEY (fk_order, fk_coupon);


--
-- Name: has_order has_order_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_order
    ADD CONSTRAINT has_order_pk PRIMARY KEY (fk_user, fk_order);


--
-- Name: has_product has_product_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_product
    ADD CONSTRAINT has_product_pk PRIMARY KEY (fk_supermarket, fk_product);


--
-- Name: has_weight has_weight_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_weight
    ADD CONSTRAINT has_weight_pk PRIMARY KEY (fk_product, fk_weight);


--
-- Name: love_products love_products_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.love_products
    ADD CONSTRAINT love_products_pk PRIMARY KEY (fk_user, fk_product);


--
-- Name: manufacturers manufacturers_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pk PRIMARY KEY (id);


--
-- Name: orders orders_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pk PRIMARY KEY (id);


--
-- Name: products products_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pk PRIMARY KEY (id);


--
-- Name: shopping_cart shopping_cart_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pk PRIMARY KEY (fk_order, fk_product);


--
-- Name: status status_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pk PRIMARY KEY (id);


--
-- Name: supermarkets supermarkets_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.supermarkets
    ADD CONSTRAINT supermarkets_pk PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: weights weights_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.weights
    ADD CONSTRAINT weights_pk PRIMARY KEY (id);


--
-- Name: credentials credentials_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_fk0 FOREIGN KEY (fk_user) REFERENCES public.users(id);


--
-- Name: has_coupon has_coupon_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_coupon
    ADD CONSTRAINT has_coupon_fk0 FOREIGN KEY (fk_order) REFERENCES public.orders(id);


--
-- Name: has_coupon has_coupon_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_coupon
    ADD CONSTRAINT has_coupon_fk1 FOREIGN KEY (fk_coupon) REFERENCES public.coupons(code);


--
-- Name: has_order has_order_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_order
    ADD CONSTRAINT has_order_fk0 FOREIGN KEY (fk_user) REFERENCES public.users(id);


--
-- Name: has_order has_order_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_order
    ADD CONSTRAINT has_order_fk1 FOREIGN KEY (fk_order) REFERENCES public.orders(id);


--
-- Name: has_product has_product_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_product
    ADD CONSTRAINT has_product_fk0 FOREIGN KEY (fk_supermarket) REFERENCES public.supermarkets(id);


--
-- Name: has_product has_product_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_product
    ADD CONSTRAINT has_product_fk1 FOREIGN KEY (fk_product) REFERENCES public.products(id);


--
-- Name: has_product has_product_fk2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_product
    ADD CONSTRAINT has_product_fk2 FOREIGN KEY (fk_department) REFERENCES public.departments(id);


--
-- Name: has_weight has_weight_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_weight
    ADD CONSTRAINT has_weight_fk0 FOREIGN KEY (fk_product) REFERENCES public.products(id);


--
-- Name: has_weight has_weight_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_weight
    ADD CONSTRAINT has_weight_fk1 FOREIGN KEY (fk_weight) REFERENCES public.weights(id);


--
-- Name: love_products love_products_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.love_products
    ADD CONSTRAINT love_products_fk0 FOREIGN KEY (fk_user) REFERENCES public.users(id);


--
-- Name: love_products love_products_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.love_products
    ADD CONSTRAINT love_products_fk1 FOREIGN KEY (fk_product) REFERENCES public.products(id);


--
-- Name: orders orders_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk0 FOREIGN KEY (fk_supermarket) REFERENCES public.supermarkets(id);


--
-- Name: orders orders_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk1 FOREIGN KEY (fk_status) REFERENCES public.status(id);


--
-- Name: products products_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_fk0 FOREIGN KEY (fk_manufacturer) REFERENCES public.manufacturers(id);


--
-- Name: shopping_cart shopping_cart_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_fk0 FOREIGN KEY (fk_order) REFERENCES public.orders(id);


--
-- Name: shopping_cart shopping_cart_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_fk1 FOREIGN KEY (fk_product) REFERENCES public.products(id);


--
-- Name: shopping_cart shopping_cart_fk2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_fk2 FOREIGN KEY (fk_weight) REFERENCES public.weights(id);


--
-- PostgreSQL database dump complete
--

