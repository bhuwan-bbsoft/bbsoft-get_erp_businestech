--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-11 18:58:41

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS resource_dashboard;
--
-- TOC entry 4919 (class 1262 OID 17239)
-- Name: resource_dashboard; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE resource_dashboard WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE resource_dashboard OWNER TO postgres;

\connect resource_dashboard

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17290)
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    address text NOT NULL,
    company_logo character varying(255) DEFAULT ''::character varying,
    city character varying(100) DEFAULT ''::character varying,
    state character varying(100) DEFAULT ''::character varying,
    country character varying(100) DEFAULT ''::character varying,
    mobile character varying(15) DEFAULT ''::character varying,
    pincode character varying(10) DEFAULT ''::character varying,
    gstin character varying(15) DEFAULT ''::character varying,
    email character varying(100) DEFAULT ''::character varying,
    website character varying(100) DEFAULT ''::character varying,
    pan_number character varying(10) DEFAULT ''::character varying,
    financial_year_beginning date DEFAULT CURRENT_DATE,
    books_beginning date DEFAULT CURRENT_DATE,
    currency character varying(10) DEFAULT 'INR'::character varying,
    bank_name character varying(100) DEFAULT ''::character varying,
    account_number character varying(50) DEFAULT ''::character varying,
    ifsc character varying(11) DEFAULT ''::character varying,
    branch character varying(100) DEFAULT ''::character varying,
    swift_code character varying(11) DEFAULT ''::character varying,
    upi_id character varying(100) DEFAULT ''::character varying,
    whatsapp_number character varying(15) DEFAULT ''::character varying,
    instance_id character varying(50) DEFAULT ''::character varying,
    created_by character varying(50) NOT NULL,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(50),
    updated_date timestamp without time zone
);


ALTER TABLE public.company OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17289)
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.company_id_seq OWNER TO postgres;

--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 221
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_id_seq OWNED BY public.company.id;


--
-- TOC entry 231 (class 1259 OID 17600)
-- Name: financial_target; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.financial_target (
    id integer NOT NULL,
    user_id integer NOT NULL,
    financial_year character varying(10) DEFAULT ''::character varying,
    business_target numeric(10,2) DEFAULT 0.00,
    achieved_till_date numeric(10,2) DEFAULT 0.00,
    balance_to_go numeric(10,2) DEFAULT 0.00,
    designation character varying(50) NOT NULL,
    role character varying(50) NOT NULL,
    sales_manager character varying(50)
);


ALTER TABLE public.financial_target OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17599)
-- Name: financial_target_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.financial_target_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.financial_target_id_seq OWNER TO postgres;

--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 230
-- Name: financial_target_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.financial_target_id_seq OWNED BY public.financial_target.id;


--
-- TOC entry 220 (class 1259 OID 17272)
-- Name: quotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotation (
    id integer NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    product_and_services text NOT NULL,
    additional_description text DEFAULT ''::text,
    tally_serial_number character varying(255) DEFAULT ''::character varying,
    edition character varying(255) DEFAULT ''::character varying,
    amount_billed numeric(10,2) DEFAULT 0.00 NOT NULL,
    gst numeric(10,2) DEFAULT 0.00 NOT NULL,
    total_amount_billed numeric(10,2) DEFAULT 0.00 NOT NULL,
    next_renewal_date date,
    remarks text DEFAULT ''::text,
    created_by character varying(50) NOT NULL,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(50),
    updated_date timestamp without time zone
);


ALTER TABLE public.quotation OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17271)
-- Name: quotation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quotation_id_seq OWNER TO postgres;

--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 219
-- Name: quotation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quotation_id_seq OWNED BY public.quotation.id;


--
-- TOC entry 218 (class 1259 OID 17253)
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id integer NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    product_and_services text NOT NULL,
    additional_description text DEFAULT ''::text,
    tally_serial_number character varying(255) DEFAULT ''::character varying,
    edition character varying(255) DEFAULT ''::character varying,
    amount_billed numeric(10,2) DEFAULT 0.00 NOT NULL,
    gst numeric(10,2) DEFAULT 0.00 NOT NULL,
    total_amount_billed numeric(10,2) DEFAULT 0.00 NOT NULL,
    next_renewal_date date,
    remarks text DEFAULT ''::text,
    user_role character varying(50) DEFAULT ''::character varying,
    created_by character varying(50) NOT NULL,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(50),
    updated_date timestamp without time zone
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17252)
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_id_seq OWNER TO postgres;

--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 217
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- TOC entry 223 (class 1259 OID 17338)
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17572)
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    name character varying(255) NOT NULL,
    level integer NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17567)
-- Name: user_level; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_level (
    name character varying(255) NOT NULL,
    label integer NOT NULL
);


ALTER TABLE public.user_level OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17561)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    level integer NOT NULL,
    status integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17560)
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_roles_id_seq OWNER TO postgres;

--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- TOC entry 229 (class 1259 OID 17582)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    user_level integer DEFAULT 2,
    status integer DEFAULT 1,
    created_by character varying(50) NOT NULL,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(50),
    updated_date timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17581)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4699 (class 2604 OID 17293)
-- Name: company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company ALTER COLUMN id SET DEFAULT nextval('public.company_id_seq'::regclass);


--
-- TOC entry 4727 (class 2604 OID 17603)
-- Name: financial_target id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financial_target ALTER COLUMN id SET DEFAULT nextval('public.financial_target_id_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 17275)
-- Name: quotation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation ALTER COLUMN id SET DEFAULT nextval('public.quotation_id_seq'::regclass);


--
-- TOC entry 4678 (class 2604 OID 17256)
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- TOC entry 4722 (class 2604 OID 17564)
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- TOC entry 4723 (class 2604 OID 17585)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4904 (class 0 OID 17290)
-- Dependencies: 222
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4913 (class 0 OID 17600)
-- Dependencies: 231
-- Data for Name: financial_target; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.financial_target VALUES (1, 1, '2025', 1000000.00, 650000.00, 350000.00, 'Software Developer', 'Creating and Maintaining Web Applications', 'Babu Boyapati') ON CONFLICT DO NOTHING;


--
-- TOC entry 4902 (class 0 OID 17272)
-- Dependencies: 220
-- Data for Name: quotation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.quotation VALUES (1, '2024-04-02', 'Tally silver -TSS', 'Training one hour free', '', 'Silver', 4500.00, 810.00, 5310.00, '2024-04-01', '(UDF)', '<created_by>', '2025-01-07 01:10:52.932406', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.quotation VALUES (2, '2024-04-02', 'Tally silver -TSS', 'Training one hour free', '', 'Silver', 4500.00, 810.00, 5310.00, '2024-04-01', '(UDF)', '<created_by>', '2025-01-07 01:56:45.30776', NULL, NULL) ON CONFLICT DO NOTHING;


--
-- TOC entry 4900 (class 0 OID 17253)
-- Dependencies: 218
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sales VALUES (2, '2024-04-03', 'Tally services', '', '', '', 0.00, 0.00, 0.00, NULL, '', '', '<created_by>', '2025-01-07 00:54:35.783376', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (3, '2024-04-04', 'Tally Gold- Tss', 'Auto backup given free 1st one year', '752115544', 'Gold', 13500.00, 2430.00, 15930.00, '2024-04-03', '(UDF)', '', '<created_by>', '2025-01-07 00:54:35.783376', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (4, '2024-04-05', 'Tally customizations', 'Invoice customization', '', 'Gold', 5000.00, 900.00, 5900.00, NULL, '', '', '<created_by>', '2025-01-07 00:54:35.783376', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (5, '2024-04-06', 'Tally services', 'Tally AWS cloud', '', 'Silver', 4000.00, 720.00, 4720.00, '2024-04-05', '(UDF)', '', '<created_by>', '2025-01-07 00:54:35.783376', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (6, '2024-04-07', 'Annual maintainance', 'one year Gold', '789474874', 'Gold', 4000.00, 720.00, 4720.00, '2024-04-06', '', '', '<created_by>', '2025-01-07 00:54:35.783376', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (1, '2024-04-02', 'Tally silver -TSS', 'Training one hour free', '', 'Silver', 4500.00, 810.00, 5310.00, '2024-04-01', '(UDF)', 'user', '<created_by>', '2025-01-07 00:54:35.783376', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (7, '2024-04-02', 'Tally silver -TSS', 'Training one hour free', '', 'Silver', 4500.00, 810.00, 5310.00, '2024-04-01', '(UDF)', '', '<created_by>', '2025-01-07 01:56:45.30776', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (8, '2024-04-03', 'Tally services', '', '', '', 0.00, 0.00, 0.00, NULL, '', '', '<created_by>', '2025-01-07 01:56:45.30776', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (9, '2024-04-04', 'Tally Gold- Tss', 'Auto backup given free 1st one year', '752115544', 'Gold', 13500.00, 2430.00, 15930.00, '2024-04-03', '(UDF)', '', '<created_by>', '2025-01-07 01:56:45.30776', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (10, '2024-04-05', 'Tally customizations', 'Invoice customization', '', 'Gold', 5000.00, 900.00, 5900.00, NULL, '', '', '<created_by>', '2025-01-07 01:56:45.30776', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (11, '2024-04-06', 'Tally services', 'Tally AWS cloud', '', 'Silver', 4000.00, 720.00, 4720.00, '2024-04-05', '(UDF)', '', '<created_by>', '2025-01-07 01:56:45.30776', NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.sales VALUES (12, '2024-04-07', 'Annual maintainance', 'one year Gold', '789474874', 'Gold', 4000.00, 720.00, 4720.00, '2024-04-06', '', '', '<created_by>', '2025-01-07 01:56:45.30776', NULL, NULL) ON CONFLICT DO NOTHING;


--
-- TOC entry 4905 (class 0 OID 17338)
-- Dependencies: 223
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.session VALUES ('NNPSMfLZ4pSN7_7InIIaXTn9lGyMTl-D', '{"cookie":{"originalMaxAge":2592000000,"expires":"2025-02-10T09:32:45.220Z","httpOnly":true,"path":"/"},"userId":2,"userLevel":1}', '2025-02-10 01:32:46') ON CONFLICT DO NOTHING;
INSERT INTO public.session VALUES ('-8Yb_9WOs6UEY1t-EKltmimrfptadSAo', '{"cookie":{"originalMaxAge":2592000000,"expires":"2025-02-06T12:03:38.823Z","httpOnly":true,"path":"/"},"userId":2,"userRole":"user"}', '2025-02-06 04:03:39') ON CONFLICT DO NOTHING;
INSERT INTO public.session VALUES ('4-FXGMYYc17QW9YcepOeaqLNmEqXmJ1T', '{"cookie":{"originalMaxAge":2592000000,"expires":"2025-02-08T12:19:11.745Z","httpOnly":true,"path":"/"},"userId":2,"userLevel":1}', '2025-02-08 04:19:12') ON CONFLICT DO NOTHING;
INSERT INTO public.session VALUES ('sRU8hyCFLZa0_CgzBY7X_kkk-CJ9p5kJ', '{"cookie":{"originalMaxAge":2592000000,"expires":"2025-02-08T12:52:31.663Z","httpOnly":true,"path":"/"},"userId":2,"userLevel":1}', '2025-02-08 05:26:16') ON CONFLICT DO NOTHING;


--
-- TOC entry 4909 (class 0 OID 17572)
-- Dependencies: 227
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.status VALUES ('Active', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.status VALUES ('Inactive', 2) ON CONFLICT DO NOTHING;


--
-- TOC entry 4908 (class 0 OID 17567)
-- Dependencies: 226
-- Data for Name: user_level; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_level VALUES ('Admin', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.user_level VALUES ('User', 2) ON CONFLICT DO NOTHING;


--
-- TOC entry 4907 (class 0 OID 17561)
-- Dependencies: 225
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_roles VALUES (1, 'Admin', 1, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.user_roles VALUES (2, 'User', 2, 1) ON CONFLICT DO NOTHING;


--
-- TOC entry 4911 (class 0 OID 17582)
-- Dependencies: 229
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Bhuwan Pandey', 'bhuwan@gmail.com', '$2b$10$5QCef7WKVgGxUZ5GFwqNB.22EHQj1lfoxkxuCuzcdP9Nx2nfCxtfG', 2, 1, 'system', '2025-01-08 20:58:35.108415', 'Bhuwan Pandey', '2025-01-09 16:32:37.68') ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (2, 'Ram', 'ram@gmail.com', '$2b$10$FozGIOIrIroQCXElf82GnOTI6xVkWxR4embVNFxEd7lo2nAPwzFbK', 1, 1, 'system', '2025-01-08 21:02:02.366763', 'Ram', '2025-01-09 17:50:35.185') ON CONFLICT DO NOTHING;


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 221
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_id_seq', 1, false);


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 230
-- Name: financial_target_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.financial_target_id_seq', 1, true);


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 219
-- Name: quotation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quotation_id_seq', 2, true);


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 217
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_seq', 12, true);


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 1, false);


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 228
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4737 (class 2606 OID 17319)
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- TOC entry 4752 (class 2606 OID 17609)
-- Name: financial_target financial_target_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financial_target
    ADD CONSTRAINT financial_target_pkey PRIMARY KEY (id);


--
-- TOC entry 4735 (class 2606 OID 17288)
-- Name: quotation quotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_pkey PRIMARY KEY (id);


--
-- TOC entry 4733 (class 2606 OID 17270)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- TOC entry 4740 (class 2606 OID 17344)
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- TOC entry 4746 (class 2606 OID 17576)
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (name);


--
-- TOC entry 4744 (class 2606 OID 17571)
-- Name: user_level user_level_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_level
    ADD CONSTRAINT user_level_pkey PRIMARY KEY (name);


--
-- TOC entry 4742 (class 2606 OID 17566)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4748 (class 2606 OID 17596)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4750 (class 2606 OID 17598)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4738 (class 1259 OID 17345)
-- Name: idx_session_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_session_expire ON public.session USING btree (expire);


--
-- TOC entry 4753 (class 2606 OID 17610)
-- Name: financial_target fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financial_target
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-01-11 18:58:41

--
-- PostgreSQL database dump complete
--

