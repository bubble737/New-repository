--
-- PostgreSQL database dump
--

\restrict CQIcX3Knlan4QzaUtQIRWRKcmcOcYLsiF80RyRfW3IYcPBPqmlYkLERbmKbJqz1

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    credits integer NOT NULL,
    hours integer NOT NULL,
    type character varying(10),
    uni_id integer NOT NULL,
    CONSTRAINT course_type_check CHECK (((type)::text = ANY ((ARRAY['必修'::character varying, '选修'::character varying])::text[])))
);


ALTER TABLE public.course OWNER TO postgres;

--
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_id_seq OWNER TO postgres;

--
-- Name: course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_id_seq OWNED BY public.course.id;


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    uni_id integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_id_seq OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_id_seq OWNED BY public.department.id;


--
-- Name: major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.major (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    dept_id integer NOT NULL,
    total_credits integer
);


ALTER TABLE public.major OWNER TO postgres;

--
-- Name: major_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.major_course (
    major_id integer NOT NULL,
    course_id integer NOT NULL,
    semester character varying(20)
);


ALTER TABLE public.major_course OWNER TO postgres;

--
-- Name: major_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.major_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.major_id_seq OWNER TO postgres;

--
-- Name: major_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.major_id_seq OWNED BY public.major.id;


--
-- Name: raw_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raw_course (
    id integer NOT NULL,
    uni_name character varying(50),
    major_name character varying(50),
    course_name character varying(100),
    credits integer,
    hours integer,
    type character varying(10),
    CONSTRAINT raw_course_type_check CHECK (((type)::text = ANY ((ARRAY['必修'::character varying, '选修'::character varying])::text[])))
);


ALTER TABLE public.raw_course OWNER TO postgres;

--
-- Name: raw_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.raw_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.raw_course_id_seq OWNER TO postgres;

--
-- Name: raw_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_course_id_seq OWNED BY public.raw_course.id;


--
-- Name: raw_major; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raw_major (
    id integer NOT NULL,
    uni_name character varying(50),
    major_name character varying(50),
    dept_name character varying(50),
    total_credits integer
);


ALTER TABLE public.raw_major OWNER TO postgres;

--
-- Name: raw_major_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raw_major_course (
    id integer NOT NULL,
    uni_name character varying(50),
    major_name character varying(50),
    course_name character varying(100),
    semester character varying(20)
);


ALTER TABLE public.raw_major_course OWNER TO postgres;

--
-- Name: raw_major_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.raw_major_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.raw_major_course_id_seq OWNER TO postgres;

--
-- Name: raw_major_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_major_course_id_seq OWNED BY public.raw_major_course.id;


--
-- Name: raw_major_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.raw_major_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.raw_major_id_seq OWNER TO postgres;

--
-- Name: raw_major_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_major_id_seq OWNED BY public.raw_major.id;


--
-- Name: university; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.university OWNER TO postgres;

--
-- Name: university_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.university_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.university_id_seq OWNER TO postgres;

--
-- Name: university_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.university_id_seq OWNED BY public.university.id;


--
-- Name: course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course ALTER COLUMN id SET DEFAULT nextval('public.course_id_seq'::regclass);


--
-- Name: department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_id_seq'::regclass);


--
-- Name: major id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major ALTER COLUMN id SET DEFAULT nextval('public.major_id_seq'::regclass);


--
-- Name: raw_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_course ALTER COLUMN id SET DEFAULT nextval('public.raw_course_id_seq'::regclass);


--
-- Name: raw_major id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_major ALTER COLUMN id SET DEFAULT nextval('public.raw_major_id_seq'::regclass);


--
-- Name: raw_major_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_major_course ALTER COLUMN id SET DEFAULT nextval('public.raw_major_course_id_seq'::regclass);


--
-- Name: university id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university ALTER COLUMN id SET DEFAULT nextval('public.university_id_seq'::regclass);


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, name, credits, hours, type, uni_id) FROM stdin;
47	当代中国经济问题分析	3	51	选修	3
48	中国特色社会主义政治经济学	3	51	必修	3
49	国家级项目专题研读	3	51	选修	3
50	中国产业经济学	3	51	选修	3
51	计量经济学	3	48	必修	2
52	概率论与数理统计B	4	68	必修	3
53	会计学	3	48	必修	2
54	劳动教育	2	28	必修	3
55	资源与环境经济学	2	32	选修	2
56	经济学学科前沿动态	3	51	选修	3
57	国际商务	3	48	必修	2
58	博弈论与信息经济学	3	51	选修	3
59	马克思主义基本原理	3	51	必修	3
60	名著阅读	2	0	必修	3
61	高级政治经济学	3	51	必修	3
62	习近平新时代中国特色社会主义思想概论	3	51	必修	3
63	经济思想史	3	48	必修	2
64	习近平经济思想	2	34	选修	3
65	中国近现代史纲要	3	51	必修	3
66	经济学原理	3	48	必修	2
67	概率论与数理统计	3	48	必修	2
68	数学分析Ⅰ	5	80	必修	2
69	数字经济学	3	51	必修	3
70	高阶经济数学	3	51	必修	3
71	综合英语III	2	34	必修	3
72	世界经济概论	3	48	必修	2
73	经济史	3	48	必修	2
74	货币银行学	3	48	必修	2
75	中级微观经济学	3	48	必修	2
76	高等数学II	5	58	必修	3
77	大学生职业生涯规划与创业基础	2	36	必修	3
78	高等数学I	5	58	必修	3
79	财政学	3	48	必修	2
80	高级微观经济学	3	48	必修	2
81	《资本论》选读	3	51	必修	3
82	计量经济学	3	51	必修	3
83	国际经济学	3	48	必修	2
84	马克思主义政治经济学	3	51	必修	3
85	形势与政策(I-IV)	2	64	必修	3
86	经济法概论	2	32	必修	2
87	经济学的数据分析方法	3	51	选修	3
88	军事理论	2	36	必修	3
89	政治经济学Ⅰ	3	48	必修	2
90	思想道德与法治	3	51	必修	3
91	创新、创业与社会	2	0	必修	3
92	政治经济学Ⅱ	3	48	必修	2
93	毛泽东思想和中国特色社会主义理论体系概论	3	51	必修	3
94	数学分析Ⅲ	4	64	必修	2
95	国家安全教育	1	16	必修	3
96	数学分析Ⅱ	5	80	必修	2
97	微观经济学	3	51	必修	3
98	资源与环境经济学	3	51	选修	3
99	货币金融学	3	51	必修	3
100	国别与地区经济	2	32	必修	2
101	高级微观经济学	3	51	必修	3
102	中国经济史	3	51	必修	3
103	博弈论	3	48	选修	2
104	财政学	3	51	必修	3
105	行为经济学	2	32	选修	2
106	高级宏观经济学	3	51	必修	3
107	新制度经济学	3	51	选修	3
108	人工智能与现代科技	2	34	必修	3
109	线性代数	3	48	必修	2
110	中国发展经济学	3	51	选修	3
111	大学生心理健康与人生发展	2	34	必修	3
112	宏观经济学	3	51	必修	3
113	经济思想史	3	51	必修	3
114	线性代数	3	35	必修	3
115	中级宏观经济学	3	48	必修	2
116	发展经济学	3	48	选修	2
117	跨国公司与直接投资	3	48	必修	2
118	经济学研究方法与论文写作	3	51	选修	3
119	听说写能力训练	2	34	必修	3
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, name, uni_id) FROM stdin;
2	经济学院	2
3	经济学院	3
\.


--
-- Data for Name: major; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.major (id, name, dept_id, total_credits) FROM stdin;
2	经济学	3	148
3	经济学（世界经济方向）	2	158
\.


--
-- Data for Name: major_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.major_course (major_id, course_id, semester) FROM stdin;
2	47	6
2	48	2
2	49	6
2	50	6
2	52	3
2	54	1-8
2	56	5
2	58	5
2	59	3
2	60	1-8
2	61	5
2	62	5
2	65	2
2	69	3
2	70	4
2	71	1
2	76	2
2	77	2
2	78	1
2	81	5
2	82	4
2	84	1
2	85	1-4
2	87	5
2	88	2
2	90	1
2	91	1-8
2	93	4
2	95	2
2	97	1
2	98	6
2	99	3
2	101	5
2	102	4
2	104	3
2	106	5
2	107	6
2	108	2
2	110	6
2	111	2
2	112	2
2	113	3
2	114	2
2	118	6
2	119	1-6
3	51	4
3	53	3
3	57	5
3	63	4
3	66	1
3	67	3
3	68	1
3	72	4
3	73	5
3	74	4
3	75	3
3	79	3
3	80	5
3	83	4
3	86	3
3	89	1
3	92	2
3	94	3
3	96	2
3	100	6
3	109	2
3	115	4
3	117	5
\.


--
-- Data for Name: raw_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.raw_course (id, uni_name, major_name, course_name, credits, hours, type) FROM stdin;
1	西南财经大学	经济学	中国近现代史纲要	3	51	必修
2	西南财经大学	经济学	形势与政策(I-IV)	2	64	必修
3	西南财经大学	经济学	思想道德与法治	3	51	必修
4	西南财经大学	经济学	毛泽东思想和中国特色社会主义理论体系概论	3	51	必修
5	西南财经大学	经济学	习近平新时代中国特色社会主义思想概论	3	51	必修
6	西南财经大学	经济学	马克思主义基本原理	3	51	必修
7	西南财经大学	经济学	大学生职业生涯规划与创业基础	2	36	必修
8	西南财经大学	经济学	军事理论	2	36	必修
9	西南财经大学	经济学	国家安全教育	1	16	必修
10	西南财经大学	经济学	大学生心理健康与人生发展	2	34	必修
11	西南财经大学	经济学	综合英语III	2	34	必修
12	西南财经大学	经济学	听说写能力训练	2	34	必修
13	西南财经大学	经济学	高等数学I	5	58	必修
14	西南财经大学	经济学	高等数学II	5	58	必修
15	西南财经大学	经济学	线性代数	3	35	必修
16	西南财经大学	经济学	概率论与数理统计B	4	68	必修
17	西南财经大学	经济学	人工智能与现代科技	2	34	必修
18	西南财经大学	经济学	微观经济学	3	51	必修
19	西南财经大学	经济学	宏观经济学	3	51	必修
20	西南财经大学	经济学	计量经济学	3	51	必修
21	西南财经大学	经济学	马克思主义政治经济学	3	51	必修
22	西南财经大学	经济学	中国特色社会主义政治经济学	3	51	必修
23	西南财经大学	经济学	货币金融学	3	51	必修
24	西南财经大学	经济学	数字经济学	3	51	必修
25	西南财经大学	经济学	经济思想史	3	51	必修
26	西南财经大学	经济学	财政学	3	51	必修
27	西南财经大学	经济学	中国经济史	3	51	必修
28	西南财经大学	经济学	高阶经济数学	3	51	必修
29	西南财经大学	经济学	《资本论》选读	3	51	必修
30	西南财经大学	经济学	高级微观经济学	3	51	必修
31	西南财经大学	经济学	高级宏观经济学	3	51	必修
32	西南财经大学	经济学	高级政治经济学	3	51	必修
33	西南财经大学	经济学	习近平经济思想	2	34	选修
34	西南财经大学	经济学	经济学的数据分析方法	3	51	选修
35	西南财经大学	经济学	中国发展经济学	3	51	选修
36	西南财经大学	经济学	博弈论与信息经济学	3	51	选修
37	西南财经大学	经济学	中国产业经济学	3	51	选修
38	西南财经大学	经济学	资源与环境经济学	3	51	选修
39	西南财经大学	经济学	新制度经济学	3	51	选修
40	西南财经大学	经济学	经济学研究方法与论文写作	3	51	选修
41	西南财经大学	经济学	经济学学科前沿动态	3	51	选修
42	西南财经大学	经济学	当代中国经济问题分析	3	51	选修
43	西南财经大学	经济学	国家级项目专题研读	3	51	选修
44	西南财经大学	经济学	劳动教育	2	28	必修
45	西南财经大学	经济学	名著阅读	2	0	必修
46	西南财经大学	经济学	创新、创业与社会	2	0	必修
47	上海财经大学	经济学（世界经济方向）	政治经济学Ⅰ	3	48	必修
48	上海财经大学	经济学（世界经济方向）	政治经济学Ⅱ	3	48	必修
49	上海财经大学	经济学（世界经济方向）	经济思想史	3	48	必修
50	上海财经大学	经济学（世界经济方向）	经济史	3	48	必修
51	上海财经大学	经济学（世界经济方向）	数学分析Ⅰ	5	80	必修
52	上海财经大学	经济学（世界经济方向）	数学分析Ⅱ	5	80	必修
53	上海财经大学	经济学（世界经济方向）	数学分析Ⅲ	4	64	必修
54	上海财经大学	经济学（世界经济方向）	线性代数	3	48	必修
55	上海财经大学	经济学（世界经济方向）	概率论与数理统计	3	48	必修
56	上海财经大学	经济学（世界经济方向）	计量经济学	3	48	必修
57	上海财经大学	经济学（世界经济方向）	经济学原理	3	48	必修
58	上海财经大学	经济学（世界经济方向）	中级微观经济学	3	48	必修
59	上海财经大学	经济学（世界经济方向）	中级宏观经济学	3	48	必修
60	上海财经大学	经济学（世界经济方向）	高级微观经济学	3	48	必修
61	上海财经大学	经济学（世界经济方向）	国际经济学	3	48	必修
62	上海财经大学	经济学（世界经济方向）	世界经济概论	3	48	必修
63	上海财经大学	经济学（世界经济方向）	国际商务	3	48	必修
64	上海财经大学	经济学（世界经济方向）	跨国公司与直接投资	3	48	必修
65	上海财经大学	经济学（世界经济方向）	国别与地区经济	2	32	必修
66	上海财经大学	经济学（世界经济方向）	财政学	3	48	必修
67	上海财经大学	经济学（世界经济方向）	货币银行学	3	48	必修
68	上海财经大学	经济学（世界经济方向）	会计学	3	48	必修
69	上海财经大学	经济学（世界经济方向）	经济法概论	2	32	必修
70	上海财经大学	经济学（世界经济方向）	博弈论	3	48	选修
71	上海财经大学	经济学（世界经济方向）	发展经济学	3	48	选修
72	上海财经大学	经济学（世界经济方向）	资源与环境经济学	2	32	选修
73	上海财经大学	经济学（世界经济方向）	行为经济学	2	32	选修
\.


--
-- Data for Name: raw_major; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.raw_major (id, uni_name, major_name, dept_name, total_credits) FROM stdin;
1	西南财经大学	经济学	经济学院	148
2	上海财经大学	经济学（世界经济方向）	经济学院	158
\.


--
-- Data for Name: raw_major_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.raw_major_course (id, uni_name, major_name, course_name, semester) FROM stdin;
1	西南财经大学	经济学	中国近现代史纲要	2
2	西南财经大学	经济学	形势与政策(I-IV)	1-4
3	西南财经大学	经济学	思想道德与法治	1
4	西南财经大学	经济学	毛泽东思想和中国特色社会主义理论体系概论	4
5	西南财经大学	经济学	习近平新时代中国特色社会主义思想概论	5
6	西南财经大学	经济学	马克思主义基本原理	3
7	西南财经大学	经济学	大学生职业生涯规划与创业基础	2
8	西南财经大学	经济学	军事理论	2
9	西南财经大学	经济学	国家安全教育	2
10	西南财经大学	经济学	大学生心理健康与人生发展	2
11	西南财经大学	经济学	综合英语III	1
12	西南财经大学	经济学	听说写能力训练	1-6
13	西南财经大学	经济学	高等数学I	1
14	西南财经大学	经济学	高等数学II	2
15	西南财经大学	经济学	线性代数	2
16	西南财经大学	经济学	概率论与数理统计B	3
17	西南财经大学	经济学	人工智能与现代科技	2
18	西南财经大学	经济学	微观经济学	1
19	西南财经大学	经济学	宏观经济学	2
20	西南财经大学	经济学	计量经济学	4
21	西南财经大学	经济学	马克思主义政治经济学	1
22	西南财经大学	经济学	中国特色社会主义政治经济学	2
23	西南财经大学	经济学	货币金融学	3
24	西南财经大学	经济学	数字经济学	3
25	西南财经大学	经济学	经济思想史	3
26	西南财经大学	经济学	财政学	3
27	西南财经大学	经济学	中国经济史	4
28	西南财经大学	经济学	高阶经济数学	4
29	西南财经大学	经济学	《资本论》选读	5
30	西南财经大学	经济学	高级微观经济学	5
31	西南财经大学	经济学	高级宏观经济学	5
32	西南财经大学	经济学	高级政治经济学	5
33	西南财经大学	经济学	经济学的数据分析方法	5
34	西南财经大学	经济学	中国发展经济学	6
35	西南财经大学	经济学	博弈论与信息经济学	5
36	西南财经大学	经济学	中国产业经济学	6
37	西南财经大学	经济学	资源与环境经济学	6
38	西南财经大学	经济学	新制度经济学	6
39	西南财经大学	经济学	经济学研究方法与论文写作	6
40	西南财经大学	经济学	经济学学科前沿动态	5
41	西南财经大学	经济学	当代中国经济问题分析	6
42	西南财经大学	经济学	国家级项目专题研读	6
43	西南财经大学	经济学	劳动教育	1-8
44	西南财经大学	经济学	名著阅读	1-8
45	西南财经大学	经济学	创新、创业与社会	1-8
46	上海财经大学	经济学（世界经济方向）	政治经济学Ⅰ	1
47	上海财经大学	经济学（世界经济方向）	政治经济学Ⅱ	2
48	上海财经大学	经济学（世界经济方向）	经济思想史	4
49	上海财经大学	经济学（世界经济方向）	经济史	5
50	上海财经大学	经济学（世界经济方向）	数学分析Ⅰ	1
51	上海财经大学	经济学（世界经济方向）	数学分析Ⅱ	2
52	上海财经大学	经济学（世界经济方向）	数学分析Ⅲ	3
53	上海财经大学	经济学（世界经济方向）	线性代数	2
54	上海财经大学	经济学（世界经济方向）	概率论与数理统计	3
55	上海财经大学	经济学（世界经济方向）	计量经济学	4
56	上海财经大学	经济学（世界经济方向）	经济学原理	1
57	上海财经大学	经济学（世界经济方向）	中级微观经济学	3
58	上海财经大学	经济学（世界经济方向）	中级宏观经济学	4
59	上海财经大学	经济学（世界经济方向）	高级微观经济学	5
60	上海财经大学	经济学（世界经济方向）	国际经济学	4
61	上海财经大学	经济学（世界经济方向）	世界经济概论	4
62	上海财经大学	经济学（世界经济方向）	国际商务	5
63	上海财经大学	经济学（世界经济方向）	跨国公司与直接投资	5
64	上海财经大学	经济学（世界经济方向）	国别与地区经济	6
65	上海财经大学	经济学（世界经济方向）	财政学	3
66	上海财经大学	经济学（世界经济方向）	货币银行学	4
67	上海财经大学	经济学（世界经济方向）	会计学	3
68	上海财经大学	经济学（世界经济方向）	经济法概论	3
\.


--
-- Data for Name: university; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university (id, name) FROM stdin;
2	上海财经大学
3	西南财经大学
\.


--
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_id_seq', 119, true);


--
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_seq', 3, true);


--
-- Name: major_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.major_id_seq', 3, true);


--
-- Name: raw_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.raw_course_id_seq', 73, true);


--
-- Name: raw_major_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.raw_major_course_id_seq', 68, true);


--
-- Name: raw_major_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.raw_major_id_seq', 2, true);


--
-- Name: university_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_id_seq', 3, true);


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: major_course major_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major_course
    ADD CONSTRAINT major_course_pkey PRIMARY KEY (major_id, course_id);


--
-- Name: major major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_pkey PRIMARY KEY (id);


--
-- Name: raw_course raw_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_course
    ADD CONSTRAINT raw_course_pkey PRIMARY KEY (id);


--
-- Name: raw_major_course raw_major_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_major_course
    ADD CONSTRAINT raw_major_course_pkey PRIMARY KEY (id);


--
-- Name: raw_major raw_major_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_major
    ADD CONSTRAINT raw_major_pkey PRIMARY KEY (id);


--
-- Name: university university_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_name_key UNIQUE (name);


--
-- Name: university university_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_pkey PRIMARY KEY (id);


--
-- Name: course course_uni_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_uni_id_fkey FOREIGN KEY (uni_id) REFERENCES public.university(id);


--
-- Name: department department_uni_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_uni_id_fkey FOREIGN KEY (uni_id) REFERENCES public.university(id);


--
-- Name: major_course major_course_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major_course
    ADD CONSTRAINT major_course_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(id);


--
-- Name: major_course major_course_major_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major_course
    ADD CONSTRAINT major_course_major_id_fkey FOREIGN KEY (major_id) REFERENCES public.major(id);


--
-- Name: major major_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.major
    ADD CONSTRAINT major_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.department(id);


--
-- PostgreSQL database dump complete
--

\unrestrict CQIcX3Knlan4QzaUtQIRWRKcmcOcYLsiF80RyRfW3IYcPBPqmlYkLERbmKbJqz1

