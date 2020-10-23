--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

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
-- Name: projects; Type: TABLE; Schema: public; Owner: adammansell
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying
);


ALTER TABLE public.projects OWNER TO adammansell;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: adammansell
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO adammansell;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adammansell
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: adammansell
--

CREATE TABLE public.volunteers (
    id integer NOT NULL,
    name character varying,
    project_id integer,
    hours integer
);


ALTER TABLE public.volunteers OWNER TO adammansell;

--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: adammansell
--

CREATE SEQUENCE public.volunteers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_id_seq OWNER TO adammansell;

--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: adammansell
--

ALTER SEQUENCE public.volunteers_id_seq OWNED BY public.volunteers.id;


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: adammansell
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: adammansell
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN id SET DEFAULT nextval('public.volunteers_id_seq'::regclass);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: adammansell
--

COPY public.projects (id, title) FROM stdin;
126	Community Park Project
127	Skate Park Project
129	Town Pool Project
\.


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: adammansell
--

COPY public.volunteers (id, name, project_id, hours) FROM stdin;
81	Sam	126	\N
82	Ibraheem	126	\N
83	Daniel	126	\N
84	Kim	126	\N
85	Kate	127	\N
86	Nick	127	\N
87	Daniel	127	\N
88	Felicity	127	\N
93	Kiah	129	\N
94	Ry	129	\N
95	Ramsey	129	\N
96	Sergio	129	\N
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adammansell
--

SELECT pg_catalog.setval('public.projects_id_seq', 129, true);


--
-- Name: volunteers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: adammansell
--

SELECT pg_catalog.setval('public.volunteers_id_seq', 96, true);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: adammansell
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: adammansell
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

