--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: coord; Type: TABLE; Schema: public; Owner: jamhed; Tablespace: 
--

CREATE TABLE coord (
    node_id integer,
    stamp timestamp without time zone,
    attitude real,
    longitude real
);


ALTER TABLE coord OWNER TO jamhed;

--
-- Name: name; Type: TABLE; Schema: public; Owner: jamhed; Tablespace: 
--

CREATE TABLE name (
    id integer NOT NULL,
    node_id integer,
    name text,
    stamp timestamp without time zone
);


ALTER TABLE name OWNER TO jamhed;

--
-- Name: name_id_seq; Type: SEQUENCE; Schema: public; Owner: jamhed
--

CREATE SEQUENCE name_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE name_id_seq OWNER TO jamhed;

--
-- Name: name_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamhed
--

ALTER SEQUENCE name_id_seq OWNED BY name.id;


--
-- Name: node; Type: TABLE; Schema: public; Owner: jamhed; Tablespace: 
--

CREATE TABLE node (
    id integer NOT NULL
);


ALTER TABLE node OWNER TO jamhed;

--
-- Name: node_id_seq; Type: SEQUENCE; Schema: public; Owner: jamhed
--

CREATE SEQUENCE node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE node_id_seq OWNER TO jamhed;

--
-- Name: node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamhed
--

ALTER SEQUENCE node_id_seq OWNED BY node.id;


--
-- Name: rel; Type: TABLE; Schema: public; Owner: jamhed; Tablespace: 
--

CREATE TABLE rel (
    node_id integer,
    parent_id integer,
    stamp timestamp without time zone
);


ALTER TABLE rel OWNER TO jamhed;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jamhed
--

ALTER TABLE ONLY name ALTER COLUMN id SET DEFAULT nextval('name_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jamhed
--

ALTER TABLE ONLY node ALTER COLUMN id SET DEFAULT nextval('node_id_seq'::regclass);


--
-- Data for Name: coord; Type: TABLE DATA; Schema: public; Owner: jamhed
--

COPY coord (node_id, stamp, attitude, longitude) FROM stdin;
\.


--
-- Data for Name: name; Type: TABLE DATA; Schema: public; Owner: jamhed
--

COPY name (id, node_id, name, stamp) FROM stdin;
\.


--
-- Name: name_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jamhed
--

SELECT pg_catalog.setval('name_id_seq', 1, false);


--
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: jamhed
--

COPY node (id) FROM stdin;
\.


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jamhed
--

SELECT pg_catalog.setval('node_id_seq', 1, false);


--
-- Data for Name: rel; Type: TABLE DATA; Schema: public; Owner: jamhed
--

COPY rel (node_id, parent_id, stamp) FROM stdin;
\.


--
-- Name: name_pkey; Type: CONSTRAINT; Schema: public; Owner: jamhed; Tablespace: 
--

ALTER TABLE ONLY name
    ADD CONSTRAINT name_pkey PRIMARY KEY (id);


--
-- Name: node_pkey; Type: CONSTRAINT; Schema: public; Owner: jamhed; Tablespace: 
--

ALTER TABLE ONLY node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: coord_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamhed
--

ALTER TABLE ONLY coord
    ADD CONSTRAINT coord_node_id_fkey FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: name_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamhed
--

ALTER TABLE ONLY name
    ADD CONSTRAINT name_node_id_fkey FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: rel_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamhed
--

ALTER TABLE ONLY rel
    ADD CONSTRAINT rel_node_id_fkey FOREIGN KEY (node_id) REFERENCES node(id);


--
-- Name: rel_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamhed
--

ALTER TABLE ONLY rel
    ADD CONSTRAINT rel_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES node(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

