--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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

SET default_table_access_method = heap;

--
-- Name: category ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."category " (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."category " OWNER TO postgres;

--
-- Name: category _id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."category " ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."category _id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: credentials; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.credentials (
    fk_user integer NOT NULL,
    hashed_password character varying(60) NOT NULL,
    mail character varying(100) NOT NULL
);


ALTER TABLE public.credentials OWNER TO admin;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    name character varying(60) NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.department ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: has_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.has_department (
    fk_supermarket integer NOT NULL,
    fk_department integer NOT NULL
);


ALTER TABLE public.has_department OWNER TO postgres;

--
-- Name: has_product; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_product (
    fk_supermarket integer NOT NULL,
    fk_product integer NOT NULL,
    available integer
);


ALTER TABLE public.has_product OWNER TO admin;

--
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturer (
    id bigint NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.manufacturer OWNER TO postgres;

--
-- Name: manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manufacturer_id_seq OWNER TO postgres;

--
-- Name: manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturer_id_seq OWNED BY public.manufacturer.id;


--
-- Name: order; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    pickup_time timestamp without time zone NOT NULL,
    amount numeric NOT NULL,
    fk_supermarket integer NOT NULL,
    discount double precision,
    fk_status integer NOT NULL
);


ALTER TABLE public."order" OWNER TO admin;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO admin;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.orders (
    fk_user integer NOT NULL,
    fk_order integer NOT NULL
);


ALTER TABLE public.orders OWNER TO admin;

--
-- Name: orders_fk_user_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.orders_fk_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_fk_user_seq OWNER TO admin;

--
-- Name: orders_fk_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.orders_fk_user_seq OWNED BY public.orders.fk_user;


--
-- Name: products; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    price numeric NOT NULL,
    barcode character varying(75) NOT NULL,
    discount numeric DEFAULT 0 NOT NULL,
    image character varying(10),
    fk_category integer,
    description character varying(250),
    fk_manufacturer integer
);


ALTER TABLE public.products OWNER TO admin;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO admin;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: shopping_cart; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shopping_cart (
    fk_product integer NOT NULL,
    fk_order integer NOT NULL,
    quantity integer NOT NULL,
    weight double precision
);


ALTER TABLE public.shopping_cart OWNER TO admin;

--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id bigint NOT NULL,
    name character varying
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- Name: supermarkets; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.supermarkets (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    address character varying(100) NOT NULL
);


ALTER TABLE public.supermarkets OWNER TO admin;

--
-- Name: supermarkets_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.supermarkets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supermarkets_id_seq OWNER TO admin;

--
-- Name: supermarkets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.supermarkets_id_seq OWNED BY public.supermarkets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    last_name character varying(25) NOT NULL,
    address character varying(100) NOT NULL,
    birth_date date NOT NULL,
    foto character varying
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
-- Name: manufacturer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer ALTER COLUMN id SET DEFAULT nextval('public.manufacturer_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: orders fk_user; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders ALTER COLUMN fk_user SET DEFAULT nextval('public.orders_fk_user_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- Name: supermarkets id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.supermarkets ALTER COLUMN id SET DEFAULT nextval('public.supermarkets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: category ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."category " (id, name) FROM stdin;
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
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, name) FROM stdin;
1	Carne
2	Pesce
3	Formaggi
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
22	Uova
\.


--
-- Data for Name: has_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.has_department (fk_supermarket, fk_department) FROM stdin;
1	1
1	2
1	3
1	5
1	6
1	7
1	8
1	9
1	10
1	11
1	12
1	13
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
2	1
2	3
2	5
2	6
2	7
2	8
2	9
2	10
2	11
2	12
2	13
2	14
2	15
2	16
2	17
2	18
2	19
2	20
2	21
2	22
3	1
3	3
3	5
3	6
3	7
3	8
3	10
3	11
3	12
3	13
3	14
3	15
3	16
3	17
3	18
3	19
3	20
3	21
3	22
4	1
4	3
4	5
4	6
4	7
4	8
4	10
4	13
4	14
4	15
4	16
4	17
4	20
4	21
4	22
\.


--
-- Data for Name: has_product; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.has_product (fk_supermarket, fk_product, available) FROM stdin;
1	1	\N
1	2	\N
1	3	\N
3	5	\N
3	6	\N
3	4	\N
3	7	\N
2	8	\N
2	9	\N
2	10	\N
4	11	\N
4	12	\N
4	13	\N
4	14	\N
4	15	\N
4	16	\N
4	17	\N
4	18	\N
4	19	\N
4	20	\N
4	21	\N
4	22	\N
4	23	\N
4	24	\N
4	25	\N
4	26	\N
\.


--
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturer (id, name) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."order" (id, creation_date, pickup_time, amount, fk_supermarket, discount, fk_status) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orders (fk_user, fk_order) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products (id, name, price, barcode, discount, image, fk_category, description, fk_manufacturer) FROM stdin;
1	Tisana bio	5.50	to_implement	0	\N	\N	\N	\N
2	Lattuga nostrana bio 0.5kg	2.50	to_implement	0	\N	\N	\N	\N
3	Peperoni nostrani bio 0.5kg	2.30	to_implement	0	\N	\N	\N	\N
4	Formaggio casolet 0.4kg	4.25	to_implement	0	\N	\N	\N	\N
5	Formaggio Trentingrana 1.5kg	9.60	to_implement	0	\N	\N	\N	\N
6	Speck Alto-Adige 0.2kg	2.20	to_implement	0	\N	\N	\N	\N
7	Soppressa nostrana 0.2kg	2.65	to_implement	0	\N	\N	\N	\N
8	Tè alla pesca San Benedetto 1.5l	1.50	to_implement	0	\N	\N	\N	\N
9	Yogurt Mila	0.25	to_implement	0	\N	\N	\N	\N
10	Pizza surgelata Buitoni	3.25	to_implement	0	\N	\N	\N	\N
11	Ananas	1.99	to_implement	0	\N	\N	\N	\N
12	Pere william 1kg	2.99	to_implement	0.25	\N	\N	\N	\N
13	Fragole in vaschetta 0.5kg	1.5	to_implement	0.25	\N	\N	\N	\N
14	Finocchio 1kg	1.8	to_implement	0.1	\N	\N	\N	\N
15	Insalata misticanza 0.125kg	1.3	to_implement	0.3	\N	\N	\N	\N
16	Insalata arcobaleno 0.5kg	2.29	to_implement	0.4	\N	\N	\N	\N
17	Zucchine 1kg	2.39	to_implement	0.4	\N	\N	\N	\N
18	Tagliata di bovino adulta 0.5kg	17.50	to_implement	0.3	\N	\N	\N	\N
19	Fette sceltissime di vitello 0.5kg	23.9	to_implement	0.25	\N	\N	\N	\N
20	Spiedini di pollo x4 0.5kg	11.9	to_implement	0.1	\N	\N	\N	\N
21	Lonza di suino 0.5kg	8.8	to_implement	0.5	\N	\N	\N	\N
22	Chicken burger 0.2kg	2.98	to_implement	0.3	\N	\N	\N	\N
23	Seppia pulita fresca 1kg	20.9	to_implement	0.3	\N	\N	\N	\N
24	Spiedino di pesce 1kg	17.9	to_implement	0.2	\N	\N	\N	\N
25	Trota salmonata 1kg	10.9	to_implement	0.15	\N	\N	\N	\N
26	Orata fresca 1kg	8.5	to_implement	0.5	\N	\N	\N	\N
\.


--
-- Data for Name: shopping_cart; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.shopping_cart (fk_product, fk_order, quantity, weight) FROM stdin;
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id, name) FROM stdin;
1	Ricevuto
2	Pronto
3	Ritirato
\.


--
-- Data for Name: supermarkets; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.supermarkets (id, name, address) FROM stdin;
1	NaturaSi	Via del Brennero, 138, 38121 Trento TN
2	ALDI	Via del Brennero, 111, 38122 Trento TN
3	Tito Speck - Il Maso dello Speck	Via Giuseppe Mazzini, 2, 38122 Trento TN
4	MiniPoli	Via Benedetto Giovanelli, 25, 38122 Trento TN
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, name, last_name, address, birth_date, foto) FROM stdin;
1	Davide	Farina	Via Fratelli Perini, 159, 38122 Trento TN	1998-11-27	\N
2	Michele	Rigo	Piazza Lodron, 31, 38122 Trento TN	1999-01-12	\N
3	Gabriele	Pasquali	Via alla Pelegrina, 3, 38121, Trento TN	2000-08-30	\N
\.


--
-- Name: category _id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."category _id_seq"', 1, false);


--
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_seq', 22, true);


--
-- Name: manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturer_id_seq', 1, false);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: orders_fk_user_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_fk_user_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_id_seq', 26, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 3, true);


--
-- Name: supermarkets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.supermarkets_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: category  category _pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."category "
    ADD CONSTRAINT "category _pkey" PRIMARY KEY (id);


--
-- Name: credentials credentials_mail_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_mail_key UNIQUE (mail);


--
-- Name: credentials credentials_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_pk PRIMARY KEY (fk_user);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: department department_unique0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_unique0 UNIQUE (name);


--
-- Name: has_department has_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.has_department
    ADD CONSTRAINT has_department_pkey PRIMARY KEY (fk_supermarket, fk_department);


--
-- Name: has_product has_product_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_product
    ADD CONSTRAINT has_product_pk PRIMARY KEY (fk_supermarket, fk_product);


--
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (id);


--
-- Name: order order_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pk PRIMARY KEY (id);


--
-- Name: orders orders_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pk PRIMARY KEY (fk_user, fk_order);


--
-- Name: products products_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pk PRIMARY KEY (id);


--
-- Name: shopping_cart shopping_cart_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pk PRIMARY KEY (fk_product, fk_order, quantity);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


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
-- Name: credentials credentials_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_fk0 FOREIGN KEY (fk_user) REFERENCES public.users(id);


--
-- Name: has_department has_department_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.has_department
    ADD CONSTRAINT has_department_fk0 FOREIGN KEY (fk_supermarket) REFERENCES public.supermarkets(id);


--
-- Name: has_department has_department_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.has_department
    ADD CONSTRAINT has_department_fk1 FOREIGN KEY (fk_department) REFERENCES public.department(id);


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
-- Name: order order_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_fk0 FOREIGN KEY (fk_supermarket) REFERENCES public.supermarkets(id);


--
-- Name: order order_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_fk1 FOREIGN KEY (fk_status) REFERENCES public.status(id) NOT VALID;


--
-- Name: orders orders_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk0 FOREIGN KEY (fk_user) REFERENCES public.users(id);


--
-- Name: orders orders_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk1 FOREIGN KEY (fk_order) REFERENCES public."order"(id);


--
-- Name: products product_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT product_fk0 FOREIGN KEY (fk_category) REFERENCES public."category "(id);


--
-- Name: products product_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT product_fk1 FOREIGN KEY (fk_manufacturer) REFERENCES public.manufacturer(id);


--
-- Name: shopping_cart shopping_cart_fk0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_fk0 FOREIGN KEY (fk_product) REFERENCES public.products(id);


--
-- Name: shopping_cart shopping_cart_fk1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_fk1 FOREIGN KEY (fk_order) REFERENCES public."order"(id);


--
-- PostgreSQL database dump complete
--

