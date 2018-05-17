--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: address_standardizer_data_us; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS address_standardizer_data_us WITH SCHEMA public;


--
-- Name: EXTENSION address_standardizer_data_us; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer_data_us IS 'Address Standardizer US dataset example';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: poi_photos; Type: TABLE; Schema: public; Owner: rachelpoulos
--

CREATE TABLE public.poi_photos (
    id integer NOT NULL,
    poiid integer,
    photo character varying,
    userid integer
);


ALTER TABLE public.poi_photos OWNER TO rachelpoulos;

--
-- Name: poi_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: rachelpoulos
--

CREATE SEQUENCE public.poi_photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poi_photos_id_seq OWNER TO rachelpoulos;

--
-- Name: poi_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rachelpoulos
--

ALTER SEQUENCE public.poi_photos_id_seq OWNED BY public.poi_photos.id;


--
-- Name: pois; Type: TABLE; Schema: public; Owner: rachelpoulos
--

CREATE TABLE public.pois (
    id integer NOT NULL,
    walkid integer,
    description character varying,
    video character varying,
    audio character varying,
    thumbnail character varying,
    next_audio text,
    "position" integer,
    address character varying,
    title character varying NOT NULL,
    lat numeric,
    long numeric
);


ALTER TABLE public.pois OWNER TO rachelpoulos;

--
-- Name: pois_id_seq; Type: SEQUENCE; Schema: public; Owner: rachelpoulos
--

CREATE SEQUENCE public.pois_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pois_id_seq OWNER TO rachelpoulos;

--
-- Name: pois_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rachelpoulos
--

ALTER SEQUENCE public.pois_id_seq OWNED BY public.pois.id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: rachelpoulos
--

CREATE TABLE public.ratings (
    id integer NOT NULL,
    userid integer,
    walkid integer,
    rating integer,
    comment character varying
);


ALTER TABLE public.ratings OWNER TO rachelpoulos;

--
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: rachelpoulos
--

CREATE SEQUENCE public.ratings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ratings_id_seq OWNER TO rachelpoulos;

--
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rachelpoulos
--

ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: rachelpoulos
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    email character varying NOT NULL,
    thumbnail character varying,
    aboutme character varying,
    location character varying
);


ALTER TABLE public.users OWNER TO rachelpoulos;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: rachelpoulos
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO rachelpoulos;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rachelpoulos
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: walk_photos; Type: TABLE; Schema: public; Owner: rachelpoulos
--

CREATE TABLE public.walk_photos (
    id integer NOT NULL,
    walkid integer,
    userid integer,
    photo character varying
);


ALTER TABLE public.walk_photos OWNER TO rachelpoulos;

--
-- Name: walk_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: rachelpoulos
--

CREATE SEQUENCE public.walk_photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.walk_photos_id_seq OWNER TO rachelpoulos;

--
-- Name: walk_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rachelpoulos
--

ALTER SEQUENCE public.walk_photos_id_seq OWNED BY public.walk_photos.id;


--
-- Name: walks; Type: TABLE; Schema: public; Owner: rachelpoulos
--

CREATE TABLE public.walks (
    id integer NOT NULL,
    thumbnail character varying,
    description character varying,
    length numeric,
    video character varying,
    audio character varying,
    public boolean DEFAULT false,
    title character varying NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.walks OWNER TO rachelpoulos;

--
-- Name: walks_id_seq; Type: SEQUENCE; Schema: public; Owner: rachelpoulos
--

CREATE SEQUENCE public.walks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.walks_id_seq OWNER TO rachelpoulos;

--
-- Name: walks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rachelpoulos
--

ALTER SEQUENCE public.walks_id_seq OWNED BY public.walks.id;


--
-- Name: poi_photos id; Type: DEFAULT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.poi_photos ALTER COLUMN id SET DEFAULT nextval('public.poi_photos_id_seq'::regclass);


--
-- Name: pois id; Type: DEFAULT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.pois ALTER COLUMN id SET DEFAULT nextval('public.pois_id_seq'::regclass);


--
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: walk_photos id; Type: DEFAULT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.walk_photos ALTER COLUMN id SET DEFAULT nextval('public.walk_photos_id_seq'::regclass);


--
-- Name: walks id; Type: DEFAULT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.walks ALTER COLUMN id SET DEFAULT nextval('public.walks_id_seq'::regclass);


--
-- Data for Name: poi_photos; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.poi_photos (id, poiid, photo, userid) FROM stdin;
\.


--
-- Data for Name: pois; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.pois (id, walkid, description, video, audio, thumbnail, next_audio, "position", address, title, lat, long) FROM stdin;
150	115	\N	\N	\N	defaults/walkme_icon.png	\N	0	248 Oakland Ave SE, Atlanta, GA 30312, USA	Oakland Cemtery	33.74858839999999	-84.37298650000002
151	112	\N	\N	\N	defaults/walkme_icon.png	\N	1	377 Decatur St SE & Grant Street, Atlanta, GA 30312, USA	King Memorial	33.7499705	-84.37558139999999
146	113	Where I lived.	\N	\N	defaults/walkme_icon.png	\N	0	1631 Arbor Ave, Highland Park, IL 60035, USA	Old House	42.1822884	-87.82553910000001
148	113	\N	\N	uploads/poi-audio/a7d8a87f21c739c5046b3a3eb679923e	defaults/walkme_icon.png	\N	1	433 Vine Ave, Highland Park, IL 60035, USA	Highland Park High School	42.1926682	-87.80135559999997
149	115	\N	\N	\N	defaults/walkme_icon.png	\N	1	219 Pearl St SE, Atlanta, GA 30316, USA	My House	33.7483687	-84.3623172
152	116	\N	\N	\N	defaults/walkme_icon.png	\N	0	3423 Piedmont Rd NE, Atlanta, GA 30305, USA	Tech Village	33.8487474	-84.37338510000001
145	112	\N	\N	uploads/poi-audio/6c529874c19226f18b0f4b06e8b0fb73	defaults/walkme_icon.png	uploads/poi-next-audio/54e791ee25e3aa0cba3734ef6579e5ae	0	219 Pearl St SE, Atlanta, GA 30316, USA	219 Pearl St 	33.7483687	-84.3623172
\.


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.ratings (id, userid, walkid, rating, comment) FROM stdin;
\.


--
-- Data for Name: us_gaz; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.us_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: us_lex; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.us_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: us_rules; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.us_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.users (id, username, password, email, thumbnail, aboutme, location) FROM stdin;
3	rfpoulos	$2b$10$RgIvWc8K3Ow1S63XlBhTIuAxWv985/6eHmWny1zT.PgOAPt2kQUKe	rfpoulos@outlook.com	\N	\N	\N
4	test	$2b$10$.P.3Fb.zvVoZi5dmI4HFueaDid2H7TJ4s1aJnp42apZePh.bYKaKW	test@email.com	\N	\N	\N
5	test2	$2b$10$u0HXt6dSjZJd7oviRM0N4.1E5Gn3WsA6YBquexDhpxH2gOL8NZBhy	test2@email.com	\N	\N	\N
6	test3	$2b$10$NV18rONY0CVOgA.EeZ0Yd.OvXN3oLDp.Ae16ejxDEXC1kPCcDBbPu	test3@email.com	\N	\N	\N
8	test6	$2b$10$6k9SJdbgUIQw4QtWvplsa.HWpgzE7cVmRjNgYVbpcS32LnLYR6Vae	test6@email.com	\N	\N	\N
9	test7	$2b$10$qIqGGB2qMlHCG44equMcDuVsN3AYOn6wyV0OwowV9fZL3Qh8aBP8C	test7@email.com	\N	\N	\N
10	test8	$2b$10$UgIXq4bw/qs2n8Q/LgYjC.4fM1adiVAIkEGVrSDWfbvMW6GmATJ.W	test8@email.com	\N	\N	\N
11	test9	$2b$10$SeezJGIJcSj/doatbFnuTehyeJR4Z/nMw/wRW7yQyxTH8v1dCEU5a	test9@email.com	\N	\N	\N
12	test10	$2b$10$pZzbUhWTSqKzu5aSwSVYh.AgnoyhFGAJj/M9DmBbSLoQw2Ymn9E4e	test10@email.com	\N	\N	\N
13	test11	$2b$10$LTexCXMYJEjl1V9T.3iZROXUu.EAgu7lS426Qa41KnUzvWACvGI6u	test11@email.com	\N	\N	\N
14	test12	$2b$10$3au3OtZMHW9RIn3J/dvFiOFH1TcdvJvGNLNemd04cahS9VQcHWukK	test12@email.com	\N	\N	\N
15	test13	$2b$10$4B5KpPTbF.ExoJ1xjL4avussR4Y3xXh/HS8NbWCiAWJyCmFvN4CNe	test13@email.com	\N	\N	\N
16	test14	$2b$10$Xg/dYERg9WaL/pfOmv/KEu4l1mcjLfWnSipmPUteB5dhMxNlTAkm.	test14@email.com	null	I like walking!	\N
17	test15	$2b$10$/wae1n.Rw2ZL6/4/9b2XpeFfyV9v6oJFmSiMqPUdCx0rXma5IPS66	test15@email.com	null	test	\N
18	test16	$2b$10$5itpyE/4UphmIavp.9JpBOEkoI0cJzsDKbGo7gnXvRsm/PhExTm2u	test16@email.com	\N		\N
19	test17	$2b$10$YgMvCaKFzaCQFnJlW5FXPOFNbftr6n2OwgikMRylmGhLtzcaL0.rq	test17@email.com	\N		\N
20	test18	$2b$10$NilIHQboO1EaweX2kapQFO2u5lSq9zzbBXOp9CoS5bP2trCKZEqTK	test18@email.com	\N		\N
21	test19	$2b$10$S.2WRtuo6tUc6KIkdH/5qedbA5bMA8IVi1myo4kiEtAwDfHuRgcqi	test19@email.com	\N		\N
22	test20	$2b$10$apyrcP9Ff8z31zb7tmr7seNmJH6S0kDYhShmDvjeGKfX3azK/Tf5W	test20@email.com	\N		\N
23	test21	$2b$10$WK5ywX.FVMb/xb1R5M2sqeKeZJJ0OTfhXQhzCazu6QPK40vgJeR9m	test21@email.com	\N		\N
24	test23	$2b$10$m59r0wgupjoqV8pmXqnYWeb348qGklaUTq7ptaNp/omkqwTamiXUi	test23@email.com	\N		\N
25	test24	$2b$10$xp1H/fUyTuc57UgqukbTCeUtwelyxEZFvWRRqvYkkS0wfxKjQP7Se	test24@email.com	\N		\N
26	test25	$2b$10$55KakTmmaBT2PXxCg8Hs0eglHrBccXUDlDVjgRlRj.zwf7EnApUg2	test25@email.com	\N		\N
27	test26	$2b$10$XYdrMHnVLdReH2Gqw4yOPO95wOiyra/VRYNN9twQxxtT5e6U9GqSC	test26@email.com	\N		\N
28	test27	$2b$10$55leNozeqVbIeRQipQa4huJDGniV56gP9M6/zK6f8VrTT0ijHZxJm	test27@email.com	\N		\N
29	test28	$2b$10$kG6Xqe5eMTTgOMuy5iG4k.uPOqTSqnCt5/v58dSHgEsvhpC1/VHpK	test28@email.com	\N		\N
30	test29	$2b$10$sbHPwdctDTfmIPhJ1cPIqOG7EzYUFlAusZQ6YyNrcLZ98hGjleWR2	test29@email.com	\N		\N
32	test31	$2b$10$TB4GISCQ1PFd.MS.2pPYQOY9EmEvco2gJEnTjEpr4ljolRyuc8Dze	test31@email.com	\N		\N
33	test32	$2b$10$/2/1W7fmbP6b2BoEOVNmGOjuhwl8VaYgGLai/vh.kkb9vdXVtr6wC	test32@email.com	\N		\N
35	test34	$2b$10$YWSZBhYslEEytAbDKnrNoetJQTxoDLEEaEs5uQNHhhiIa2pWaeosi	test34@email.com	\N		\N
36	test35	$2b$10$vV1xJE0bydvzOsfYPxfVfOzRBGAkltKuVww5T/RSJpg1LTfFirqgS	test35@email.com	\N		\N
37	test36	$2b$10$Y0LCDIQu9rp/JfEDyVrqYOo2V0glWMCEE25kKQhs1xUKC6uS57YeS	test36@email.com	\N		\N
38	test37	$2b$10$ViQwzOeeOTf0rhL1pkZlB.GaTjvsRrLHLW1lBeXqUqEV6ztIpK9pm	test37@email.com	\N		\N
39	test38	$2b$10$iNpb3SpT5aR..74E5kRK2.OToAk1HJmvsXcDavBm81Ro.nlcwNgN6	test38@email.com	\N		\N
40	test39	$2b$10$62iXcPC/5UV9o6ijlP/8W.g4cikYnRWAREG6ugdbHogi0ObDTwBwm	test39@email.com	\N		\N
41	test40	$2b$10$.VDMMdenxVggQefYAag5/.CdIyB0K6slXp0lSfu8QQT4xbYevmAaO	test40@email.com	\N		\N
42	test41	$2b$10$GvCFfmkQsZIvamk50YF/POlNEnxzXnpvKA5ZZph0O7Jo.CzWJnLEC	test41@email.com	\N		\N
44	test43	$2b$10$/kk5bUoWvS7QiZE/udsLseN5XtgVtz//aMv5x7XMUpKE9jwZluss2	test43@email.com	\N		\N
45	test44	$2b$10$jtarxPXh.1r/TlfxFaSpVOFZx1smZs8SA6pfn3jTtqbGt.GAe13i6	test44@email.com	\N		\N
46	test45	$2b$10$Jivp2fGUFuf8N7/PeOThOO95gjEQgwM6wDtJmSkuwnGDtBJL1/9ru	test45@email.com	\N		\N
47	test46	$2b$10$G7YsgVF305uMquft1PkwO.w.Yj6Uoj7I6aCuARk9dz4Cnyy2g/BIu	test46@email.com	\N		\N
50	test48	$2b$10$FMnsrbe5hnAZgw5yaNB4SOZd/7R8FLVSRRpoKfBBcwtkrq/NU4jnm	test48@email.com	uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf	undefined	\N
51	test49	$2b$10$mYs4vjAbfQEXZgAN3x/gpOZXfjKg/lEhWmdYNd/FXXTYutFCf5hd6	test49@email.com	uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf	undefined	\N
53	test51	$2b$10$NrxriywTuMLXfIeheAgKl.E.iju1zwsQUFaJe2YTLpCatCrpuRj/a	test51@email.com	uploads/profile-pics/10a7f2dd9f7df3ab1c5ea1f563563850	\N	\N
7	test5	$2b$10$PTk4/gcTU6o0N7vwjXMAMOtNIspYVoeaytyruGK26zQLlnA0YNV1S	test5@email.com	public/uploads/profile-pics/b554fb27f82010798c75ee5ce589468f	\N	\N
34	test33	$2b$10$gDOX1XL./Xn3BXp/3J8EvOOociGH0z89r0BIwsQZCVF12M7nWhPk.	test33@email.com	uploads/profile-pics/43d2b38ab049d85944c4bec2927b50ea		\N
31	test30	$2b$10$ZZ01mcYoC4nIcQ1gSanoTu3MQlbJ5DJpqjpQzbLd69rbjOJ5dNlLy	test30@email.com	uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf		\N
49	test47	$2b$10$g9iJAqWZDBXCiLFfzn6NPucQNm92EkwWSlBqqgg4Y1X.vnfUxGoPC	test47@email.com	uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf		\N
54	test52	$2b$10$bpZ5se55snq66dxt3g/5Ke2ryzgkxvg5JsJjH1UOnYW6YdnTCIwBu	test52@email.com	uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf	\N	\N
52	test50	$2b$10$bdQZY51Pso.ExohyLmpHaOsniQtct.S.nUmyH3kGzjiCf8QwQvFqW	test50@email.com	uploads/profile-pics/53700b21e3b44a9d7367f79f0ab6724a	undefined	\N
43	test42	$2b$10$apN/pjPKjCqnckGGIJGya.rjkK/F4pQEB7sF0dLmB0BdSbh2dI4h2	test42@email.com	uploads/profile-pics/ee7b73aecde67da9a652f8bc16e34b92		\N
55	test53	$2b$10$dHm9y78bYuU3n41lByx2bOBh/FzqEHk5RxBz8BAw8twYYNBNm0pRW	test53@email.com	uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf	\N	\N
59	test55	$2b$10$zRHDYMel6jZ364voPTcqlOZX.Ix7PrgeDOpJHYzAzEhucfuSYTmsm	test55@email.com	uploads/profile-pics/430adb90cb90097c69c7aa3ea7109daf	\N	\N
57	test54	$2b$10$IlF09KE9Jyq4JAqOmNPGO.LYJBNeBmsb73VyOvuIE8ttVVxV9Xs6i	test54@email.com	uploads/profile-pics/2fb6bbf02097688bf6695c36b8910fe7	sdjbvjkbvejlgebjl	ndbfs,f
60	test56	$2b$10$6YL7fmyF2ycg4bGFwL2AzeQPlg4XErHhUIAfUXwjyWUqpTdYj/poi	test56@email.com	uploads/profile-pics/37b93876da290618a3ea36e8e4a8b3ec	Sit amet commodo urna sed ac\nVarius nulla nunc in ut donec. Tellus lorem congue. Justo nec non a libero placerat placerat dui eget vulputate non semper mi mauris cursus. Quisque tempus posuere. Quis leo dolor justo in rutrum magnis sociis at. Eros interdum leo. Consequat massa eleifend. Vivamus nisl convallis porta aspernatur ultricies accumsan ut at.\n\nErat adipiscing felis\nArcu eros aliquam eu mi vel amet turpis non in cras integer in orci justo. In nam accumsan. Cursus est aliquam autem consectetuer semper. Et erat reiciendis tellus cursus justo. Morbi semper odio. In volutpat arcu maecenas neque volutpat. Tristique diam orci quisque natus ornare. Lacus id urna urna luctus urna nec et pede. Sit eu pellentesque. Vulputate lobortis non massa aenean tincidunt eros integer vehicula. Pellentesque lectus nec aliquam dolor tellus. Aenean facilisi mollis. Risus praesent arcu risus nam vivamus dui aliqua mauris. Consequat pharetra eleifend bibendum augue consequat habitasse viverra quam. Id egestas interdum. Maecenas fringilla fringilla mauris class ac risus non interdum vitae sit neque. Enim nunc mattis. Tempus volutpat dolor. Neque et ipsum.\n\nNec eget mattis con etiam libero\nMi mauris in nunc a auctor maecenas magna suspendisse ultrices egestas et sodales non sociis. Luctus arcu at. Nemo lobortis urna vitae laoreet cras. Vel suspendisse in. Parturient sed semper est nunc purus. Ac id urna euismod neque quisque a nibh parturient gravida pretium ut. Turpis wisi nec. Suspendisse aliquet pulvinar sed felis et. Vitae et dui diam vivamus lorem. Wisi sed velit. Orci nec vestibulum. Pellentesque et neque. Potenti cumque vehicula. Posuere diam turpis iaculis eu ultricies sed metus metus in posuere aliquam ut dapibus massa mauris eu fusce dui nulla risus nunc nec morbi. Adipiscing aliquam fusce. Venenatis quis vel porttitor eget ipsum. Qui maecenas irure. Pellentesque eu per. Hac aptent donec.	Atlanta, GA
\.


--
-- Data for Name: walk_photos; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.walk_photos (id, walkid, userid, photo) FROM stdin;
\.


--
-- Data for Name: walks; Type: TABLE DATA; Schema: public; Owner: rachelpoulos
--

COPY public.walks (id, thumbnail, description, length, video, audio, public, title, userid) FROM stdin;
113	defaults/walkme_icon.png	fbkegbek	3300	\N	\N	t	A Walk to Remember	60
115	uploads/walk-thumbnail/07cc250dfc39870870fe0715bc73ca00	This is where I live.	1368	uploads/walk-video/635f2c886e6befc1a9d9a4d7968728f4	uploads/walk-audio/4677a0398f5965c07f9dc47cf533ea28	t	Atlanta Tour	60
116	defaults/walkme_icon.png	jfwlfbwl	\N	\N	\N	t	Tech Village	60
112	defaults/walkme_icon.png	nv ebkvkevbekbhvekrv	1572	\N	uploads/walk-audio/2a7121c36b322624bd021af9ee240f8e	t	12345678901234567890	60
\.


--
-- Name: poi_photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rachelpoulos
--

SELECT pg_catalog.setval('public.poi_photos_id_seq', 1, false);


--
-- Name: pois_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rachelpoulos
--

SELECT pg_catalog.setval('public.pois_id_seq', 152, true);


--
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rachelpoulos
--

SELECT pg_catalog.setval('public.ratings_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rachelpoulos
--

SELECT pg_catalog.setval('public.users_id_seq', 60, true);


--
-- Name: walk_photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rachelpoulos
--

SELECT pg_catalog.setval('public.walk_photos_id_seq', 1, false);


--
-- Name: walks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rachelpoulos
--

SELECT pg_catalog.setval('public.walks_id_seq', 116, true);


--
-- Name: poi_photos poi_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.poi_photos
    ADD CONSTRAINT poi_photos_pkey PRIMARY KEY (id);


--
-- Name: pois pois_pkey; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.pois
    ADD CONSTRAINT pois_pkey PRIMARY KEY (id);


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: walk_photos walk_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.walk_photos
    ADD CONSTRAINT walk_photos_pkey PRIMARY KEY (id);


--
-- Name: walks walks_pkey; Type: CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.walks
    ADD CONSTRAINT walks_pkey PRIMARY KEY (id);


--
-- Name: poi_photos poi_photos_poiid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.poi_photos
    ADD CONSTRAINT poi_photos_poiid_fkey FOREIGN KEY (poiid) REFERENCES public.pois(id) ON DELETE CASCADE;


--
-- Name: poi_photos poi_photos_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.poi_photos
    ADD CONSTRAINT poi_photos_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: pois pois_walkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.pois
    ADD CONSTRAINT pois_walkid_fkey FOREIGN KEY (walkid) REFERENCES public.walks(id) ON DELETE CASCADE;


--
-- Name: ratings ratings_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ratings ratings_walkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_walkid_fkey FOREIGN KEY (walkid) REFERENCES public.walks(id) ON DELETE CASCADE;


--
-- Name: walk_photos walk_photos_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.walk_photos
    ADD CONSTRAINT walk_photos_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: walk_photos walk_photos_walkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.walk_photos
    ADD CONSTRAINT walk_photos_walkid_fkey FOREIGN KEY (walkid) REFERENCES public.walks(id) ON DELETE CASCADE;


--
-- Name: walks walks_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rachelpoulos
--

ALTER TABLE ONLY public.walks
    ADD CONSTRAINT walks_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

