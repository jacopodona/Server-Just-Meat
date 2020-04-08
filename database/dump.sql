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
-- Name: credentials; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.credentials (
    fk_user integer NOT NULL,
    hashed_password character varying(60) NOT NULL,
    mail character varying(100) NOT NULL
);


ALTER TABLE public.credentials OWNER TO admin;

--
-- Name: has_product; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.has_product (
    fk_supermarket integer NOT NULL,
    fk_product integer NOT NULL,
    department character varying(50)
);


ALTER TABLE public.has_product OWNER TO admin;

--
-- Name: order; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    pickup_time timestamp without time zone NOT NULL,
    amount numeric NOT NULL,
    fk_supermarket integer NOT NULL
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
    available integer NOT NULL,
    category character varying(50) NOT NULL,
    discount numeric DEFAULT 0 NOT NULL,
    image character varying(10)
);


ALTER TABLE public.products OWNER TO admin;

--
-- Name: products_available_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_available_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_available_seq OWNER TO admin;

--
-- Name: products_available_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_available_seq OWNED BY public.products.available;


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
    quantity integer NOT NULL
);


ALTER TABLE public.shopping_cart OWNER TO admin;

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
    birth_date date NOT NULL
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
-- Name: products available; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products ALTER COLUMN available SET DEFAULT nextval('public.products_available_seq'::regclass);


--
-- Name: supermarkets id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.supermarkets ALTER COLUMN id SET DEFAULT nextval('public.supermarkets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: credentials; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credentials (fk_user, hashed_password, mail) FROM stdin;
1	$2b$08$E/1wZrQ4Z/w9/lWAJ4JoHuSBfTUCaA6Nnfl31FdabK7Qa9ca.lcLK	davide.farina@gmail.com
2	$2b$08$HxiPzp52k91sOB7HZ3yWee4TwvLrRdF1/Km1O3NCiVxexOrB.edkS	michele.rigo@gmail.com
3	$2b$08$08RIDdF2U0OYfTbfUTR2LuJN8Pa3xP01IpkiV454fiOvryChT6VW.	gabriele.pasquali@gmail.com
\.


--
-- Data for Name: has_product; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.has_product (fk_supermarket, fk_product, department) FROM stdin;
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
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."order" (id, creation_date, pickup_time, amount, fk_supermarket) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.orders (fk_user, fk_order) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products (id, name, price, barcode, available, category, discount, image) FROM stdin;
1	Tisana bio	5.50	to_implement	100	tisane	0	\N
2	Lattuga nostrana bio 0.5kg	2.50	to_implement	100	verdura	0	\N
3	Peperoni nostrani bio 0.5kg	2.30	to_implement	100	verdura	0	\N
4	Formaggio casolet 0.4kg	4.25	to_implement	100	formaggi	0	\N
5	Formaggio Trentingrana 1.5kg	9.60	to_implement	100	formaggi	0	\N
6	Speck Alto-Adige 0.2kg	2.20	to_implement	100	affettati	0	\N
7	Soppressa nostrana 0.2kg	2.65	to_implement	100	affettati	0	\N
8	Tè alla pesca San Benedetto 1.5l	1.50	to_implement	100	bevande	0	\N
9	Yogurt Mila	0.25	to_implement	100	bevande	0	\N
10	Pizza surgelata Buitoni	3.25	to_implement	100	surgelati	0	\N
11	Ananas	1.99	to_implement	100	frutta	0	\N
12	Pere william 1kg	2.99	to_implement	100	frutta	0.25	\N
13	Fragole in vaschetta 0.5kg	1.5	to_implement	100	frutta	0.25	\N
14	Finocchio 1kg	1.8	to_implement	100	verdura	0.1	\N
15	Insalata misticanza 0.125kg	1.3	to_implement	100	verdura	0.3	\N
16	Insalata arcobaleno 0.5kg	2.29	to_implement	100	verdura	0.4	\N
17	Zucchine 1kg	2.39	to_implement	100	verdura	0.4	\N
18	Tagliata di bovino adulta 0.5kg	17.50	to_implement	100	macelleria	0.3	\N
19	Fette sceltissime di vitello 0.5kg	23.9	to_implement	100	macelleria	0.25	\N
20	Spiedini di pollo x4 0.5kg	11.9	to_implement	100	macelleria	0.1	\N
21	Lonza di suino 0.5kg	8.8	to_implement	100	macelleria	0.5	\N
22	Chicken burger 0.2kg	2.98	to_implement	100	macelleria	0.3	\N
23	Seppia pulita fresca 1kg	20.9	to_implement	100	pescheria	0.3	\N
24	Spiedino di pesce 1kg	17.9	to_implement	100	pescheria	0.2	\N
25	Trota salmonata 1kg	10.9	to_implement	100	pescheria	0.15	\N
26	Orata fresca 1kg	8.5	to_implement	100	pescheria	0.5	\N
\.


--
-- Data for Name: shopping_cart; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.shopping_cart (fk_product, fk_order, quantity) FROM stdin;
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

COPY public.users (id, name, last_name, address, birth_date) FROM stdin;
1	Davide	Farina	Via Fratelli Perini, 159, 38122 Trento TN	1998-11-27
2	Michele	Rigo	Piazza Lodron, 31, 38122 Trento TN	1999-01-12
3	Gabriele	Pasquali	Via alla Pelegrina, 3, 38121, Trento TN	2000-08-30
\.


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: orders_fk_user_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.orders_fk_user_seq', 1, false);


--
-- Name: products_available_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_available_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_id_seq', 26, true);


--
-- Name: supermarkets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.supermarkets_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


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
-- Name: has_product has_product_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.has_product
    ADD CONSTRAINT has_product_pk PRIMARY KEY (fk_supermarket, fk_product);


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

