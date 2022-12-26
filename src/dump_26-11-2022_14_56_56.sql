--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE pavshop_db;




--
-- Drop roles
--

DROP ROLE pavshop;


--
-- Roles
--

CREATE ROLE pavshop;
ALTER ROLE pavshop WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5c427211e73b075eb22179fc377ea987d';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7
-- Dumped by pg_dump version 13.7

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: pavshop
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO pavshop;

\connect template1

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

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: pavshop
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: pavshop
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: pavshop
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "pavshop_db" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7
-- Dumped by pg_dump version 13.7

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

--
-- Name: pavshop_db; Type: DATABASE; Schema: -; Owner: pavshop
--

CREATE DATABASE pavshop_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE pavshop_db OWNER TO pavshop;

\connect pavshop_db

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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO pavshop;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO pavshop;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO pavshop;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO pavshop;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO pavshop;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO pavshop;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: blog_blog; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.blog_blog (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255),
    text text NOT NULL,
    image character varying(100),
    read_count integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    author_id bigint,
    category_id bigint NOT NULL,
    brief_info character varying(200)
);


ALTER TABLE public.blog_blog OWNER TO pavshop;

--
-- Name: blog_blog_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.blog_blog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_blog_id_seq OWNER TO pavshop;

--
-- Name: blog_blog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.blog_blog_id_seq OWNED BY public.blog_blog.id;


--
-- Name: blog_blogtag; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.blog_blogtag (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    blog_id bigint NOT NULL,
    tag_name_id bigint NOT NULL
);


ALTER TABLE public.blog_blogtag OWNER TO pavshop;

--
-- Name: blog_blogtag_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.blog_blogtag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_blogtag_id_seq OWNER TO pavshop;

--
-- Name: blog_blogtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.blog_blogtag_id_seq OWNED BY public.blog_blogtag.id;


--
-- Name: blog_comment; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.blog_comment (
    id bigint NOT NULL,
    name character varying(128),
    email character varying(254),
    subject character varying(255) NOT NULL,
    comment_text text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    author_id bigint,
    comment_id bigint,
    parent_id bigint
);


ALTER TABLE public.blog_comment OWNER TO pavshop;

--
-- Name: blog_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.blog_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_comment_id_seq OWNER TO pavshop;

--
-- Name: blog_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.blog_comment_id_seq OWNED BY public.blog_comment.id;


--
-- Name: blog_tag; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.blog_tag (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    usage_count integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.blog_tag OWNER TO pavshop;

--
-- Name: blog_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.blog_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_tag_id_seq OWNER TO pavshop;

--
-- Name: blog_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.blog_tag_id_seq OWNED BY public.blog_tag.id;


--
-- Name: cart_cart; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.cart_cart (
    id bigint NOT NULL,
    date_added timestamp with time zone,
    complete boolean NOT NULL,
    transaction_id character varying(100),
    user_id bigint NOT NULL,
    discount_percent double precision NOT NULL
);


ALTER TABLE public.cart_cart OWNER TO pavshop;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.cart_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_cart_id_seq OWNER TO pavshop;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.cart_cart_id_seq OWNED BY public.cart_cart.id;


--
-- Name: cart_cartitem; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.cart_cartitem (
    id bigint NOT NULL,
    quantity integer,
    color character varying(128),
    date_added timestamp with time zone,
    cart_id bigint,
    product_id bigint NOT NULL,
    user_id bigint
);


ALTER TABLE public.cart_cartitem OWNER TO pavshop;

--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.cart_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_cartitem_id_seq OWNER TO pavshop;

--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.cart_cartitem_id_seq OWNED BY public.cart_cartitem.id;


--
-- Name: cart_discount; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.cart_discount (
    id bigint NOT NULL,
    discount_code character varying(128),
    discount_percent integer NOT NULL,
    lifetime integer,
    expiry_date timestamp with time zone NOT NULL,
    created_date timestamp with time zone
);


ALTER TABLE public.cart_discount OWNER TO pavshop;

--
-- Name: cart_discount_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.cart_discount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_discount_id_seq OWNER TO pavshop;

--
-- Name: cart_discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.cart_discount_id_seq OWNED BY public.cart_discount.id;


--
-- Name: cart_discount_user; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.cart_discount_user (
    id bigint NOT NULL,
    discount_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.cart_discount_user OWNER TO pavshop;

--
-- Name: cart_discount_user_id_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.cart_discount_user_id_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_discount_user_id_id_seq OWNER TO pavshop;

--
-- Name: cart_discount_user_id_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.cart_discount_user_id_id_seq OWNED BY public.cart_discount_user.id;


--
-- Name: cart_whislist; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.cart_whislist (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_liked boolean NOT NULL
);


ALTER TABLE public.cart_whislist OWNER TO pavshop;

--
-- Name: cart_whislist_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.cart_whislist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_whislist_id_seq OWNER TO pavshop;

--
-- Name: cart_whislist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.cart_whislist_id_seq OWNED BY public.cart_whislist.id;


--
-- Name: core_about; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_about (
    id bigint NOT NULL,
    main_image character varying(100) NOT NULL,
    about_header_text text NOT NULL,
    about_footer_text text NOT NULL
);


ALTER TABLE public.core_about OWNER TO pavshop;

--
-- Name: core_about_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_about_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_about_id_seq OWNER TO pavshop;

--
-- Name: core_about_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_about_id_seq OWNED BY public.core_about.id;


--
-- Name: core_awesomeculture; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_awesomeculture (
    id bigint NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE public.core_awesomeculture OWNER TO pavshop;

--
-- Name: core_awesomeculture_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_awesomeculture_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_awesomeculture_id_seq OWNER TO pavshop;

--
-- Name: core_awesomeculture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_awesomeculture_id_seq OWNED BY public.core_awesomeculture.id;


--
-- Name: core_background; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_background (
    id bigint NOT NULL,
    home_page character varying(100) NOT NULL,
    about_page character varying(100) NOT NULL,
    contact_page character varying(100) NOT NULL,
    product_page character varying(100) NOT NULL,
    order_page character varying(100) NOT NULL,
    login_register_page character varying(100) NOT NULL,
    cart_page character varying(100) NOT NULL
);


ALTER TABLE public.core_background OWNER TO pavshop;

--
-- Name: core_background_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_background_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_background_id_seq OWNER TO pavshop;

--
-- Name: core_background_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_background_id_seq OWNED BY public.core_background.id;


--
-- Name: core_contact; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_contact (
    id bigint NOT NULL,
    full_name character varying(128),
    email character varying(128),
    phone character varying(10),
    subject character varying(255),
    message text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.core_contact OWNER TO pavshop;

--
-- Name: core_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_contact_id_seq OWNER TO pavshop;

--
-- Name: core_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_contact_id_seq OWNED BY public.core_contact.id;


--
-- Name: core_feedback; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_feedback (
    id bigint NOT NULL,
    text text,
    author character varying(200),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.core_feedback OWNER TO pavshop;

--
-- Name: core_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_feedback_id_seq OWNER TO pavshop;

--
-- Name: core_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_feedback_id_seq OWNED BY public.core_feedback.id;


--
-- Name: core_slider; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_slider (
    id bigint NOT NULL,
    title character varying(255),
    description character varying(300),
    price double precision NOT NULL,
    product_link character varying(255),
    image character varying(100)
);


ALTER TABLE public.core_slider OWNER TO pavshop;

--
-- Name: core_slider_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_slider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_slider_id_seq OWNER TO pavshop;

--
-- Name: core_slider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_slider_id_seq OWNED BY public.core_slider.id;


--
-- Name: core_sponsor; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_sponsor (
    id bigint NOT NULL,
    image character varying(100) NOT NULL
);


ALTER TABLE public.core_sponsor OWNER TO pavshop;

--
-- Name: core_sponsor_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_sponsor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_sponsor_id_seq OWNER TO pavshop;

--
-- Name: core_sponsor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_sponsor_id_seq OWNED BY public.core_sponsor.id;


--
-- Name: core_staff; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_staff (
    id bigint NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    image character varying(100),
    "position" character varying(255) NOT NULL,
    description text,
    facebook_url character varying(255),
    twitter_url character varying(255),
    website_url character varying(255)
);


ALTER TABLE public.core_staff OWNER TO pavshop;

--
-- Name: core_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_staff_id_seq OWNER TO pavshop;

--
-- Name: core_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_staff_id_seq OWNED BY public.core_staff.id;


--
-- Name: core_subscription; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.core_subscription (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    subscription_email character varying(128)
);


ALTER TABLE public.core_subscription OWNER TO pavshop;

--
-- Name: core_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.core_subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_subscription_id_seq OWNER TO pavshop;

--
-- Name: core_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.core_subscription_id_seq OWNED BY public.core_subscription.id;


--
-- Name: dashboard_userdashboardmodule; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.dashboard_userdashboardmodule (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    module character varying(255) NOT NULL,
    app_label character varying(255),
    user_id bigint,
    "column" integer NOT NULL,
    "order" integer NOT NULL,
    settings text NOT NULL,
    children text NOT NULL,
    collapsed boolean NOT NULL,
    CONSTRAINT dashboard_userdashboardmodule_column_check CHECK (("column" >= 0))
);


ALTER TABLE public.dashboard_userdashboardmodule OWNER TO pavshop;

--
-- Name: dashboard_userdashboardmodule_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.dashboard_userdashboardmodule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dashboard_userdashboardmodule_id_seq OWNER TO pavshop;

--
-- Name: dashboard_userdashboardmodule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.dashboard_userdashboardmodule_id_seq OWNED BY public.dashboard_userdashboardmodule.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO pavshop;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO pavshop;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_celery_beat_clockedschedule; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_celery_beat_clockedschedule (
    id integer NOT NULL,
    clocked_time timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_clockedschedule OWNER TO pavshop;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_celery_beat_clockedschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_clockedschedule_id_seq OWNER TO pavshop;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_celery_beat_clockedschedule_id_seq OWNED BY public.django_celery_beat_clockedschedule.id;


--
-- Name: django_celery_beat_crontabschedule; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_celery_beat_crontabschedule (
    id integer NOT NULL,
    minute character varying(240) NOT NULL,
    hour character varying(96) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(124) NOT NULL,
    month_of_year character varying(64) NOT NULL,
    timezone character varying(63) NOT NULL
);


ALTER TABLE public.django_celery_beat_crontabschedule OWNER TO pavshop;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_celery_beat_crontabschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_crontabschedule_id_seq OWNER TO pavshop;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_celery_beat_crontabschedule_id_seq OWNED BY public.django_celery_beat_crontabschedule.id;


--
-- Name: django_celery_beat_intervalschedule; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_celery_beat_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE public.django_celery_beat_intervalschedule OWNER TO pavshop;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_celery_beat_intervalschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_intervalschedule_id_seq OWNER TO pavshop;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_celery_beat_intervalschedule_id_seq OWNED BY public.django_celery_beat_intervalschedule.id;


--
-- Name: django_celery_beat_periodictask; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_celery_beat_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    solar_id integer,
    one_off boolean NOT NULL,
    start_time timestamp with time zone,
    priority integer,
    headers text NOT NULL,
    clocked_id integer,
    expire_seconds integer,
    CONSTRAINT django_celery_beat_periodictask_expire_seconds_check CHECK ((expire_seconds >= 0)),
    CONSTRAINT django_celery_beat_periodictask_priority_check CHECK ((priority >= 0)),
    CONSTRAINT django_celery_beat_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.django_celery_beat_periodictask OWNER TO pavshop;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_celery_beat_periodictask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_periodictask_id_seq OWNER TO pavshop;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_celery_beat_periodictask_id_seq OWNED BY public.django_celery_beat_periodictask.id;


--
-- Name: django_celery_beat_periodictasks; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_celery_beat_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_periodictasks OWNER TO pavshop;

--
-- Name: django_celery_beat_solarschedule; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_celery_beat_solarschedule (
    id integer NOT NULL,
    event character varying(24) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE public.django_celery_beat_solarschedule OWNER TO pavshop;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_celery_beat_solarschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_solarschedule_id_seq OWNER TO pavshop;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_celery_beat_solarschedule_id_seq OWNED BY public.django_celery_beat_solarschedule.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO pavshop;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO pavshop;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO pavshop;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO pavshop;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO pavshop;

--
-- Name: jet_bookmark; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.jet_bookmark (
    id bigint NOT NULL,
    url character varying(200) NOT NULL,
    title character varying(255) NOT NULL,
    user_id bigint,
    date_add timestamp with time zone NOT NULL
);


ALTER TABLE public.jet_bookmark OWNER TO pavshop;

--
-- Name: jet_bookmark_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.jet_bookmark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jet_bookmark_id_seq OWNER TO pavshop;

--
-- Name: jet_bookmark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.jet_bookmark_id_seq OWNED BY public.jet_bookmark.id;


--
-- Name: jet_pinnedapplication; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.jet_pinnedapplication (
    id bigint NOT NULL,
    app_label character varying(255) NOT NULL,
    user_id bigint,
    date_add timestamp with time zone NOT NULL
);


ALTER TABLE public.jet_pinnedapplication OWNER TO pavshop;

--
-- Name: jet_pinnedapplication_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.jet_pinnedapplication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jet_pinnedapplication_id_seq OWNER TO pavshop;

--
-- Name: jet_pinnedapplication_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.jet_pinnedapplication_id_seq OWNED BY public.jet_pinnedapplication.id;


--
-- Name: knox_authtoken; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.knox_authtoken (
    digest character varying(128) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id bigint NOT NULL,
    expiry timestamp with time zone,
    token_key character varying(8) NOT NULL
);


ALTER TABLE public.knox_authtoken OWNER TO pavshop;

--
-- Name: order_billing; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.order_billing (
    id bigint NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    address character varying(200) NOT NULL,
    phone character varying(15) NOT NULL,
    user_id bigint
);


ALTER TABLE public.order_billing OWNER TO pavshop;

--
-- Name: order_billing_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.order_billing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_billing_id_seq OWNER TO pavshop;

--
-- Name: order_billing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.order_billing_id_seq OWNED BY public.order_billing.id;


--
-- Name: order_order; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.order_order (
    id bigint NOT NULL,
    order_number uuid NOT NULL,
    transaction_id character varying(128),
    ship_date timestamp with time zone NOT NULL,
    order_date timestamp with time zone NOT NULL,
    shipping_price double precision,
    delivery_date timestamp with time zone,
    billing_info_id bigint,
    payment_id bigint,
    shipping_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.order_order OWNER TO pavshop;

--
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_order_id_seq OWNER TO pavshop;

--
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.order_order_id_seq OWNED BY public.order_order.id;


--
-- Name: order_orderitem; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.order_orderitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    color character varying(128),
    complete boolean NOT NULL,
    cart_id bigint NOT NULL,
    order_id bigint,
    product_id bigint NOT NULL,
    user_id bigint NOT NULL,
    total double precision NOT NULL,
    subtotal double precision NOT NULL
);


ALTER TABLE public.order_orderitem OWNER TO pavshop;

--
-- Name: order_orderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.order_orderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_orderitem_id_seq OWNER TO pavshop;

--
-- Name: order_orderitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.order_orderitem_id_seq OWNED BY public.order_orderitem.id;


--
-- Name: order_payment; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.order_payment (
    id bigint NOT NULL,
    is_paid boolean NOT NULL,
    payment_date timestamp with time zone,
    payment_type character varying(30) NOT NULL,
    is_allowed boolean NOT NULL
);


ALTER TABLE public.order_payment OWNER TO pavshop;

--
-- Name: order_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.order_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_payment_id_seq OWNER TO pavshop;

--
-- Name: order_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.order_payment_id_seq OWNED BY public.order_payment.id;


--
-- Name: order_shipping; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.order_shipping (
    id bigint NOT NULL,
    address text NOT NULL,
    country character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    region character varying(255),
    zipcode integer,
    phone character varying(15) NOT NULL,
    company_name character varying(128),
    user_id bigint NOT NULL
);


ALTER TABLE public.order_shipping OWNER TO pavshop;

--
-- Name: order_shipping_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.order_shipping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_shipping_id_seq OWNER TO pavshop;

--
-- Name: order_shipping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.order_shipping_id_seq OWNED BY public.order_shipping.id;


--
-- Name: product_brand; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_brand (
    id bigint NOT NULL,
    name character varying(60) NOT NULL,
    name_az character varying(60),
    name_en character varying(60),
    name_ru character varying(60)
);


ALTER TABLE public.product_brand OWNER TO pavshop;

--
-- Name: product_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_brand_id_seq OWNER TO pavshop;

--
-- Name: product_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_brand_id_seq OWNED BY public.product_brand.id;


--
-- Name: product_category; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_category (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    name_az character varying(30),
    name_en character varying(30),
    name_ru character varying(30),
    category_image character varying(100)
);


ALTER TABLE public.product_category OWNER TO pavshop;

--
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_category_id_seq OWNER TO pavshop;

--
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
-- Name: product_color; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_color (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    name_az character varying(30),
    name_en character varying(30),
    name_ru character varying(30),
    color character varying(18) NOT NULL
);


ALTER TABLE public.product_color OWNER TO pavshop;

--
-- Name: product_color_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_color_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_color_id_seq OWNER TO pavshop;

--
-- Name: product_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_color_id_seq OWNED BY public.product_color.id;


--
-- Name: product_designer; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_designer (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    name_az character varying(255),
    name_en character varying(255),
    name_ru character varying(255)
);


ALTER TABLE public.product_designer OWNER TO pavshop;

--
-- Name: product_designer_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_designer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_designer_id_seq OWNER TO pavshop;

--
-- Name: product_designer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_designer_id_seq OWNED BY public.product_designer.id;


--
-- Name: product_image; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_image (
    id bigint NOT NULL,
    image character varying(100),
    is_main boolean NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.product_image OWNER TO pavshop;

--
-- Name: product_image_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_image_id_seq OWNER TO pavshop;

--
-- Name: product_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_image_id_seq OWNED BY public.product_image.id;


--
-- Name: product_product; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_product (
    id bigint NOT NULL,
    product_name character varying(60) NOT NULL,
    product_name_az character varying(60),
    product_name_en character varying(60),
    product_name_ru character varying(60),
    main_image character varying(100),
    brief_info character varying(255) NOT NULL,
    brief_info_az character varying(255),
    brief_info_en character varying(255),
    brief_info_ru character varying(255),
    price double precision NOT NULL,
    like_status boolean,
    discount_status boolean,
    discount_percent integer,
    product_detail text NOT NULL,
    product_detail_az text,
    product_detail_en text,
    product_detail_ru text,
    delivery_info text NOT NULL,
    delivery_info_az text,
    delivery_info_en text,
    delivery_info_ru text,
    product_description text NOT NULL,
    product_description_az text,
    product_description_en text,
    product_description_ru text,
    product_info text NOT NULL,
    product_info_az text,
    product_info_en text,
    product_info_ru text,
    availability boolean,
    slug character varying(255) NOT NULL,
    order_count integer NOT NULL,
    hit_count integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    brand_id bigint NOT NULL,
    category_id bigint,
    designer_id bigint NOT NULL,
    CONSTRAINT "discount percent constraints" CHECK (((discount_percent >= 0) AND (discount_percent <= 100))),
    CONSTRAINT "price constraints" CHECK ((price >= (0.0)::double precision))
);


ALTER TABLE public.product_product OWNER TO pavshop;

--
-- Name: product_product_color; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_product_color (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    color_id bigint NOT NULL
);


ALTER TABLE public.product_product_color OWNER TO pavshop;

--
-- Name: product_product_color_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_product_color_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_product_color_id_seq OWNER TO pavshop;

--
-- Name: product_product_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_product_color_id_seq OWNED BY public.product_product_color.id;


--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_product_id_seq OWNER TO pavshop;

--
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product_product.id;


--
-- Name: product_producttag; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_producttag (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    product_id bigint NOT NULL,
    tag_name_id bigint NOT NULL
);


ALTER TABLE public.product_producttag OWNER TO pavshop;

--
-- Name: product_producttag_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_producttag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_producttag_id_seq OWNER TO pavshop;

--
-- Name: product_producttag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_producttag_id_seq OWNED BY public.product_producttag.id;


--
-- Name: product_review; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_review (
    id bigint NOT NULL,
    name character varying(128),
    email character varying(254),
    review_text text,
    rating integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    product_id bigint
);


ALTER TABLE public.product_review OWNER TO pavshop;

--
-- Name: product_review_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_review_id_seq OWNER TO pavshop;

--
-- Name: product_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_review_id_seq OWNED BY public.product_review.id;


--
-- Name: product_variation; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.product_variation (
    id bigint NOT NULL,
    variation_category character varying(100) NOT NULL,
    variation_value character varying(100) NOT NULL,
    is_active boolean NOT NULL,
    created_date date NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.product_variation OWNER TO pavshop;

--
-- Name: product_variation_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.product_variation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_variation_id_seq OWNER TO pavshop;

--
-- Name: product_variation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.product_variation_id_seq OWNED BY public.product_variation.id;


--
-- Name: social_auth_association; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.social_auth_association (
    id integer NOT NULL,
    server_url character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    issued integer NOT NULL,
    lifetime integer NOT NULL,
    assoc_type character varying(64) NOT NULL
);


ALTER TABLE public.social_auth_association OWNER TO pavshop;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.social_auth_association_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_association_id_seq OWNER TO pavshop;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.social_auth_association_id_seq OWNED BY public.social_auth_association.id;


--
-- Name: social_auth_code; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.social_auth_code (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    code character varying(32) NOT NULL,
    verified boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.social_auth_code OWNER TO pavshop;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.social_auth_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_code_id_seq OWNER TO pavshop;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.social_auth_code_id_seq OWNED BY public.social_auth_code.id;


--
-- Name: social_auth_nonce; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.social_auth_nonce (
    id integer NOT NULL,
    server_url character varying(255) NOT NULL,
    "timestamp" integer NOT NULL,
    salt character varying(65) NOT NULL
);


ALTER TABLE public.social_auth_nonce OWNER TO pavshop;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.social_auth_nonce_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_nonce_id_seq OWNER TO pavshop;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.social_auth_nonce_id_seq OWNED BY public.social_auth_nonce.id;


--
-- Name: social_auth_partial; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.social_auth_partial (
    id integer NOT NULL,
    token character varying(32) NOT NULL,
    next_step smallint NOT NULL,
    backend character varying(32) NOT NULL,
    data text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT social_auth_partial_next_step_check CHECK ((next_step >= 0))
);


ALTER TABLE public.social_auth_partial OWNER TO pavshop;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.social_auth_partial_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_partial_id_seq OWNER TO pavshop;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.social_auth_partial_id_seq OWNED BY public.social_auth_partial.id;


--
-- Name: social_auth_usersocialauth; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.social_auth_usersocialauth (
    id integer NOT NULL,
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    extra_data text NOT NULL,
    user_id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE public.social_auth_usersocialauth OWNER TO pavshop;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.social_auth_usersocialauth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_usersocialauth_id_seq OWNER TO pavshop;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.social_auth_usersocialauth_id_seq OWNED BY public.social_auth_usersocialauth.id;


--
-- Name: users_phoneprefix; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.users_phoneprefix (
    id bigint NOT NULL,
    prefix character varying(10) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.users_phoneprefix OWNER TO pavshop;

--
-- Name: users_phoneprefix_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.users_phoneprefix_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_phoneprefix_id_seq OWNER TO pavshop;

--
-- Name: users_phoneprefix_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.users_phoneprefix_id_seq OWNED BY public.users_phoneprefix.id;


--
-- Name: users_user; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.users_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    is_superuser boolean NOT NULL,
    is_active boolean NOT NULL,
    username character varying(150),
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    address text,
    country character varying(10) NOT NULL,
    city character varying(128),
    email character varying(255) NOT NULL,
    gender character varying(50),
    phone character varying(50),
    zip_code integer,
    is_staff boolean NOT NULL,
    birth_date date,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone,
    phone_prefix_id bigint,
    profile_image character varying(100)
);


ALTER TABLE public.users_user OWNER TO pavshop;

--
-- Name: users_user_groups; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.users_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_user_groups OWNER TO pavshop;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.users_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_groups_id_seq OWNER TO pavshop;

--
-- Name: users_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.users_user_groups_id_seq OWNED BY public.users_user_groups.id;


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO pavshop;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users_user.id;


--
-- Name: users_user_user_permissions; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.users_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.users_user_user_permissions OWNER TO pavshop;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.users_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_user_permissions_id_seq OWNER TO pavshop;

--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.users_user_user_permissions_id_seq OWNED BY public.users_user_user_permissions.id;


--
-- Name: users_usernotification; Type: TABLE; Schema: public; Owner: pavshop
--

CREATE TABLE public.users_usernotification (
    id bigint NOT NULL,
    mail_sent boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.users_usernotification OWNER TO pavshop;

--
-- Name: users_usernotification_id_seq; Type: SEQUENCE; Schema: public; Owner: pavshop
--

CREATE SEQUENCE public.users_usernotification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_usernotification_id_seq OWNER TO pavshop;

--
-- Name: users_usernotification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pavshop
--

ALTER SEQUENCE public.users_usernotification_id_seq OWNED BY public.users_usernotification.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: blog_blog id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blog ALTER COLUMN id SET DEFAULT nextval('public.blog_blog_id_seq'::regclass);


--
-- Name: blog_blogtag id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blogtag ALTER COLUMN id SET DEFAULT nextval('public.blog_blogtag_id_seq'::regclass);


--
-- Name: blog_comment id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_comment ALTER COLUMN id SET DEFAULT nextval('public.blog_comment_id_seq'::regclass);


--
-- Name: blog_tag id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_tag ALTER COLUMN id SET DEFAULT nextval('public.blog_tag_id_seq'::regclass);


--
-- Name: cart_cart id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cart ALTER COLUMN id SET DEFAULT nextval('public.cart_cart_id_seq'::regclass);


--
-- Name: cart_cartitem id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cartitem ALTER COLUMN id SET DEFAULT nextval('public.cart_cartitem_id_seq'::regclass);


--
-- Name: cart_discount id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_discount ALTER COLUMN id SET DEFAULT nextval('public.cart_discount_id_seq'::regclass);


--
-- Name: cart_discount_user id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_discount_user ALTER COLUMN id SET DEFAULT nextval('public.cart_discount_user_id_id_seq'::regclass);


--
-- Name: cart_whislist id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_whislist ALTER COLUMN id SET DEFAULT nextval('public.cart_whislist_id_seq'::regclass);


--
-- Name: core_about id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_about ALTER COLUMN id SET DEFAULT nextval('public.core_about_id_seq'::regclass);


--
-- Name: core_awesomeculture id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_awesomeculture ALTER COLUMN id SET DEFAULT nextval('public.core_awesomeculture_id_seq'::regclass);


--
-- Name: core_background id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_background ALTER COLUMN id SET DEFAULT nextval('public.core_background_id_seq'::regclass);


--
-- Name: core_contact id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_contact ALTER COLUMN id SET DEFAULT nextval('public.core_contact_id_seq'::regclass);


--
-- Name: core_feedback id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_feedback ALTER COLUMN id SET DEFAULT nextval('public.core_feedback_id_seq'::regclass);


--
-- Name: core_slider id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_slider ALTER COLUMN id SET DEFAULT nextval('public.core_slider_id_seq'::regclass);


--
-- Name: core_sponsor id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_sponsor ALTER COLUMN id SET DEFAULT nextval('public.core_sponsor_id_seq'::regclass);


--
-- Name: core_staff id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_staff ALTER COLUMN id SET DEFAULT nextval('public.core_staff_id_seq'::regclass);


--
-- Name: core_subscription id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_subscription ALTER COLUMN id SET DEFAULT nextval('public.core_subscription_id_seq'::regclass);


--
-- Name: dashboard_userdashboardmodule id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.dashboard_userdashboardmodule ALTER COLUMN id SET DEFAULT nextval('public.dashboard_userdashboardmodule_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_celery_beat_clockedschedule id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_clockedschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_crontabschedule id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_crontabschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_intervalschedule id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_intervalschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_periodictask id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictask ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_periodictask_id_seq'::regclass);


--
-- Name: django_celery_beat_solarschedule id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_solarschedule_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: jet_bookmark id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.jet_bookmark ALTER COLUMN id SET DEFAULT nextval('public.jet_bookmark_id_seq'::regclass);


--
-- Name: jet_pinnedapplication id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.jet_pinnedapplication ALTER COLUMN id SET DEFAULT nextval('public.jet_pinnedapplication_id_seq'::regclass);


--
-- Name: order_billing id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_billing ALTER COLUMN id SET DEFAULT nextval('public.order_billing_id_seq'::regclass);


--
-- Name: order_order id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_order ALTER COLUMN id SET DEFAULT nextval('public.order_order_id_seq'::regclass);


--
-- Name: order_orderitem id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_orderitem ALTER COLUMN id SET DEFAULT nextval('public.order_orderitem_id_seq'::regclass);


--
-- Name: order_payment id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_payment ALTER COLUMN id SET DEFAULT nextval('public.order_payment_id_seq'::regclass);


--
-- Name: order_shipping id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_shipping ALTER COLUMN id SET DEFAULT nextval('public.order_shipping_id_seq'::regclass);


--
-- Name: product_brand id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_brand ALTER COLUMN id SET DEFAULT nextval('public.product_brand_id_seq'::regclass);


--
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- Name: product_color id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_color ALTER COLUMN id SET DEFAULT nextval('public.product_color_id_seq'::regclass);


--
-- Name: product_designer id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_designer ALTER COLUMN id SET DEFAULT nextval('public.product_designer_id_seq'::regclass);


--
-- Name: product_image id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_image ALTER COLUMN id SET DEFAULT nextval('public.product_image_id_seq'::regclass);


--
-- Name: product_product id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product ALTER COLUMN id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- Name: product_product_color id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product_color ALTER COLUMN id SET DEFAULT nextval('public.product_product_color_id_seq'::regclass);


--
-- Name: product_producttag id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_producttag ALTER COLUMN id SET DEFAULT nextval('public.product_producttag_id_seq'::regclass);


--
-- Name: product_review id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_review ALTER COLUMN id SET DEFAULT nextval('public.product_review_id_seq'::regclass);


--
-- Name: product_variation id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_variation ALTER COLUMN id SET DEFAULT nextval('public.product_variation_id_seq'::regclass);


--
-- Name: social_auth_association id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_association ALTER COLUMN id SET DEFAULT nextval('public.social_auth_association_id_seq'::regclass);


--
-- Name: social_auth_code id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_code ALTER COLUMN id SET DEFAULT nextval('public.social_auth_code_id_seq'::regclass);


--
-- Name: social_auth_nonce id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_nonce ALTER COLUMN id SET DEFAULT nextval('public.social_auth_nonce_id_seq'::regclass);


--
-- Name: social_auth_partial id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_partial ALTER COLUMN id SET DEFAULT nextval('public.social_auth_partial_id_seq'::regclass);


--
-- Name: social_auth_usersocialauth id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_usersocialauth ALTER COLUMN id SET DEFAULT nextval('public.social_auth_usersocialauth_id_seq'::regclass);


--
-- Name: users_phoneprefix id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_phoneprefix ALTER COLUMN id SET DEFAULT nextval('public.users_phoneprefix_id_seq'::regclass);


--
-- Name: users_user id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user ALTER COLUMN id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: users_user_groups id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_groups ALTER COLUMN id SET DEFAULT nextval('public.users_user_groups_id_seq'::regclass);


--
-- Name: users_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.users_user_user_permissions_id_seq'::regclass);


--
-- Name: users_usernotification id; Type: DEFAULT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_usernotification ALTER COLUMN id SET DEFAULT nextval('public.users_usernotification_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add phone prefix	7	add_phoneprefix
26	Can change phone prefix	7	change_phoneprefix
27	Can delete phone prefix	7	delete_phoneprefix
28	Can view phone prefix	7	view_phoneprefix
29	Can add user notification	8	add_usernotification
30	Can change user notification	8	change_usernotification
31	Can delete user notification	8	delete_usernotification
32	Can view user notification	8	view_usernotification
33	Can add blogger	9	add_blogger
34	Can change blogger	9	change_blogger
35	Can delete blogger	9	delete_blogger
36	Can view blogger	9	view_blogger
37	Can add my user	10	add_myuser
38	Can change my user	10	change_myuser
39	Can delete my user	10	delete_myuser
40	Can view my user	10	view_myuser
41	Can add blog	11	add_blog
42	Can change blog	11	change_blog
43	Can delete blog	11	delete_blog
44	Can view blog	11	view_blog
45	Can add tag	12	add_tag
46	Can change tag	12	change_tag
47	Can delete tag	12	delete_tag
48	Can view tag	12	view_tag
49	Can add comment	13	add_comment
50	Can change comment	13	change_comment
51	Can delete comment	13	delete_comment
52	Can view comment	13	view_comment
53	Can add blog tag	14	add_blogtag
54	Can change blog tag	14	change_blogtag
55	Can delete blog tag	14	delete_blogtag
56	Can view blog tag	14	view_blogtag
57	Can add billing	15	add_billing
58	Can change billing	15	change_billing
59	Can delete billing	15	delete_billing
60	Can view billing	15	view_billing
61	Can add order	16	add_order
62	Can change order	16	change_order
63	Can delete order	16	delete_order
64	Can view order	16	view_order
65	Can add payment	17	add_payment
66	Can change payment	17	change_payment
67	Can delete payment	17	delete_payment
68	Can view payment	17	view_payment
69	Can add shipping	18	add_shipping
70	Can change shipping	18	change_shipping
71	Can delete shipping	18	delete_shipping
72	Can view shipping	18	view_shipping
73	Can add order item	19	add_orderitem
74	Can change order item	19	change_orderitem
75	Can delete order item	19	delete_orderitem
76	Can view order item	19	view_orderitem
77	Can add brand	20	add_brand
78	Can change brand	20	change_brand
79	Can delete brand	20	delete_brand
80	Can view brand	20	view_brand
81	Can add category	21	add_category
82	Can change category	21	change_category
83	Can delete category	21	delete_category
84	Can view category	21	view_category
85	Can add color	22	add_color
86	Can change color	22	change_color
87	Can delete color	22	delete_color
88	Can view color	22	view_color
89	Can add designer	23	add_designer
90	Can change designer	23	change_designer
91	Can delete designer	23	delete_designer
92	Can view designer	23	view_designer
93	Can add product	24	add_product
94	Can change product	24	change_product
95	Can delete product	24	delete_product
96	Can view product	24	view_product
97	Can add variation	25	add_variation
98	Can change variation	25	change_variation
99	Can delete variation	25	delete_variation
100	Can view variation	25	view_variation
101	Can add review	26	add_review
102	Can change review	26	change_review
103	Can delete review	26	delete_review
104	Can view review	26	view_review
105	Can add product tag	27	add_producttag
106	Can change product tag	27	change_producttag
107	Can delete product tag	27	delete_producttag
108	Can view product tag	27	view_producttag
109	Can add image	28	add_image
110	Can change image	28	change_image
111	Can delete image	28	delete_image
112	Can view image	28	view_image
113	Can add background	29	add_background
114	Can change background	29	change_background
115	Can delete background	29	delete_background
116	Can view background	29	view_background
117	Can add contact	30	add_contact
118	Can change contact	30	change_contact
119	Can delete contact	30	delete_contact
120	Can view contact	30	view_contact
121	Can add slider	31	add_slider
122	Can change slider	31	change_slider
123	Can delete slider	31	delete_slider
124	Can view slider	31	view_slider
125	Can add staff	32	add_staff
126	Can change staff	32	change_staff
127	Can delete staff	32	delete_staff
128	Can view staff	32	view_staff
129	Can add subscription	33	add_subscription
130	Can change subscription	33	change_subscription
131	Can delete subscription	33	delete_subscription
132	Can view subscription	33	view_subscription
133	Can add social media	34	add_socialmedia
134	Can change social media	34	change_socialmedia
135	Can delete social media	34	delete_socialmedia
136	Can view social media	34	view_socialmedia
137	Can add cart	35	add_cart
138	Can change cart	35	change_cart
139	Can delete cart	35	delete_cart
140	Can view cart	35	view_cart
141	Can add cart item	36	add_cartitem
142	Can change cart item	36	change_cartitem
143	Can delete cart item	36	delete_cartitem
144	Can view cart item	36	view_cartitem
145	Can add user dashboard module	37	add_userdashboardmodule
146	Can change user dashboard module	37	change_userdashboardmodule
147	Can delete user dashboard module	37	delete_userdashboardmodule
148	Can view user dashboard module	37	view_userdashboardmodule
149	Can add bookmark	38	add_bookmark
150	Can change bookmark	38	change_bookmark
151	Can delete bookmark	38	delete_bookmark
152	Can view bookmark	38	view_bookmark
153	Can add pinned application	39	add_pinnedapplication
154	Can change pinned application	39	change_pinnedapplication
155	Can delete pinned application	39	delete_pinnedapplication
156	Can view pinned application	39	view_pinnedapplication
157	Can add crontab	40	add_crontabschedule
158	Can change crontab	40	change_crontabschedule
159	Can delete crontab	40	delete_crontabschedule
160	Can view crontab	40	view_crontabschedule
161	Can add interval	41	add_intervalschedule
162	Can change interval	41	change_intervalschedule
163	Can delete interval	41	delete_intervalschedule
164	Can view interval	41	view_intervalschedule
165	Can add periodic task	42	add_periodictask
166	Can change periodic task	42	change_periodictask
167	Can delete periodic task	42	delete_periodictask
168	Can view periodic task	42	view_periodictask
169	Can add periodic tasks	43	add_periodictasks
170	Can change periodic tasks	43	change_periodictasks
171	Can delete periodic tasks	43	delete_periodictasks
172	Can view periodic tasks	43	view_periodictasks
173	Can add solar event	44	add_solarschedule
174	Can change solar event	44	change_solarschedule
175	Can delete solar event	44	delete_solarschedule
176	Can view solar event	44	view_solarschedule
177	Can add clocked	45	add_clockedschedule
178	Can change clocked	45	change_clockedschedule
179	Can delete clocked	45	delete_clockedschedule
180	Can view clocked	45	view_clockedschedule
181	Can add association	46	add_association
182	Can change association	46	change_association
183	Can delete association	46	delete_association
184	Can view association	46	view_association
185	Can add code	47	add_code
186	Can change code	47	change_code
187	Can delete code	47	delete_code
188	Can view code	47	view_code
189	Can add nonce	48	add_nonce
190	Can change nonce	48	change_nonce
191	Can delete nonce	48	delete_nonce
192	Can view nonce	48	view_nonce
193	Can add user social auth	49	add_usersocialauth
194	Can change user social auth	49	change_usersocialauth
195	Can delete user social auth	49	delete_usersocialauth
196	Can view user social auth	49	view_usersocialauth
197	Can add partial	50	add_partial
198	Can change partial	50	change_partial
199	Can delete partial	50	delete_partial
200	Can view partial	50	view_partial
201	Can add discount	51	add_discount
202	Can change discount	51	change_discount
203	Can delete discount	51	delete_discount
204	Can view discount	51	view_discount
205	Can add whislist	52	add_whislist
206	Can change whislist	52	change_whislist
207	Can delete whislist	52	delete_whislist
208	Can view whislist	52	view_whislist
209	Can add auth token	53	add_authtoken
210	Can change auth token	53	change_authtoken
211	Can delete auth token	53	delete_authtoken
212	Can view auth token	53	view_authtoken
213	Can add feedback	54	add_feedback
214	Can change feedback	54	change_feedback
215	Can delete feedback	54	delete_feedback
216	Can view feedback	54	view_feedback
217	Can add about	55	add_about
218	Can change about	55	change_about
219	Can delete about	55	delete_about
220	Can view about	55	view_about
221	Can add awesome culture	56	add_awesomeculture
222	Can change awesome culture	56	change_awesomeculture
223	Can delete awesome culture	56	delete_awesomeculture
224	Can view awesome culture	56	view_awesomeculture
225	Can add sponsor	57	add_sponsor
226	Can change sponsor	57	change_sponsor
227	Can delete sponsor	57	delete_sponsor
228	Can view sponsor	57	view_sponsor
229	Can add team	58	add_team
230	Can change team	58	change_team
231	Can delete team	58	delete_team
232	Can view team	58	view_team
\.


--
-- Data for Name: blog_blog; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.blog_blog (id, title, slug, text, image, read_count, created_at, updated_at, author_id, category_id, brief_info) FROM stdin;
1	Provident quasi autem minus adipisci commodo aut exercitationem aut provident duis saepe hic cillum	demetrius-franco-provident-quasi-autem-minus-adipisci-commodo-aut-exercitationem-aut-provident-duis-saepe-hic-cillum	<p>Vitae distinctio. Fu.</p>	blogs/2022/11/23/blog-list-img-4.jpg	27	2022-11-23 14:45:47.790056+00	2022-11-23 14:45:47.790063+00	2	1	This is so informative blog
2	Non qui non sit ducimus ea culpa ut veniam necessitatibus ad eos aut sunt explicabo Est ad nemo fugiat aliquam	demetrius-franco-non-qui-non-sit-ducimus-ea-culpa-ut-veniam-necessitatibus-ad-eos-aut-sunt-explicabo-est-ad-nemo-fugiat-aliquam	<p>Laboriosam, nisi et .</p>	blogs/2022/11/23/c-img-4.jpg	41	2022-11-23 14:46:02.139828+00	2022-11-23 14:46:02.139863+00	2	1	Fantastic blog
3	Debitis placeat minima impedit voluptatum nostrum totam consequuntur	demetrius-franco-debitis-placeat-minima-impedit-voluptatum-nostrum-totam-consequuntur	<p>Quasi doloremque ill.</p>	blogs/2022/11/26/Screenshot_2022-11-25_at_20.56.02.png	80	2022-11-26 10:54:11.453628+00	2022-11-26 10:54:11.453639+00	5	1	Nihil unde rem do nobis sint
\.


--
-- Data for Name: blog_blogtag; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.blog_blogtag (id, created_at, updated_at, blog_id, tag_name_id) FROM stdin;
\.


--
-- Data for Name: blog_comment; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.blog_comment (id, name, email, subject, comment_text, created_at, updated_at, author_id, comment_id, parent_id) FROM stdin;
1	Colleen Whitfield	lizegys@mailinator.com	Architecto quibusdam aut sunt quis	Assumenda doloribus	2022-11-24 13:30:46.950111+00	2022-11-24 13:30:46.950138+00	\N	1	\N
2	Colleen Whitfield	lizegys@mailinator.com	Architecto quibusdam aut sunt quis	Assumenda doloribus	2022-11-24 13:32:40.856952+00	2022-11-24 13:32:40.856971+00	\N	1	\N
3	Laura House	pezogy@mailinator.com	Consequatur inventore eligendi nemo vel doloremque et voluptas	Incididunt itaque ex	2022-11-24 13:32:47.177462+00	2022-11-24 13:32:47.177488+00	\N	1	\N
4	Laura House	pezogy@mailinator.com	Consequatur inventore eligendi nemo vel doloremque et voluptas	Incididunt itaque ex	2022-11-24 13:33:10.336569+00	2022-11-24 13:33:10.33658+00	\N	1	\N
5	Rylee Lambert	cydapawa@mailinator.com	Atque assumenda sint dolorum aspernatur nisi officia et minima dolores ipsa consequuntur sit cillum quia	Nemo eaque quidem al	2022-11-24 13:33:19.932635+00	2022-11-24 13:33:19.932662+00	\N	1	\N
6	Rylee Lambert	cydapawa@mailinator.com	Atque assumenda sint dolorum aspernatur nisi officia et minima dolores ipsa consequuntur sit cillum quia	Nemo eaque quidem al	2022-11-24 13:35:22.849877+00	2022-11-24 13:35:22.849891+00	\N	1	\N
7	Giacomo Sexton	qufiveq@mailinator.com	Molestiae a vero veritatis fugit ullam laboriosam reprehenderit iste sed rerum accusamus facilis	Quos molestias qui a	2022-11-24 13:36:21.82801+00	2022-11-24 13:36:21.828031+00	\N	1	\N
8	Yoshio Estrada	lute@mailinator.com	Ut rerum voluptatem aperiam tempora ipsum vel dolor cupiditate excepteur ad ipsam aut omnis velit esse	Voluptatem ex commo	2022-11-24 13:43:53.931002+00	2022-11-24 13:43:53.931025+00	\N	1	\N
9	Whitney Morin	teny@mailinator.com	Omnis maxime et reiciendis enim autem minim velit ex itaque consequatur recusandae Illo sed sequi quis libero ut placeat	Amet ut et mollitia	2022-11-24 13:44:10.911574+00	2022-11-24 13:44:10.911586+00	\N	1	\N
10	Beatrice Morris	zykuguxosi@mailinator.com	Voluptates aspernatur ullamco earum laudantium commodi	Laudantium irure qu	2022-11-24 13:44:29.57238+00	2022-11-24 13:44:29.572414+00	\N	1	9
11	Arsenio Hale	kinuko@mailinator.com	Culpa alias corporis dolore velit voluptatum explicabo Asperiores	Maiores irure consec	2022-11-24 13:45:04.452178+00	2022-11-24 13:45:04.452195+00	\N	1	\N
12	Deacon White	caweju@mailinator.com	Voluptas aut maiores fugit ut in id deleniti magnam cillum et cupidatat	Ut qui est dolor und	2022-11-24 13:46:18.578709+00	2022-11-24 13:46:18.578732+00	\N	1	\N
13	Riley Schneider	heze@mailinator.com	At quis dolores consequuntur rerum illum libero ipsum qui	Aut dolor illum qui	2022-11-24 13:46:47.953589+00	2022-11-24 13:46:47.953607+00	\N	1	\N
15	Moana Dillard	risary@mailinator.com	Quae reprehenderit reprehenderit praesentium et ut voluptatibus quam velit labore est quod ducimus quis omnis beatae dolorem eum blanditiis dolor	Ex in saepe fugiat	2022-11-24 13:52:09.530141+00	2022-11-24 13:52:09.530171+00	\N	\N	\N
16	Moana Dillard	risary@mailinator.com	Quae reprehenderit reprehenderit praesentium et ut voluptatibus quam velit labore est quod ducimus quis omnis beatae dolorem eum blanditiis dolor	Ex in saepe fugiat	2022-11-24 13:53:37.736048+00	2022-11-24 13:53:37.736095+00	\N	\N	\N
17	Darryl Dickerson	cigajefix@mailinator.com	Aliquam repudiandae aut eum maxime mollitia ut	Temporibus esse magn	2022-11-24 13:53:48.543348+00	2022-11-24 13:53:48.543372+00	\N	2	\N
18	Reuben Justice	rejatij@mailinator.com	Magna ullam sit qui maxime sit culpa ipsum in sint voluptas occaecat ut corporis magna	Voluptate voluptatem	2022-11-24 13:54:08.421849+00	2022-11-24 13:54:08.421876+00	\N	2	17
19	Walker Alston	dosobysowe@mailinator.com	Earum fuga Et voluptatibus incididunt quo	Enim officia ipsum v	2022-11-24 13:54:22.79398+00	2022-11-24 13:54:22.794073+00	\N	2	17
20	Dean Navarro	wyrotawi@mailinator.com	Non id sint suscipit in voluptas qui beatae dolor impedit qui distinctio Aspernatur mollitia magni itaque	Exercitationem quaer	2022-11-25 20:31:28.192261+00	2022-11-25 20:31:28.192285+00	\N	2	\N
21	Dean Navarro	wyrotawi@mailinator.com	Non id sint suscipit in voluptas qui beatae dolor impedit qui distinctio Aspernatur mollitia magni itaque	Exercitationem quaer	2022-11-25 20:36:59.083427+00	2022-11-25 20:36:59.083457+00	\N	2	\N
22	Audrey Horton	giciximuv@mailinator.com	Irure fuga Tenetur delectus qui sed	Nostrud totam ut hic	2022-11-25 21:03:46.654543+00	2022-11-25 21:03:46.654573+00	\N	2	\N
23	Audrey Horton	giciximuv@mailinator.com	Irure fuga Tenetur delectus qui sed	Nostrud totam ut hic	2022-11-25 21:11:44.924829+00	2022-11-25 21:11:44.92486+00	\N	2	\N
24	Rhoda Allen	bobav@mailinator.com	Debitis deleniti et ratione in voluptatem dolore quae non id facilis velit	Sed facere dignissim	2022-11-25 21:27:40.814169+00	2022-11-25 21:27:40.814192+00	\N	2	\N
25	Kerim Weber	321kerim123@gmail.com	ASDFSADF	ASDFASDF	2022-11-25 21:31:20.066338+00	2022-11-25 21:31:20.066382+00	\N	2	\N
\.


--
-- Data for Name: blog_tag; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.blog_tag (id, name, usage_count, created_at, updated_at) FROM stdin;
1	Grace Mcmillan	44	2022-11-23 15:05:27.213919+00	2022-11-23 15:05:27.213943+00
\.


--
-- Data for Name: cart_cart; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.cart_cart (id, date_added, complete, transaction_id, user_id, discount_percent) FROM stdin;
20	2022-11-25 13:17:43.208885+00	f	\N	1	0
17	2022-11-25 11:52:30.742535+00	f	\N	2	10
19	2022-11-25 12:01:48.227006+00	f	\N	5	10
\.


--
-- Data for Name: cart_cartitem; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.cart_cartitem (id, quantity, color, date_added, cart_id, product_id, user_id) FROM stdin;
20	3		2022-11-25 11:53:05.802101+00	17	1	2
21	2		2022-11-25 11:56:06.534815+00	17	4	2
23	6		2022-11-25 12:02:14.84554+00	19	1	5
24	3		2022-11-25 12:02:18.439198+00	19	3	5
19	9		2022-11-25 11:53:03.316724+00	17	3	2
\.


--
-- Data for Name: cart_discount; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.cart_discount (id, discount_code, discount_percent, lifetime, expiry_date, created_date) FROM stdin;
1	kerim	10	10	2022-11-28 20:56:59.662753+00	2022-11-25 13:43:10.944454+00
2	kerim	10	1	2022-11-25 13:19:24.509283+00	2022-11-25 13:43:10.944454+00
3	akif	50	20	2022-11-25 15:16:56.620286+00	2022-11-25 15:16:56.620304+00
\.


--
-- Data for Name: cart_discount_user; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.cart_discount_user (id, discount_id, user_id) FROM stdin;
1	2	2
2	2	5
3	3	2
4	3	5
\.


--
-- Data for Name: cart_whislist; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.cart_whislist (id, product_id, user_id, is_liked) FROM stdin;
1	1	1	t
9	1	2	t
10	3	2	t
\.


--
-- Data for Name: core_about; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_about (id, main_image, about_header_text, about_footer_text) FROM stdin;
\.


--
-- Data for Name: core_awesomeculture; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_awesomeculture (id, image) FROM stdin;
\.


--
-- Data for Name: core_background; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_background (id, home_page, about_page, contact_page, product_page, order_page, login_register_page, cart_page) FROM stdin;
1	about/home.png	about/about.png	contact/contact-us.jpeg	products/products-list-bg.jpeg	order/payment-card.jpeg	users/login-register.jpeg	cart/view-cart.jpeg
\.


--
-- Data for Name: core_contact; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_contact (id, full_name, email, phone, subject, message, created_at, updated_at) FROM stdin;
1	\N	\N	\N	\N		2022-11-24 11:27:56.702939+00	2022-11-24 11:28:06.741972+00
2	\N	\N	\N	\N		2022-11-24 11:35:54.051301+00	2022-11-24 11:35:54.051312+00
3	\N	\N	\N	\N		2022-11-24 11:39:16.549562+00	2022-11-24 11:39:16.549648+00
4	\N	\N	\N	\N		2022-11-24 11:40:19.857703+00	2022-11-24 11:40:19.857753+00
5	\N	\N	\N	\N		2022-11-24 11:41:31.59456+00	2022-11-24 11:41:31.594639+00
6	\N	\N	\N	\N		2022-11-24 11:43:29.472073+00	2022-11-24 11:43:29.472984+00
7	\N	\N	\N	\N		2022-11-24 11:45:16.964251+00	2022-11-24 11:45:16.964261+00
8	\N	\N	\N	\N		2022-11-24 11:48:11.07093+00	2022-11-24 11:48:11.071004+00
9	\N	\N	\N	\N		2022-11-24 11:49:05.521573+00	2022-11-24 11:49:05.521612+00
10	\N	\N	\N	\N		2022-11-24 11:50:37.983584+00	2022-11-24 11:50:37.983636+00
11	\N	\N	\N	\N		2022-11-24 11:50:54.550614+00	2022-11-24 11:50:54.550721+00
12	\N	\N	\N	\N		2022-11-24 11:54:14.787271+00	2022-11-24 11:54:14.787401+00
13	\N	pyqoxigaqu@mailinator.com	\N	\N		2022-11-24 12:00:35.827731+00	2022-11-24 12:00:35.827758+00
14	\N	\N	\N	\N		2022-11-24 12:01:49.45943+00	2022-11-24 12:01:49.459444+00
15	\N	\N	\N	\N		2022-11-24 12:02:09.043975+00	2022-11-24 12:02:09.04405+00
16	Sara Calhoun	faxyqoc@mailinator.com	0503448864	Vel temporibus iure ad Nam aliqua Esse quas aperiam aliquid quia quis autem perferendis expedita	Duis non nostrum ver	2022-11-24 12:02:39.390602+00	2022-11-24 12:02:39.390643+00
\.


--
-- Data for Name: core_feedback; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_feedback (id, text, author, created_at, updated_at) FROM stdin;
1	Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.	Kerim Mirzequliyev	2022-11-25 00:36:22.017666+00	2022-11-25 00:36:22.017689+00
2	It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.	Fazila Jafarli	2022-11-25 00:36:38.848535+00	2022-11-25 00:36:38.848548+00
3	There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.	Murad Akhundov	2022-11-25 00:36:57.988633+00	2022-11-25 00:36:57.988667+00
\.


--
-- Data for Name: core_slider; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_slider (id, title, description, price, product_link, image) FROM stdin;
\.


--
-- Data for Name: core_sponsor; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_sponsor (id, image) FROM stdin;
\.


--
-- Data for Name: core_staff; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_staff (id, full_name, email, image, "position", description, facebook_url, twitter_url, website_url) FROM stdin;
\.


--
-- Data for Name: core_subscription; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.core_subscription (id, created_at, updated_at, subscription_email) FROM stdin;
1	2022-11-24 10:31:37.012053+00	2022-11-24 10:31:37.012094+00	\N
2	2022-11-24 10:46:33.4959+00	2022-11-24 10:46:33.495924+00	hamza@gmail.com
3	2022-11-24 10:47:16.716728+00	2022-11-24 10:47:16.716742+00	kenan@gmail.com
4	2022-11-24 10:48:03.37311+00	2022-11-24 10:48:03.373131+00	kenanovkenan299@gmail.com
5	2022-11-24 10:48:28.819331+00	2022-11-24 10:48:28.819357+00	kk@gmail.com
6	2022-11-24 10:49:13.018382+00	2022-11-24 10:49:13.026027+00	321kerim123@gmail.com
7	2022-11-24 10:56:30.570356+00	2022-11-24 10:56:30.570367+00	kl@gmail.com
8	2022-11-24 11:03:10.515992+00	2022-11-24 11:03:10.525548+00	akif@gmail.com
10	2022-11-24 11:04:36.067217+00	2022-11-24 11:04:36.075689+00	asdf
15	2022-11-24 11:19:36.57164+00	2022-11-24 11:19:36.624756+00	laman@gmail.com
16	2022-11-24 12:08:07.911857+00	2022-11-24 12:08:07.97686+00	kerim@gmail.com
17	2022-11-24 12:10:53.011995+00	2022-11-24 12:10:53.063207+00	aynur@gmail.com
\.


--
-- Data for Name: dashboard_userdashboardmodule; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.dashboard_userdashboardmodule (id, title, module, app_label, user_id, "column", "order", settings, children, collapsed) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-11-22 19:43:21.159816+00	1	Background object (1)	1	[{"added": {}}]	29	1
2	2022-11-22 19:45:47.598457+00	1	Demetrius Franco	1	[{"added": {}}]	21	1
3	2022-11-22 19:45:53.293385+00	1	Joelle Quinn	1	[{"added": {}}]	20	1
4	2022-11-22 19:45:58.81203+00	1	Griffith Johnson	1	[{"added": {}}]	23	1
5	2022-11-22 19:46:07.91274+00	1	Nerea Schwartz	1	[{"added": {}}]	22	1
6	2022-11-22 19:46:16.189943+00	1	Chase Keller	1	[{"added": {}}, {"added": {"name": "image", "object": "Roth Rocha"}}]	24	1
7	2022-11-22 20:56:59.669021+00	1	Discount object (1)	1	[{"added": {}}]	51	1
8	2022-11-23 14:45:47.791972+00	1	Provident quasi autem minus adipisci commodo aut exercitationem aut provident duis saepe hic cillum	1	[{"added": {}}]	11	1
9	2022-11-23 14:46:02.142559+00	2	Non qui non sit ducimus ea culpa ut veniam necessitatibus ad eos aut sunt explicabo Est ad nemo fugiat aliquam	1	[{"added": {}}]	11	1
10	2022-11-23 15:03:51.977122+00	2	Ruth Mcknight	1	[{"added": {}}]	21	1
11	2022-11-23 15:03:57.192544+00	3	Cathleen Benson	1	[{"added": {}}]	21	1
12	2022-11-23 15:04:01.731061+00	4	Odysseus White	1	[{"added": {}}]	21	1
13	2022-11-23 15:04:25.221051+00	2	Latifah Acevedo	1	[{"added": {}}]	22	1
14	2022-11-23 15:04:44.794346+00	3	Jordan Wong	1	[{"added": {}}]	22	1
15	2022-11-23 15:05:02.091543+00	4	cehrayi	1	[{"added": {}}]	22	1
16	2022-11-23 15:05:12.107666+00	2	Tarik Coffey	1	[{"added": {}}]	23	1
17	2022-11-23 15:05:27.219619+00	1	Grace Mcmillan	1	[{"added": {}}]	12	1
18	2022-11-23 15:06:19.140708+00	2	Scarlet Roy	1	[{"added": {}}, {"added": {"name": "image", "object": "Aquila Harmon"}}]	24	1
19	2022-11-23 15:06:43.657938+00	3	Alika Peck	1	[{"added": {}}, {"added": {"name": "image", "object": "Andrew Barlow"}}]	24	1
20	2022-11-24 22:06:54.035612+00	1	Grace Mcmillan	1	[{"added": {}}]	27	1
21	2022-11-25 00:36:22.025257+00	1	Feedback object (1)	1	[{"added": {}}]	54	1
22	2022-11-25 00:36:38.85234+00	2	Feedback object (2)	1	[{"added": {}}]	54	1
23	2022-11-25 00:36:57.994726+00	3	Feedback object (3)	1	[{"added": {}}]	54	1
24	2022-11-25 09:42:14.99729+00	4	Wade Lamb	1	[{"added": {}}, {"added": {"name": "image", "object": "Kathleen Alford"}}]	24	1
25	2022-11-25 09:59:58.903797+00	5	Anjolie Wiggins	1	[{"added": {}}, {"added": {"name": "image", "object": "Charity Combs"}}]	24	1
26	2022-11-25 13:19:24.523224+00	2	Discount object (2)	1	[{"added": {}}]	51	1
27	2022-11-25 15:16:56.634267+00	3	Discount object (3)	1	[{"added": {}}]	51	1
28	2022-11-26 10:54:11.459811+00	3	Debitis placeat minima impedit voluptatum nostrum totam consequuntur	1	[{"added": {}}]	11	1
\.


--
-- Data for Name: django_celery_beat_clockedschedule; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_celery_beat_clockedschedule (id, clocked_time) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_crontabschedule; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_celery_beat_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year, timezone) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_intervalschedule; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_celery_beat_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_periodictask; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_celery_beat_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id, solar_id, one_off, start_time, priority, headers, clocked_id, expire_seconds) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_periodictasks; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_celery_beat_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_solarschedule; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_celery_beat_solarschedule (id, event, latitude, longitude) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	users	user
7	users	phoneprefix
8	users	usernotification
9	users	blogger
10	users	myuser
11	blog	blog
12	blog	tag
13	blog	comment
14	blog	blogtag
15	order	billing
16	order	order
17	order	payment
18	order	shipping
19	order	orderitem
20	product	brand
21	product	category
22	product	color
23	product	designer
24	product	product
25	product	variation
26	product	review
27	product	producttag
28	product	image
29	core	background
30	core	contact
31	core	slider
32	core	staff
33	core	subscription
34	core	socialmedia
35	cart	cart
36	cart	cartitem
37	dashboard	userdashboardmodule
38	jet	bookmark
39	jet	pinnedapplication
40	django_celery_beat	crontabschedule
41	django_celery_beat	intervalschedule
42	django_celery_beat	periodictask
43	django_celery_beat	periodictasks
44	django_celery_beat	solarschedule
45	django_celery_beat	clockedschedule
46	social_django	association
47	social_django	code
48	social_django	nonce
49	social_django	usersocialauth
50	social_django	partial
51	cart	discount
52	cart	whislist
53	knox	authtoken
54	core	feedback
55	core	about
56	core	awesomeculture
57	core	sponsor
58	core	team
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-11-22 19:42:10.089917+00
2	contenttypes	0002_remove_content_type_name	2022-11-22 19:42:10.100172+00
3	auth	0001_initial	2022-11-22 19:42:10.141319+00
4	auth	0002_alter_permission_name_max_length	2022-11-22 19:42:10.14732+00
5	auth	0003_alter_user_email_max_length	2022-11-22 19:42:10.152926+00
6	auth	0004_alter_user_username_opts	2022-11-22 19:42:10.157489+00
7	auth	0005_alter_user_last_login_null	2022-11-22 19:42:10.163526+00
8	auth	0006_require_contenttypes_0002	2022-11-22 19:42:10.167278+00
9	auth	0007_alter_validators_add_error_messages	2022-11-22 19:42:10.172492+00
10	auth	0008_alter_user_username_max_length	2022-11-22 19:42:10.178007+00
11	auth	0009_alter_user_last_name_max_length	2022-11-22 19:42:10.184008+00
12	auth	0010_alter_group_name_max_length	2022-11-22 19:42:10.19132+00
13	auth	0011_update_proxy_permissions	2022-11-22 19:42:10.198193+00
14	auth	0012_alter_user_first_name_max_length	2022-11-22 19:42:10.204392+00
15	users	0001_initial	2022-11-22 19:42:10.296003+00
16	admin	0001_initial	2022-11-22 19:42:10.319604+00
17	admin	0002_logentry_remove_auto_add	2022-11-22 19:42:10.32867+00
18	admin	0003_logentry_add_action_flag_choices	2022-11-22 19:42:10.337247+00
19	users	0002_alter_user_last_login	2022-11-22 19:42:10.345318+00
20	blog	0001_initial	2022-11-22 19:42:10.453604+00
21	product	0001_initial	2022-11-22 19:42:10.604064+00
22	blog	0002_initial	2022-11-22 19:42:10.657071+00
23	cart	0001_initial	2022-11-22 19:42:10.700894+00
24	core	0001_initial	2022-11-22 19:42:10.753564+00
25	dashboard	0001_initial	2022-11-22 19:42:10.766538+00
26	dashboard	0002_auto_20201228_1929	2022-11-22 19:42:10.798091+00
27	dashboard	0003_alter_userdashboardmodule_id	2022-11-22 19:42:10.822212+00
28	django_celery_beat	0001_initial	2022-11-22 19:42:10.862521+00
29	django_celery_beat	0002_auto_20161118_0346	2022-11-22 19:42:10.876607+00
30	django_celery_beat	0003_auto_20161209_0049	2022-11-22 19:42:10.886624+00
31	django_celery_beat	0004_auto_20170221_0000	2022-11-22 19:42:10.891981+00
32	django_celery_beat	0005_add_solarschedule_events_choices	2022-11-22 19:42:10.89909+00
33	django_celery_beat	0006_auto_20180322_0932	2022-11-22 19:42:10.918993+00
34	django_celery_beat	0007_auto_20180521_0826	2022-11-22 19:42:10.932653+00
35	django_celery_beat	0008_auto_20180914_1922	2022-11-22 19:42:10.94712+00
36	django_celery_beat	0006_auto_20180210_1226	2022-11-22 19:42:10.956998+00
37	django_celery_beat	0006_periodictask_priority	2022-11-22 19:42:10.967657+00
38	django_celery_beat	0009_periodictask_headers	2022-11-22 19:42:10.976446+00
39	django_celery_beat	0010_auto_20190429_0326	2022-11-22 19:42:11.037+00
40	django_celery_beat	0011_auto_20190508_0153	2022-11-22 19:42:11.057151+00
41	django_celery_beat	0012_periodictask_expire_seconds	2022-11-22 19:42:11.065013+00
42	django_celery_beat	0013_auto_20200609_0727	2022-11-22 19:42:11.071914+00
43	django_celery_beat	0014_remove_clockedschedule_enabled	2022-11-22 19:42:11.079959+00
44	django_celery_beat	0015_edit_solarschedule_events_choices	2022-11-22 19:42:11.086973+00
45	django_celery_beat	0016_alter_crontabschedule_timezone	2022-11-22 19:42:11.092905+00
46	jet	0001_initial	2022-11-22 19:42:11.136392+00
47	jet	0002_delete_userdashboardmodule	2022-11-22 19:42:11.13905+00
48	jet	0003_auto_20201228_1540	2022-11-22 19:42:11.141181+00
49	jet	0004_auto_20201228_1802	2022-11-22 19:42:11.143715+00
50	jet	0002_alter_bookmark_id_alter_pinnedapplication_id	2022-11-22 19:42:11.186989+00
51	order	0001_initial	2022-11-22 19:42:11.344417+00
52	sessions	0001_initial	2022-11-22 19:42:11.358844+00
53	default	0001_initial	2022-11-22 19:42:11.414961+00
54	social_auth	0001_initial	2022-11-22 19:42:11.417234+00
55	default	0002_add_related_name	2022-11-22 19:42:11.432093+00
56	social_auth	0002_add_related_name	2022-11-22 19:42:11.434178+00
57	default	0003_alter_email_max_length	2022-11-22 19:42:11.44078+00
58	social_auth	0003_alter_email_max_length	2022-11-22 19:42:11.443023+00
59	default	0004_auto_20160423_0400	2022-11-22 19:42:11.45422+00
60	social_auth	0004_auto_20160423_0400	2022-11-22 19:42:11.456002+00
61	social_auth	0005_auto_20160727_2333	2022-11-22 19:42:11.464417+00
62	social_django	0006_partial	2022-11-22 19:42:11.478376+00
63	social_django	0007_code_timestamp	2022-11-22 19:42:11.48903+00
64	social_django	0008_partial_timestamp	2022-11-22 19:42:11.499865+00
65	social_django	0009_auto_20191118_0520	2022-11-22 19:42:11.520211+00
66	social_django	0010_uid_db_index	2022-11-22 19:42:11.536615+00
67	users	0003_alter_user_last_login	2022-11-22 19:42:11.548305+00
68	users	0004_alter_user_last_login	2022-11-22 19:42:11.559803+00
69	jet	0001_squashed_0004_auto_20201228_1802	2022-11-22 19:42:11.566012+00
70	social_django	0004_auto_20160423_0400	2022-11-22 19:42:11.567854+00
71	social_django	0001_initial	2022-11-22 19:42:11.569629+00
72	social_django	0005_auto_20160727_2333	2022-11-22 19:42:11.571292+00
73	social_django	0002_add_related_name	2022-11-22 19:42:11.572984+00
74	social_django	0003_alter_email_max_length	2022-11-22 19:42:11.574534+00
75	order	0002_orderitem_total	2022-11-22 20:00:04.640428+00
76	users	0005_alter_user_last_login	2022-11-22 20:00:04.660803+00
77	order	0003_orderitem_subtotal	2022-11-22 20:05:00.997279+00
78	users	0006_alter_user_last_login	2022-11-22 20:05:01.012073+00
79	cart	0002_discount_cart_discount_price	2022-11-22 20:54:04.573588+00
80	users	0007_alter_user_last_login	2022-11-22 20:54:04.588031+00
81	cart	0003_discount_user_id	2022-11-22 20:59:51.718161+00
82	users	0008_alter_user_last_login	2022-11-22 20:59:51.73429+00
83	cart	0004_remove_discount_user_id_discount_user_id	2022-11-22 21:03:06.670458+00
84	users	0009_alter_user_last_login	2022-11-22 21:03:06.689557+00
85	cart	0005_rename_user_id_discount_user	2022-11-22 21:06:54.837449+00
86	users	0010_alter_user_last_login	2022-11-22 21:06:54.861491+00
87	cart	0006_whislist	2022-11-23 11:39:38.066837+00
88	users	0011_alter_user_last_login	2022-11-23 11:39:38.084301+00
89	cart	0007_whislist_is_liked	2022-11-23 11:56:31.086535+00
90	users	0012_alter_user_last_login	2022-11-23 11:56:31.109838+00
91	users	0013_user_profile_image_alter_user_last_login	2022-11-23 12:55:47.481419+00
92	users	0014_alter_user_last_login_alter_user_profile_image	2022-11-23 12:58:37.394928+00
93	blog	0003_blog_brief_info	2022-11-24 08:14:26.742849+00
94	users	0015_alter_user_last_login	2022-11-24 08:14:26.765617+00
95	knox	0001_initial	2022-11-24 10:01:45.663285+00
96	knox	0002_auto_20150916_1425	2022-11-24 10:01:45.711899+00
97	knox	0003_auto_20150916_1526	2022-11-24 10:01:45.737015+00
98	knox	0004_authtoken_expires	2022-11-24 10:01:45.753607+00
99	knox	0005_authtoken_token_key	2022-11-24 10:01:45.779628+00
100	knox	0006_auto_20160818_0932	2022-11-24 10:01:45.839354+00
101	knox	0007_auto_20190111_0542	2022-11-24 10:01:45.852826+00
102	knox	0008_remove_authtoken_salt	2022-11-24 10:01:45.867415+00
103	core	0002_alter_subscription_email	2022-11-24 10:41:34.43894+00
104	users	0016_alter_user_last_login	2022-11-24 10:41:34.459333+00
105	core	0003_rename_email_subscription_subscription_email	2022-11-24 10:55:02.533965+00
106	users	0017_alter_user_last_login	2022-11-24 10:55:02.558902+00
107	core	0004_alter_subscription_subscription_email	2022-11-24 11:04:26.584052+00
108	users	0018_alter_user_last_login	2022-11-24 11:04:26.610878+00
109	blog	0004_alter_comment_comment	2022-11-24 13:38:00.204136+00
110	users	0019_alter_user_last_login	2022-11-24 13:38:00.224425+00
111	blog	0005_alter_comment_comment	2022-11-24 13:43:47.65681+00
112	users	0020_alter_user_last_login	2022-11-24 13:43:47.67809+00
113	blog	0006_alter_comment_comment	2022-11-24 13:47:50.606356+00
114	users	0021_alter_user_last_login	2022-11-24 13:47:50.628378+00
115	blog	0007_alter_comment_comment	2022-11-24 13:48:32.445183+00
116	users	0022_alter_user_last_login	2022-11-24 13:48:32.475224+00
117	blog	0008_alter_comment_comment	2022-11-24 13:51:13.120046+00
118	users	0023_alter_user_last_login	2022-11-24 13:51:13.139913+00
119	blog	0009_alter_comment_comment	2022-11-24 13:52:05.115399+00
120	users	0024_alter_user_last_login	2022-11-24 13:52:05.135976+00
121	users	0025_alter_user_last_login	2022-11-24 13:53:29.64445+00
122	users	0026_alter_user_last_login	2022-11-24 22:04:44.980111+00
123	core	0005_feedback	2022-11-25 00:31:12.943331+00
124	users	0027_alter_user_last_login	2022-11-25 00:31:12.96333+00
125	users	0028_alter_user_last_login	2022-11-25 09:14:08.750871+00
126	users	0029_alter_user_last_login	2022-11-25 11:23:13.833305+00
127	users	0030_alter_user_last_login	2022-11-25 11:37:00.136759+00
128	cart	0002_alter_cart_total_price	2022-11-25 11:56:46.782438+00
129	users	0031_alter_user_last_login	2022-11-25 11:56:46.80805+00
130	users	0032_alter_user_last_login	2022-11-25 11:56:46.832277+00
131	users	0033_alter_user_last_login	2022-11-25 11:56:46.855015+00
132	cart	0003_remove_cart_total_price	2022-11-25 12:24:18.709478+00
133	users	0034_alter_user_last_login	2022-11-25 12:24:18.730106+00
134	cart	0004_rename_discount_price_cart_discount_percetnt	2022-11-25 13:00:38.405835+00
135	users	0035_alter_user_last_login	2022-11-25 13:00:38.43155+00
136	users	0036_alter_user_last_login	2022-11-25 13:18:01.205772+00
137	cart	0005_rename_discount_percetnt_cart_discount_percent	2022-11-25 13:18:46.247888+00
138	users	0037_alter_user_last_login	2022-11-25 13:18:46.272123+00
139	cart	0006_discount_created_date	2022-11-25 13:43:10.967452+00
140	users	0038_alter_user_last_login	2022-11-25 13:43:10.990728+00
141	core	0006_about_awesomeculture_sponsor_team	2022-11-25 16:45:34.434062+00
142	users	0039_alter_user_last_login	2022-11-25 16:45:34.45413+00
143	users	0040_alter_user_last_login	2022-11-25 17:47:36.035081+00
144	core	0007_remove_socialmedia_staff_delete_team_and_more	2022-11-25 17:53:51.796493+00
145	users	0041_alter_user_last_login	2022-11-25 17:53:51.817298+00
146	cart	0007_alter_whislist_is_liked	2022-11-26 10:39:36.342765+00
147	users	0042_alter_user_last_login_alter_user_profile_image	2022-11-26 10:39:36.385742+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
v14xb3s4mfjqh2kpy1hq7wcwwdy9twdl	.eJxVjLEOwiAURf-F2TTwEBA3TZydnMkDHinR0qTQyfjv0qSDjvfcnPNmDtc2urXS4nJkZwbs8Ms8hieV7dhmHfZdh9uE-XVfHp0WnOjSDSotB2x5Ltfd-kuNWMfekZEElz6ZKLkQSEg2BH8ipZUHkjJJTBotGBM42CNa6tgaD4q0SEDs8wXXyD0D:1oxkUi:WN1Ceu_L8UmOsx3RqlOXfYBBMHOF0E9WC1BHOjcuHWo	2022-12-07 07:48:32.32565+00
fghcnnzjedyn851g1i1b9nae6yvtetqa	.eJxVjLEOwiAURf-F2TTwEBA3TZydnMkDHinR0qTQyfjv0qSDjvfcnPNmDtc2urXS4nJkZwbs8Ms8hieV7dhmHfZdh9uE-XVfHp0WnOjSDSotB2x5Ltfd-kuNWMfekZEElz6ZKLkQSEg2BH8ipZUHkjJJTBotGBM42CNa6tgaD4q0SEDs8wXXyD0D:1oxlAv:sGXBjPa8cb4K4iSEw9GFFVyaBfmc7fXSXO2yXGjh4uE	2022-12-07 08:32:09.479533+00
xph8h8wu7wu8eo17zn6ikuepf78v56rw	.eJxVjL0OwiAURt-F2TSUv4KbJs5OzuRygUC0NCl0Mr67NOmg4zlfzvcmFraW7FbDarMnZzKS069zgM9Q9mHHOhxch9sM-XVfH90WmMOlF6G0jNDyUq5H9XeVoKb-I6KhmocIUniKasRpErKDnsAw4ZiiSjvQ3DspMSI1QlPHpeEonUFmyOcLp807xw:1oyKHR:ORu45NzS6vQ1Hdk7wGu4lC_nHZwV3nPKiBJekbEmBn4	2022-12-08 22:01:13.426494+00
0li1dl9ufaplymjqcuzdu0zw9zoug4i2	.eJxVjL0OwiAURt-F2TSUv4KbJs5OzuRygUC0NCl0Mr67NOmg4zlfzvcmFraW7FbDarMnZzKS069zgM9Q9mHHOhxch9sM-XVfH90WmMOlF6G0jNDyUq5H9XeVoKb-I6KhmocIUniKasRpErKDnsAw4ZiiSjvQ3DspMSI1QlPHpeEonUFmyOcLp807xw:1oyYaN:OmXtkEKjp_Pb42pdKxvsEanZ8jX7wQJA8HiWhFDhXQ0	2022-12-09 13:17:43.178558+00
u60xrivwq8j38516gmpi17x84izdsm9p	.eJxVjLEOgjAURf-lsyHQ0kLdNHF2cm7uK6-hUUpCYTL-uyVh0PGcm3PfwmFbR7dlXlwcxFlIcfp1BP_ktA875urgXN0mxNd9eRSbMPGlFJzW6LHGOV2P6u9qRB7LD3PfUteETko0obcAas3SKs211W3wvjFgMsoESzBDzyqAPFMr1RA0ic8X1RQ9mg:1oyfzT:MhguN6qv8h2lmaOtatZ67V2D5DJ_SCue5DtipTPlAjo	2022-12-09 21:12:07.212646+00
\.


--
-- Data for Name: jet_bookmark; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.jet_bookmark (id, url, title, user_id, date_add) FROM stdin;
\.


--
-- Data for Name: jet_pinnedapplication; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.jet_pinnedapplication (id, app_label, user_id, date_add) FROM stdin;
\.


--
-- Data for Name: knox_authtoken; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.knox_authtoken (digest, created, user_id, expiry, token_key) FROM stdin;
e7ee3a3749da7cefe1eef87b1b5c84d7867d7d0d87c3c59a1ecc39b3d0608126210de01fb530c751d4ad1935d2b26ae7a62003cdee177b0214a634db6d2d2516	2022-11-25 12:01:35.226414+00	5	\N	4a003f6e
4f66b8347d2a4efd1d42262265a9fab48cdbf76970798b1723488143b224885d08ea449ad06d7fc5b5d763eb44ec84525191c68842267861f39d9e2254d35afa	2022-11-25 15:05:52.503552+00	2	\N	89fb0e13
97726a841f12c598439b5226a273cd97d91463e8dbcbc814c027af24a90aa82f0a5599f709987fc45fdb517bb0eb37fe8a939b250290baab26d220f99ece1e3c	2022-11-25 20:38:46.969381+00	2	\N	376313ea
4b12d9f1c744a5608dae5788d7795b09f15acc0c9d324fa418d84936a8bc252531e91f6fb21bf516efcfcd05ccc8e124bdbf46f47c35269ce8a6f2e620c75c31	2022-11-25 20:38:46.969507+00	2	\N	68d2da79
0dd3773c7576a8b1f215f33134dc9a58c039157a53fd501f420e43ab0fe4205b7bf7f7ab29be1788d0daaf55eca3cb04671e838790143decf0ca685d6c719f9d	2022-11-25 21:12:07.144503+00	2	\N	1e9f815e
a7ee700352e13d693ba10d2a2a2edf9c1e213c41349cc24a3cafdcf4e37e8b90db46b2d9afe8860808f808d372ea47b7ddf63584be8cb74b8987c348c664ba2d	2022-11-25 21:12:07.144672+00	2	\N	68e4a1ed
9f7ed7eda8a1d361652d14beeb384c38585974e41a49d01b5ccfa7dd3f37cb405c5e142d72ee6d1d9b4a9cbe596b460dfb0d23815061f044fac95e5001e8c5cf	2022-11-26 09:32:10.348474+00	2	\N	6614e5ce
bce56a3d2e2c1564ad795add280611e4951dd8424e76a393f006b8a37ac8fa3b69d5dd970886735fee3739cb11c7f55465c8e10c44344c3df5dce386dce7cf44	2022-11-26 09:32:14.520597+00	2	\N	260291e9
81db69fb26f095860624bca9e0b223dc4e4cf2ad8b8843a0c0e1af5035f90e8388a266905b578ced643f9fd316eace588641ffd7abfe7cca708925dff1e97c4b	2022-11-25 12:01:35.226577+00	5	\N	112f0131
\.


--
-- Data for Name: order_billing; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.order_billing (id, first_name, last_name, address, phone, user_id) FROM stdin;
1	Kerim	Weber	Sit ut maiores enim	1234	2
3	Griffith	Rosario	Vero illum culpa c	1234565	5
\.


--
-- Data for Name: order_order; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.order_order (id, order_number, transaction_id, ship_date, order_date, shipping_price, delivery_date, billing_info_id, payment_id, shipping_id, user_id) FROM stdin;
1	adbf8ea0-5058-43b5-a21b-7245b6802565	1669146563.471111	2022-11-22 19:49:23.447423+00	2022-11-22 19:49:23.447439+00	10	2022-12-02 19:49:23.471097+00	1	\N	1	2
2	a68d7ea9-8a13-46e0-a4e0-0e039807b2df	1669146609.619217	2022-11-22 19:50:09.584577+00	2022-11-22 19:50:09.584596+00	10	2022-12-02 19:50:09.619197+00	1	\N	1	2
3	4c4560de-7196-4053-b1a4-ff90d9686532	1669147523.23228	2022-11-22 20:05:23.232598+00	2022-11-22 20:05:23.232615+00	10	2022-11-22 20:05:23.232626+00	1	\N	1	2
4	e8a9decc-6981-474b-a16f-f58bbf46c293	1669147595.808355	2022-11-22 20:06:35.772888+00	2022-11-22 20:06:35.772907+00	10	2022-12-02 20:06:35.808335+00	1	\N	1	2
5	1a5664fa-de68-4f2c-aa0a-55915e5e37fb	1669194311.073199	2022-11-23 09:05:11.029003+00	2022-11-23 09:05:11.029023+00	10	2022-12-03 09:05:11.073184+00	1	\N	1	2
6	4cc6e291-2187-4dfb-80e8-17f2b6ad5177	1669194387.904209	2022-11-23 09:06:27.873188+00	2022-11-23 09:06:27.873202+00	10	2022-12-03 09:06:27.904196+00	1	\N	1	2
7	4fe30e7c-6cc6-48d0-a18d-b942cd74ecfb	1669194427.867896	2022-11-23 09:07:07.840078+00	2022-11-23 09:07:07.840099+00	10	2022-12-03 09:07:07.867878+00	1	\N	1	2
8	3285567a-481d-43bb-86c2-9aa945c0f39f	1669195261.278396	2022-11-23 09:21:01.234137+00	2022-11-23 09:21:01.234156+00	10	2022-12-03 09:21:01.278382+00	1	\N	1	2
9	9ca11048-90ff-4ef0-8738-64a087022176	1669195771.330328	2022-11-23 09:29:31.289368+00	2022-11-23 09:29:31.289385+00	10	2022-12-03 09:29:31.330305+00	1	\N	1	2
10	6515c703-9048-4d70-905d-875444807c33	1669198605.27463	2022-11-23 10:16:45.240071+00	2022-11-23 10:16:45.240088+00	10	2022-12-03 10:16:45.274616+00	1	\N	1	2
11	5e555838-f434-4a69-a0a2-2c1d1281441d	1669198641.947022	2022-11-23 10:17:21.947357+00	2022-11-23 10:17:21.947375+00	10	2022-11-23 10:17:21.947386+00	1	\N	1	2
12	e47788d2-d768-4c3f-9bf1-73c82c806c50	1669198668.313301	2022-11-23 10:17:48.313911+00	2022-11-23 10:17:48.313944+00	10	2022-11-23 10:17:48.313957+00	1	\N	1	2
13	502efc7a-7c11-4305-919a-c433148fc942	1669198685.681006	2022-11-23 10:18:05.681234+00	2022-11-23 10:18:05.681244+00	10	2022-11-23 10:18:05.68125+00	1	\N	1	2
14	764f047b-3c14-466c-a3cf-352a3839a8f3	1669198705.609973	2022-11-23 10:18:25.610301+00	2022-11-23 10:18:25.610323+00	10	2022-11-23 10:18:25.610336+00	1	\N	1	2
15	3e4bf7f7-1097-488e-9e03-b0f0616f2547	1669198718.538728	2022-11-23 10:18:38.539088+00	2022-11-23 10:18:38.539103+00	10	2022-11-23 10:18:38.539113+00	1	\N	1	2
16	c5b42621-a167-468d-a79a-2c6a58a1a782	1669198755.192088	2022-11-23 10:19:15.192577+00	2022-11-23 10:19:15.192595+00	10	2022-11-23 10:19:15.192606+00	1	\N	1	2
17	3ee4ceee-6997-43cc-b8a9-64cb00b7ec32	1669198883.908194	2022-11-23 10:21:23.908649+00	2022-11-23 10:21:23.908667+00	10	2022-11-23 10:21:23.908678+00	1	\N	1	2
18	2a9d52c4-e8a1-40c3-b681-7220f382650d	1669198921.033089	2022-11-23 10:22:01.035399+00	2022-11-23 10:22:01.035426+00	10	2022-11-23 10:22:01.03545+00	1	\N	1	2
19	206cbb1f-fb56-43a1-8779-83ea5aad2a0a	1669198963.586387	2022-11-23 10:22:43.587022+00	2022-11-23 10:22:43.587065+00	10	2022-11-23 10:22:43.587077+00	1	\N	1	2
20	7a1847ee-ba9d-4668-abed-3e8a69217bc1	1669199202.357431	2022-11-23 10:26:42.358112+00	2022-11-23 10:26:42.358143+00	10	2022-11-23 10:26:42.358159+00	1	\N	1	2
21	7bf05d01-3849-4d8c-8945-ade0e4cd72a2	1669199212.920232	2022-11-23 10:26:52.920574+00	2022-11-23 10:26:52.92061+00	10	2022-11-23 10:26:52.920624+00	1	\N	1	2
22	4ead7b71-6d27-45fe-a9f0-32b4c17d7444	1669199273.879113	2022-11-23 10:27:53.879703+00	2022-11-23 10:27:53.879732+00	10	2022-11-23 10:27:53.879742+00	1	\N	1	2
23	c8790acb-bc9c-4d6e-a5e5-86a94731b8fe	1669199276.338359	2022-11-23 10:27:56.33871+00	2022-11-23 10:27:56.338742+00	10	2022-11-23 10:27:56.338755+00	1	\N	1	2
24	e2746cec-0837-47ce-a9d1-dc45dc81d17b	1669199297.30225	2022-11-23 10:28:17.302488+00	2022-11-23 10:28:17.30251+00	10	2022-11-23 10:28:17.302523+00	1	\N	1	2
25	81bdc757-4b8e-4aa2-a30b-2f23b7d6c35e	1669199696.968811	2022-11-23 10:34:56.969303+00	2022-11-23 10:34:56.969322+00	10	2022-11-23 10:34:56.969333+00	1	\N	1	2
26	960674c7-d158-4cfa-a0a8-a14a49fed15d	1669199717.040619	2022-11-23 10:35:17.040829+00	2022-11-23 10:35:17.040846+00	10	2022-11-23 10:35:17.040856+00	1	\N	1	2
27	1e94d234-ea5b-4c99-ace7-53b58a4e47a9	1669199751.638304	2022-11-23 10:35:51.638941+00	2022-11-23 10:35:51.638976+00	10	2022-11-23 10:35:51.638991+00	1	\N	1	2
28	3850cf4e-a2e9-454a-9fc8-4f1f1b6c8e12	1669199808.549047	2022-11-23 10:36:48.549369+00	2022-11-23 10:36:48.549387+00	10	2022-11-23 10:36:48.549398+00	1	\N	1	2
29	3f51790a-2b87-4db4-a529-e8f665bf0d3d	1669199820.885569	2022-11-23 10:37:00.886019+00	2022-11-23 10:37:00.886035+00	10	2022-11-23 10:37:00.886045+00	1	\N	1	2
30	24d2e2e6-703f-4db0-a74b-e3b234cf2218	1669199874.708113	2022-11-23 10:37:54.708247+00	2022-11-23 10:37:54.708257+00	10	2022-11-23 10:37:54.708264+00	1	\N	1	2
31	5f5ccda0-36d0-47eb-bb20-57ff781474f7	1669199886.911728	2022-11-23 10:38:06.912038+00	2022-11-23 10:38:06.912068+00	10	2022-11-23 10:38:06.912082+00	1	\N	1	2
32	339d34b7-9599-4dab-b4c5-0044174c4de3	1669199919.358034	2022-11-23 10:38:39.358381+00	2022-11-23 10:38:39.358406+00	10	2022-11-23 10:38:39.358419+00	1	\N	1	2
33	79cb7f85-e6d6-4b20-a5b4-bae95b1434cc	1669199926.537018	2022-11-23 10:38:46.537264+00	2022-11-23 10:38:46.537283+00	10	2022-11-23 10:38:46.537294+00	1	\N	1	2
34	692b92ef-1148-4621-a68f-8d6d9d9e217f	1669199936.587746	2022-11-23 10:38:56.588024+00	2022-11-23 10:38:56.588043+00	10	2022-11-23 10:38:56.588055+00	1	\N	1	2
35	04cd4f85-2d07-49d1-b118-943b0b363e03	1669199940.936192	2022-11-23 10:39:00.936321+00	2022-11-23 10:39:00.93633+00	10	2022-11-23 10:39:00.936337+00	1	\N	1	2
36	5a264668-1220-42ce-bb96-7f35efc37003	1669199954.39489	2022-11-23 10:39:14.395252+00	2022-11-23 10:39:14.395286+00	10	2022-11-23 10:39:14.395303+00	1	\N	1	2
37	3c365093-4f42-46b6-b8d5-3c2678c7fd0d	1669200015.866773	2022-11-23 10:40:15.867078+00	2022-11-23 10:40:15.867095+00	10	2022-11-23 10:40:15.867106+00	1	\N	1	2
38	2da1b5ca-d1a7-47ff-ac76-b6e6bf0f566f	1669200027.361225	2022-11-23 10:40:27.361579+00	2022-11-23 10:40:27.361614+00	10	2022-11-23 10:40:27.361632+00	1	\N	1	2
39	37949b20-3f66-45d1-94d8-32b61ae02b71	1669200036.440946	2022-11-23 10:40:36.44111+00	2022-11-23 10:40:36.441122+00	10	2022-11-23 10:40:36.44113+00	1	\N	1	2
40	bd62480d-a6ea-42f1-9180-f3b1b5329546	1669200143.917647	2022-11-23 10:42:21.291986+00	2022-11-23 10:42:21.292006+00	10	2022-12-03 10:42:23.917622+00	1	\N	1	2
41	428a9094-19e8-4a84-8ae5-61fe59ecd865	1669200206.361366	2022-11-23 10:43:26.36168+00	2022-11-23 10:43:26.361698+00	10	2022-11-23 10:43:26.36171+00	1	\N	1	2
42	0137740b-93a9-4ccf-8c45-5544043b76b8	1669200227.094123	2022-11-23 10:43:47.094246+00	2022-11-23 10:43:47.094253+00	10	2022-11-23 10:43:47.094257+00	1	\N	1	2
43	0eff8056-b0f0-41fb-82d9-51d95073e0b3	1669200232.00884	2022-11-23 10:43:52.009199+00	2022-11-23 10:43:52.009218+00	10	2022-11-23 10:43:52.009229+00	1	\N	1	2
44	c5e89605-b4f9-4623-b9c9-eb25810c9075	1669200249.518581	2022-11-23 10:44:09.520178+00	2022-11-23 10:44:09.520199+00	10	2022-11-23 10:44:09.520211+00	1	\N	1	2
45	06e3821b-95b1-4e99-974a-4a8c4273571a	1669200273.329643	2022-11-23 10:44:33.330104+00	2022-11-23 10:44:33.330123+00	10	2022-11-23 10:44:33.330135+00	1	\N	1	2
46	ea2865e6-542e-43c0-90c3-9d6c7b0e827f	1669200294.033422	2022-11-23 10:44:54.033994+00	2022-11-23 10:44:54.034026+00	10	2022-11-23 10:44:54.034039+00	1	\N	1	2
47	0c291fc9-fe79-4a45-aaff-b196ef0b76f7	1669200448.817387	2022-11-23 10:47:26.536391+00	2022-11-23 10:47:26.536409+00	10	2022-12-03 10:47:28.817358+00	1	\N	1	2
48	dffe6850-fbbe-434f-b2f4-b8bfa736c4d1	1669215409.340716	2022-11-23 14:56:46.76746+00	2022-11-23 14:56:46.767554+00	10	2022-12-03 14:56:49.340694+00	1	\N	1	2
49	4451f0cf-d159-4a4a-b972-549c26ab11d7	1669270784.960179	2022-11-24 06:19:40.972759+00	2022-11-24 06:19:40.972777+00	10	2022-12-04 06:19:44.960146+00	1	\N	1	2
\.


--
-- Data for Name: order_orderitem; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.order_orderitem (id, quantity, color, complete, cart_id, order_id, product_id, user_id, total, subtotal) FROM stdin;
\.


--
-- Data for Name: order_payment; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.order_payment (id, is_paid, payment_date, payment_type, is_allowed) FROM stdin;
\.


--
-- Data for Name: order_shipping; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.order_shipping (id, address, country, city, region, zipcode, phone, company_name, user_id) FROM stdin;
1	Sit ut maiores enim	turkey	Excepteur iure id et modi aliquip qui molestiae	turkeyExcepteur iure id et modi aliquip qui molestiae	\N	1234	\N	2
3	Vero illum culpa c	russia	Magnam praesentium ea aspernatur exercitationem ab eius ullamco voluptate harum	russiaMagnam praesentium ea aspernatur exercitationem ab eius ullamco voluptate harum	\N	1234565	\N	5
\.


--
-- Data for Name: product_brand; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_brand (id, name, name_az, name_en, name_ru) FROM stdin;
1	Joelle Quinn	Joelle Quinn	Nathaniel Hull	Faith Rowe
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_category (id, name, name_az, name_en, name_ru, category_image) FROM stdin;
1	Demetrius Franco	Demetrius Franco	Keane Mcguire	Owen Gibbs	category_default.jpeg
2	Ruth Mcknight	Ruth Mcknight	Noble Shelton	Taylor Oliver	category_default.jpeg
3	Cathleen Benson	Cathleen Benson	Yvette Moses	Debra Barker	category_default.jpeg
4	Odysseus White	Odysseus White	September Porter	Porter Kemp	category_default.jpeg
\.


--
-- Data for Name: product_color; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_color (id, name, name_az, name_en, name_ru, color) FROM stdin;
1	Nerea Schwartz	Nerea Schwartz	Kitra Cox	Martin Mullins	#000000FF
2	Latifah Acevedo	Latifah Acevedo	Yoko Payne	Mechelle Rowland	#28FF11FF
3	Jordan Wong	Jordan Wong	Fritz Oneal	Rigel Sweet	#000000FF
4	cehrayi	cehrayi	Emi Ramos	Tamekah Scott	#000000FF
\.


--
-- Data for Name: product_designer; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_designer (id, name, name_az, name_en, name_ru) FROM stdin;
1	Griffith Johnson	Griffith Johnson	Eaton Rhodes	Nyssa Reese
2	Tarik Coffey	Tarik Coffey	Yetta Serrano	Griffin Dalton
\.


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_image (id, image, is_main, product_id) FROM stdin;
1	product_images/2022/11/22/blog-list-img-1-2.jpg	f	1
2	product_images/2022/11/23/Screenshot_2022-11-15_at_23.51.09.png	f	2
3	product_images/2022/11/23/Screenshot_2022-11-15_at_23.51.09_t6gd112.png	t	3
4	product_images/2022/11/25/Screenshot_2022-11-16_at_00.24.08.png	f	4
5	product_images/2022/11/25/Screenshot_2022-11-15_at_14.39.36.png	t	5
\.


--
-- Data for Name: product_product; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_product (id, product_name, product_name_az, product_name_en, product_name_ru, main_image, brief_info, brief_info_az, brief_info_en, brief_info_ru, price, like_status, discount_status, discount_percent, product_detail, product_detail_az, product_detail_en, product_detail_ru, delivery_info, delivery_info_az, delivery_info_en, delivery_info_ru, product_description, product_description_az, product_description_en, product_description_ru, product_info, product_info_az, product_info_en, product_info_ru, availability, slug, order_count, hit_count, created_at, updated_at, brand_id, category_id, designer_id) FROM stdin;
5	Anjolie Wiggins	Anjolie Wiggins	Charity Combs	Mannix Cook	Screenshot_2022-10-12_at_16.19.42.png	Quisquam vel veritatis officia eaque dolores sint illo non sit velit perspiciatis possimus vitae consectetur et libero ad praesentium velit	Quisquam vel veritatis officia eaque dolores sint illo non sit velit perspiciatis possimus vitae consectetur et libero ad praesentium velit	Voluptatem fuga Quo nostrud sed accusamus in dignissimos	Eum aut fuga Beatae deserunt commodi odit nemo	150	t	\N	13	Voluptate ut est ver	Voluptate ut est ver	Autem doloribus sit	Sunt neque qui repre	Illo hic id impedit	Illo hic id impedit	Quisquam est et nul	Enim praesentium sus	Sunt repudiandae tem	Sunt repudiandae tem	Soluta aut quia ulla	Adipisci voluptatum	<p>Dolor dicta nisi est.</p>	<p>Dolor dicta nisi est.</p>	<p>Itaque id aut impedi.</p>	<p>Quos ut aut ullamco .</p>	f	joelle-quinn-demetrius-franco-anjolie-wiggins	24	4	2022-11-25 09:59:58.889177+00	2022-11-25 09:59:58.889201+00	1	1	1
2	Scarlet Roy	Scarlet Roy	Aquila Harmon	Grady Larson	Screenshot_2022-10-17_at_15.34.56_ML92nMG.png	Est quos nisi aliquam quia minim sunt voluptas	Est quos nisi aliquam quia minim sunt voluptas	Nisi eu qui consequat Maiores architecto	Ipsa aut elit eiusmod dignissimos a est	475	f	\N	78	Tempor velit vel del	Tempor velit vel del	Eum natus sit sit au	Provident aliquip s	Quidem beatae itaque	Quidem beatae itaque	Deserunt minima ad q	Expedita culpa repre	Voluptatem Explicab	Voluptatem Explicab	Ipsa est porro qui	Quo id voluptas ab	<p>Sunt et dolore qui n.</p>	<p>Sunt et dolore qui n.</p>	<p>Velit in enim consec.</p>	<p>Elit, qui accusamus .</p>	\N	joelle-quinn-ruth-mcknight-scarlet-roy	61	57	2022-11-23 15:06:19.131619+00	2022-11-23 15:06:19.131629+00	1	2	2
3	Alika Peck	Alika Peck	Andrew Barlow	Paula Lowery	Screenshot_2022-11-15_at_14.39.36_QX4vHjv.png	Vel voluptates quisquam et quisquam qui numquam laboriosam ullam lorem nobis quam libero officia minim dolor	Vel voluptates quisquam et quisquam qui numquam laboriosam ullam lorem nobis quam libero officia minim dolor	Non adipisicing ad dolor sapiente at facilis ut dolor est	Sequi numquam consequuntur eum consectetur ea voluptate incididunt delectus error aut sunt	195	\N	f	25	Mollitia ad rerum en	Mollitia ad rerum en	Voluptates maxime qu	Nulla quia quia qui	Pariatur Aut quis n	Pariatur Aut quis n	Corporis nulla liber	Eligendi et commodo	Alias est dolores qu	Alias est dolores qu	Voluptatem laboriosa	Necessitatibus exped	<p>Molestiae voluptatem.</p>	<p>Molestiae voluptatem.</p>	<p>Aperiam consequat. O.</p>	<p>Ducimus, dolore non .</p>	t	joelle-quinn-ruth-mcknight-alika-peck	79	71	2022-11-23 15:06:43.644648+00	2022-11-23 15:06:43.644665+00	1	2	1
1	Chase Keller	Chase Keller	Roth Rocha	Odette Shelton	blog-list-img-1-4_JBk1oj4.jpg	Ipsum incidunt et ullam consequatur blanditiis enim	Ipsum incidunt et ullam consequatur blanditiis enim	Velit sed aliqua Assumenda in suscipit qui	Iste deserunt pariatur Et beatae do est magna voluptatem Ut	396	t	f	29	Sunt reprehenderit	Sunt reprehenderit	Consequatur minima e	Libero rem odio veli	Exercitation et quae	Exercitation et quae	Sed nihil ratione do	At dignissimos in ut	Rerum in qui recusan	Rerum in qui recusan	Animi aut pariatur	Eligendi atque dolor	<p>Quidem sit possimus.</p>	<p>Quidem sit possimus.</p>	<p>Culpa, dolorem culpa.</p>	<p>Reiciendis et quis a.</p>	t	joelle-quinn-demetrius-franco-chase-keller	44	90	2022-11-22 19:46:16.174345+00	2022-11-24 06:19:40.991276+00	1	1	1
4	Wade Lamb	Wade Lamb	Kathleen Alford	Demetrius Carroll	Screenshot_2022-10-01_at_18.20.25.png	Aut eos molestiae adipisci ad deleniti atque optio aut accusantium non	Aut eos molestiae adipisci ad deleniti atque optio aut accusantium non	Ab lorem nesciunt fugiat dolor et inventore nemo rem ut at et	Voluptatum accusantium quis laborum Doloribus suscipit voluptatem consequatur dolore reiciendis quisquam qui pariatur Dolores aspernatur doloremque eos vel dolorem numquam	728	t	t	12	Rerum tempora exerci	Rerum tempora exerci	Eos consequatur fac	Facere consequatur	Porro id sed consect	Porro id sed consect	Vero cumque ratione	Repellendus Quod am	Aut amet tempor sit	Aut amet tempor sit	Commodi incidunt mo	Dolor cum quis nobis	<p>Et quae quod nesciun.</p>	<p>Et quae quod nesciun.</p>	<p>Molestiae consequatu.</p>	<p>Molestiae aliquip to.</p>	t	joelle-quinn-odysseus-white-wade-lamb	28	9	2022-11-25 09:42:14.985608+00	2022-11-25 09:42:14.985617+00	1	4	1
\.


--
-- Data for Name: product_product_color; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_product_color (id, product_id, color_id) FROM stdin;
1	1	1
2	2	2
3	2	3
4	2	4
5	3	1
6	3	4
7	4	3
8	4	4
9	5	3
\.


--
-- Data for Name: product_producttag; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_producttag (id, created_at, updated_at, product_id, tag_name_id) FROM stdin;
1	2022-11-24 22:06:54.028054+00	2022-11-24 22:06:54.028077+00	2	1
\.


--
-- Data for Name: product_review; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_review (id, name, email, review_text, rating, created_at, updated_at, product_id) FROM stdin;
1	Isabella Nixon	bafejuwig@mailinator.com	Aut quis qui tempora	5	2022-11-24 13:56:08.182503+00	2022-11-24 13:56:08.182527+00	1
2	Grace Randall	jivyhe@mailinator.com	Commodo nulla nihil	3	2022-11-24 13:56:28.501124+00	2022-11-24 13:56:28.501158+00	1
\.


--
-- Data for Name: product_variation; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.product_variation (id, variation_category, variation_value, is_active, created_date, product_id) FROM stdin;
\.


--
-- Data for Name: social_auth_association; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.social_auth_association (id, server_url, handle, secret, issued, lifetime, assoc_type) FROM stdin;
\.


--
-- Data for Name: social_auth_code; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.social_auth_code (id, email, code, verified, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_nonce; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.social_auth_nonce (id, server_url, "timestamp", salt) FROM stdin;
\.


--
-- Data for Name: social_auth_partial; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.social_auth_partial (id, token, next_step, backend, data, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_usersocialauth; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.social_auth_usersocialauth (id, provider, uid, extra_data, user_id, created, modified) FROM stdin;
\.


--
-- Data for Name: users_phoneprefix; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.users_phoneprefix (id, prefix, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users_user; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.users_user (id, password, is_superuser, is_active, username, first_name, last_name, address, country, city, email, gender, phone, zip_code, is_staff, birth_date, date_joined, last_login, phone_prefix_id, profile_image) FROM stdin;
5	pbkdf2_sha256$320000$kLL2TrJO9EjofOR5k3c5dX$adHhsFr/MRkvynrptORtHePltKCa+GgWRU80C5cEVkU=	f	t	\N	Griffith	Rosario	Vero illum culpa c	russia	Magnam praesentium ea aspernatur exercitationem ab eius ullamco voluptate harum	kenanovkenan299@gmail.com	\N	1234565	\N	f	\N	2022-11-25 12:01:11.309618+00	2022-11-25 12:01:35.30153+00	\N	users/default-pp/avatar-1.jpg
1	pbkdf2_sha256$320000$cpGmTgP4mYAJiqbQ6s7tGf$SwD9L4OlA7USPOdAy7kh/We33rE3p/xk7wp3L3qMqbw=	t	t	admin			\N	green	\N	admin@gmail.collm	\N	0503448864	\N	t	\N	2022-11-22 19:42:49.658506+00	2022-11-25 16:52:35.022973+00	\N	users/default-pp/avatar-1.jpg
2	pbkdf2_sha256$320000$pa0D5hZDiGeRTW305GOovK$Oy8jSx86P6yL2mUGSpNhix9er9iIt2G1llimr5nGtmM=	f	t	kerim	Kerim	Weber	Sit ut maiores enim	turkey	Excepteur iure id et modi aliquip qui molestiae	321kerim123@gmail.com	\N	1234	\N	f	\N	2022-11-22 19:44:36.050619+00	2022-11-25 21:12:07.210174+00	\N	
\.


--
-- Data for Name: users_user_groups; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.users_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.users_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: users_usernotification; Type: TABLE DATA; Schema: public; Owner: pavshop
--

COPY public.users_usernotification (id, mail_sent, created_at, updated_at, user_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 232, true);


--
-- Name: blog_blog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.blog_blog_id_seq', 3, true);


--
-- Name: blog_blogtag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.blog_blogtag_id_seq', 1, false);


--
-- Name: blog_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.blog_comment_id_seq', 25, true);


--
-- Name: blog_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.blog_tag_id_seq', 1, true);


--
-- Name: cart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.cart_cart_id_seq', 20, true);


--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.cart_cartitem_id_seq', 24, true);


--
-- Name: cart_discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.cart_discount_id_seq', 3, true);


--
-- Name: cart_discount_user_id_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.cart_discount_user_id_id_seq', 4, true);


--
-- Name: cart_whislist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.cart_whislist_id_seq', 10, true);


--
-- Name: core_about_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_about_id_seq', 1, false);


--
-- Name: core_awesomeculture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_awesomeculture_id_seq', 1, false);


--
-- Name: core_background_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_background_id_seq', 1, true);


--
-- Name: core_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_contact_id_seq', 16, true);


--
-- Name: core_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_feedback_id_seq', 3, true);


--
-- Name: core_slider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_slider_id_seq', 1, false);


--
-- Name: core_sponsor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_sponsor_id_seq', 1, false);


--
-- Name: core_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_staff_id_seq', 1, false);


--
-- Name: core_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.core_subscription_id_seq', 17, true);


--
-- Name: dashboard_userdashboardmodule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.dashboard_userdashboardmodule_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 28, true);


--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_celery_beat_clockedschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_celery_beat_crontabschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_celery_beat_intervalschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_celery_beat_periodictask_id_seq', 1, false);


--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_celery_beat_solarschedule_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 58, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 147, true);


--
-- Name: jet_bookmark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.jet_bookmark_id_seq', 1, false);


--
-- Name: jet_pinnedapplication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.jet_pinnedapplication_id_seq', 1, false);


--
-- Name: order_billing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.order_billing_id_seq', 3, true);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.order_order_id_seq', 49, true);


--
-- Name: order_orderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.order_orderitem_id_seq', 14, true);


--
-- Name: order_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.order_payment_id_seq', 1, false);


--
-- Name: order_shipping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.order_shipping_id_seq', 3, true);


--
-- Name: product_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_brand_id_seq', 1, true);


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_category_id_seq', 4, true);


--
-- Name: product_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_color_id_seq', 4, true);


--
-- Name: product_designer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_designer_id_seq', 2, true);


--
-- Name: product_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_image_id_seq', 5, true);


--
-- Name: product_product_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_product_color_id_seq', 9, true);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_product_id_seq', 5, true);


--
-- Name: product_producttag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_producttag_id_seq', 1, true);


--
-- Name: product_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_review_id_seq', 2, true);


--
-- Name: product_variation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.product_variation_id_seq', 1, false);


--
-- Name: social_auth_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.social_auth_association_id_seq', 1, false);


--
-- Name: social_auth_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.social_auth_code_id_seq', 1, false);


--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.social_auth_nonce_id_seq', 1, false);


--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.social_auth_partial_id_seq', 1, false);


--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.social_auth_usersocialauth_id_seq', 1, false);


--
-- Name: users_phoneprefix_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.users_phoneprefix_id_seq', 1, false);


--
-- Name: users_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.users_user_groups_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.users_user_id_seq', 5, true);


--
-- Name: users_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.users_user_user_permissions_id_seq', 1, false);


--
-- Name: users_usernotification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pavshop
--

SELECT pg_catalog.setval('public.users_usernotification_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: blog_blog blog_blog_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_pkey PRIMARY KEY (id);


--
-- Name: blog_blog blog_blog_slug_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_slug_key UNIQUE (slug);


--
-- Name: blog_blogtag blog_blogtag_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blogtag
    ADD CONSTRAINT blog_blogtag_pkey PRIMARY KEY (id);


--
-- Name: blog_comment blog_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_comment
    ADD CONSTRAINT blog_comment_pkey PRIMARY KEY (id);


--
-- Name: blog_tag blog_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_tag
    ADD CONSTRAINT blog_tag_pkey PRIMARY KEY (id);


--
-- Name: cart_cart cart_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cart
    ADD CONSTRAINT cart_cart_pkey PRIMARY KEY (id);


--
-- Name: cart_cartitem cart_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_pkey PRIMARY KEY (id);


--
-- Name: cart_discount cart_discount_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_discount
    ADD CONSTRAINT cart_discount_pkey PRIMARY KEY (id);


--
-- Name: cart_discount_user cart_discount_user_id_discount_id_user_id_8888b16a_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_discount_user
    ADD CONSTRAINT cart_discount_user_id_discount_id_user_id_8888b16a_uniq UNIQUE (discount_id, user_id);


--
-- Name: cart_discount_user cart_discount_user_id_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_discount_user
    ADD CONSTRAINT cart_discount_user_id_pkey PRIMARY KEY (id);


--
-- Name: cart_whislist cart_whislist_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_whislist
    ADD CONSTRAINT cart_whislist_pkey PRIMARY KEY (id);


--
-- Name: core_about core_about_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_about
    ADD CONSTRAINT core_about_pkey PRIMARY KEY (id);


--
-- Name: core_awesomeculture core_awesomeculture_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_awesomeculture
    ADD CONSTRAINT core_awesomeculture_pkey PRIMARY KEY (id);


--
-- Name: core_background core_background_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_background
    ADD CONSTRAINT core_background_pkey PRIMARY KEY (id);


--
-- Name: core_contact core_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_contact
    ADD CONSTRAINT core_contact_pkey PRIMARY KEY (id);


--
-- Name: core_feedback core_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_feedback
    ADD CONSTRAINT core_feedback_pkey PRIMARY KEY (id);


--
-- Name: core_slider core_slider_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_slider
    ADD CONSTRAINT core_slider_pkey PRIMARY KEY (id);


--
-- Name: core_sponsor core_sponsor_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_sponsor
    ADD CONSTRAINT core_sponsor_pkey PRIMARY KEY (id);


--
-- Name: core_staff core_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_staff
    ADD CONSTRAINT core_staff_pkey PRIMARY KEY (id);


--
-- Name: core_subscription core_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.core_subscription
    ADD CONSTRAINT core_subscription_pkey PRIMARY KEY (id);


--
-- Name: dashboard_userdashboardmodule dashboard_userdashboardmodule_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.dashboard_userdashboardmodule
    ADD CONSTRAINT dashboard_userdashboardmodule_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_clockedschedule django_celery_beat_clockedschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule
    ADD CONSTRAINT django_celery_beat_clockedschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_crontabschedule django_celery_beat_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule
    ADD CONSTRAINT django_celery_beat_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_intervalschedule django_celery_beat_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule
    ADD CONSTRAINT django_celery_beat_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_name_key UNIQUE (name);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictasks django_celery_beat_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictasks
    ADD CONSTRAINT django_celery_beat_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq UNIQUE (event, latitude, longitude);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solarschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solarschedule_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: jet_bookmark jet_bookmark_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.jet_bookmark
    ADD CONSTRAINT jet_bookmark_pkey PRIMARY KEY (id);


--
-- Name: jet_pinnedapplication jet_pinnedapplication_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.jet_pinnedapplication
    ADD CONSTRAINT jet_pinnedapplication_pkey PRIMARY KEY (id);


--
-- Name: knox_authtoken knox_authtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.knox_authtoken
    ADD CONSTRAINT knox_authtoken_pkey PRIMARY KEY (digest);


--
-- Name: order_billing order_billing_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_billing
    ADD CONSTRAINT order_billing_pkey PRIMARY KEY (id);


--
-- Name: order_order order_order_order_number_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_order_number_key UNIQUE (order_number);


--
-- Name: order_order order_order_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_pkey PRIMARY KEY (id);


--
-- Name: order_orderitem order_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_orderitem
    ADD CONSTRAINT order_orderitem_pkey PRIMARY KEY (id);


--
-- Name: order_payment order_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_payment
    ADD CONSTRAINT order_payment_pkey PRIMARY KEY (id);


--
-- Name: order_shipping order_shipping_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_shipping
    ADD CONSTRAINT order_shipping_pkey PRIMARY KEY (id);


--
-- Name: product_brand product_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_brand
    ADD CONSTRAINT product_brand_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product_color product_color_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_color
    ADD CONSTRAINT product_color_pkey PRIMARY KEY (id);


--
-- Name: product_designer product_designer_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_designer
    ADD CONSTRAINT product_designer_pkey PRIMARY KEY (id);


--
-- Name: product_image product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (id);


--
-- Name: product_product_color product_product_color_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product_color
    ADD CONSTRAINT product_product_color_pkey PRIMARY KEY (id);


--
-- Name: product_product_color product_product_color_product_id_color_id_d1cf75c1_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product_color
    ADD CONSTRAINT product_product_color_product_id_color_id_d1cf75c1_uniq UNIQUE (product_id, color_id);


--
-- Name: product_product product_product_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_pkey PRIMARY KEY (id);


--
-- Name: product_product product_product_slug_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_slug_key UNIQUE (slug);


--
-- Name: product_producttag product_producttag_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_producttag
    ADD CONSTRAINT product_producttag_pkey PRIMARY KEY (id);


--
-- Name: product_review product_review_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_pkey PRIMARY KEY (id);


--
-- Name: product_variation product_variation_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT product_variation_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_server_url_handle_078befa2_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_server_url_handle_078befa2_uniq UNIQUE (server_url, handle);


--
-- Name: social_auth_code social_auth_code_email_code_801b2d02_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_email_code_801b2d02_uniq UNIQUE (email, code);


--
-- Name: social_auth_code social_auth_code_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_server_url_timestamp_salt_f6284463_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_server_url_timestamp_salt_f6284463_uniq UNIQUE (server_url, "timestamp", salt);


--
-- Name: social_auth_partial social_auth_partial_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_partial
    ADD CONSTRAINT social_auth_partial_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_provider_uid_e6b5e668_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_provider_uid_e6b5e668_uniq UNIQUE (provider, uid);


--
-- Name: users_phoneprefix users_phoneprefix_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_phoneprefix
    ADD CONSTRAINT users_phoneprefix_pkey PRIMARY KEY (id);


--
-- Name: users_phoneprefix users_phoneprefix_prefix_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_phoneprefix
    ADD CONSTRAINT users_phoneprefix_prefix_key UNIQUE (prefix);


--
-- Name: users_user users_user_email_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_email_key UNIQUE (email);


--
-- Name: users_user_groups users_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_user_groups users_user_groups_user_id_group_id_b88eab82_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_group_id_b88eab82_uniq UNIQUE (user_id, group_id);


--
-- Name: users_user users_user_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_permission_id_43338c45_uniq; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_permission_id_43338c45_uniq UNIQUE (user_id, permission_id);


--
-- Name: users_user users_user_username_key; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_username_key UNIQUE (username);


--
-- Name: users_usernotification users_usernotification_pkey; Type: CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_usernotification
    ADD CONSTRAINT users_usernotification_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: blog_blog_author_id_8791af69; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_blog_author_id_8791af69 ON public.blog_blog USING btree (author_id);


--
-- Name: blog_blog_category_id_c34d5f94; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_blog_category_id_c34d5f94 ON public.blog_blog USING btree (category_id);


--
-- Name: blog_blog_slug_4812aa2c_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_blog_slug_4812aa2c_like ON public.blog_blog USING btree (slug varchar_pattern_ops);


--
-- Name: blog_blogtag_blog_id_1bf00095; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_blogtag_blog_id_1bf00095 ON public.blog_blogtag USING btree (blog_id);


--
-- Name: blog_blogtag_tag_name_id_c128fa6b; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_blogtag_tag_name_id_c128fa6b ON public.blog_blogtag USING btree (tag_name_id);


--
-- Name: blog_comment_author_id_4f11e2e0; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_comment_author_id_4f11e2e0 ON public.blog_comment USING btree (author_id);


--
-- Name: blog_comment_comment_id_867709d7; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_comment_comment_id_867709d7 ON public.blog_comment USING btree (comment_id);


--
-- Name: blog_comment_parent_id_f2a027bb; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX blog_comment_parent_id_f2a027bb ON public.blog_comment USING btree (parent_id);


--
-- Name: cart_cart_user_id_9b4220b9; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_cart_user_id_9b4220b9 ON public.cart_cart USING btree (user_id);


--
-- Name: cart_cartitem_cart_id_370ad265; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_cartitem_cart_id_370ad265 ON public.cart_cartitem USING btree (cart_id);


--
-- Name: cart_cartitem_product_id_b24e265a; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_cartitem_product_id_b24e265a ON public.cart_cartitem USING btree (product_id);


--
-- Name: cart_cartitem_user_id_292943b8; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_cartitem_user_id_292943b8 ON public.cart_cartitem USING btree (user_id);


--
-- Name: cart_discount_user_id_discount_id_41ac463d; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_discount_user_id_discount_id_41ac463d ON public.cart_discount_user USING btree (discount_id);


--
-- Name: cart_discount_user_id_user_id_e8f4698a; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_discount_user_id_user_id_e8f4698a ON public.cart_discount_user USING btree (user_id);


--
-- Name: cart_whislist_product_id_58259e32; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_whislist_product_id_58259e32 ON public.cart_whislist USING btree (product_id);


--
-- Name: cart_whislist_user_id_1900f0cc; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX cart_whislist_user_id_1900f0cc ON public.cart_whislist USING btree (user_id);


--
-- Name: dashboard_userdashboardmodule_user_id_97c13132; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX dashboard_userdashboardmodule_user_id_97c13132 ON public.dashboard_userdashboardmodule USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_celery_beat_periodictask_clocked_id_47a69f82; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_celery_beat_periodictask_clocked_id_47a69f82 ON public.django_celery_beat_periodictask USING btree (clocked_id);


--
-- Name: django_celery_beat_periodictask_crontab_id_d3cba168; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_celery_beat_periodictask_crontab_id_d3cba168 ON public.django_celery_beat_periodictask USING btree (crontab_id);


--
-- Name: django_celery_beat_periodictask_interval_id_a8ca27da; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_celery_beat_periodictask_interval_id_a8ca27da ON public.django_celery_beat_periodictask USING btree (interval_id);


--
-- Name: django_celery_beat_periodictask_name_265a36b7_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_celery_beat_periodictask_name_265a36b7_like ON public.django_celery_beat_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: django_celery_beat_periodictask_solar_id_a87ce72c; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_celery_beat_periodictask_solar_id_a87ce72c ON public.django_celery_beat_periodictask USING btree (solar_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: first_name_idx; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX first_name_idx ON public.users_user USING btree (first_name);


--
-- Name: jet_bookmark_user_id_8efdc332; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX jet_bookmark_user_id_8efdc332 ON public.jet_bookmark USING btree (user_id);


--
-- Name: jet_pinnedapplication_user_id_7765bcf9; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX jet_pinnedapplication_user_id_7765bcf9 ON public.jet_pinnedapplication USING btree (user_id);


--
-- Name: knox_authtoken_digest_188c7e77_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX knox_authtoken_digest_188c7e77_like ON public.knox_authtoken USING btree (digest varchar_pattern_ops);


--
-- Name: knox_authtoken_token_key_8f4f7d47; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX knox_authtoken_token_key_8f4f7d47 ON public.knox_authtoken USING btree (token_key);


--
-- Name: knox_authtoken_token_key_8f4f7d47_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX knox_authtoken_token_key_8f4f7d47_like ON public.knox_authtoken USING btree (token_key varchar_pattern_ops);


--
-- Name: knox_authtoken_user_id_e5a5d899; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX knox_authtoken_user_id_e5a5d899 ON public.knox_authtoken USING btree (user_id);


--
-- Name: order_billing_user_id_f6e5d6f2; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_billing_user_id_f6e5d6f2 ON public.order_billing USING btree (user_id);


--
-- Name: order_order_billing_info_id_38540e03; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_order_billing_info_id_38540e03 ON public.order_order USING btree (billing_info_id);


--
-- Name: order_order_payment_id_d8fb3a38; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_order_payment_id_d8fb3a38 ON public.order_order USING btree (payment_id);


--
-- Name: order_order_shipping_id_c723e72f; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_order_shipping_id_c723e72f ON public.order_order USING btree (shipping_id);


--
-- Name: order_order_user_id_7cf9bc2b; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_order_user_id_7cf9bc2b ON public.order_order USING btree (user_id);


--
-- Name: order_orderitem_cart_id_d3c2c463; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_orderitem_cart_id_d3c2c463 ON public.order_orderitem USING btree (cart_id);


--
-- Name: order_orderitem_order_id_aba34f44; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_orderitem_order_id_aba34f44 ON public.order_orderitem USING btree (order_id);


--
-- Name: order_orderitem_product_id_c5c6b07a; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_orderitem_product_id_c5c6b07a ON public.order_orderitem USING btree (product_id);


--
-- Name: order_orderitem_user_id_625e0887; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_orderitem_user_id_625e0887 ON public.order_orderitem USING btree (user_id);


--
-- Name: order_shipping_user_id_7ac589a2; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX order_shipping_user_id_7ac589a2 ON public.order_shipping USING btree (user_id);


--
-- Name: product_image_product_id_8b9355c5; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_image_product_id_8b9355c5 ON public.product_image USING btree (product_id);


--
-- Name: product_product_brand_id_fcf1b3f3; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_product_brand_id_fcf1b3f3 ON public.product_product USING btree (brand_id);


--
-- Name: product_product_category_id_0c725779; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_product_category_id_0c725779 ON public.product_product USING btree (category_id);


--
-- Name: product_product_color_color_id_8f3ae534; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_product_color_color_id_8f3ae534 ON public.product_product_color USING btree (color_id);


--
-- Name: product_product_color_product_id_31c3247c; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_product_color_product_id_31c3247c ON public.product_product_color USING btree (product_id);


--
-- Name: product_product_designer_id_1b4eef55; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_product_designer_id_1b4eef55 ON public.product_product USING btree (designer_id);


--
-- Name: product_product_slug_76cde0ae_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_product_slug_76cde0ae_like ON public.product_product USING btree (slug varchar_pattern_ops);


--
-- Name: product_producttag_product_id_93f9e9d0; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_producttag_product_id_93f9e9d0 ON public.product_producttag USING btree (product_id);


--
-- Name: product_producttag_tag_name_id_d286e48a; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_producttag_tag_name_id_d286e48a ON public.product_producttag USING btree (tag_name_id);


--
-- Name: product_review_product_id_428b0c5c; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_review_product_id_428b0c5c ON public.product_review USING btree (product_id);


--
-- Name: product_variation_product_id_c2273cd9; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX product_variation_product_id_c2273cd9 ON public.product_variation USING btree (product_id);


--
-- Name: social_auth_code_code_a2393167; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_code_code_a2393167 ON public.social_auth_code USING btree (code);


--
-- Name: social_auth_code_code_a2393167_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_code_code_a2393167_like ON public.social_auth_code USING btree (code varchar_pattern_ops);


--
-- Name: social_auth_code_timestamp_176b341f; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_code_timestamp_176b341f ON public.social_auth_code USING btree ("timestamp");


--
-- Name: social_auth_partial_timestamp_50f2119f; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_partial_timestamp_50f2119f ON public.social_auth_partial USING btree ("timestamp");


--
-- Name: social_auth_partial_token_3017fea3; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_partial_token_3017fea3 ON public.social_auth_partial USING btree (token);


--
-- Name: social_auth_partial_token_3017fea3_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_partial_token_3017fea3_like ON public.social_auth_partial USING btree (token varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_uid_796e51dc; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc ON public.social_auth_usersocialauth USING btree (uid);


--
-- Name: social_auth_usersocialauth_uid_796e51dc_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc_like ON public.social_auth_usersocialauth USING btree (uid varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_user_id_17d28448; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX social_auth_usersocialauth_user_id_17d28448 ON public.social_auth_usersocialauth USING btree (user_id);


--
-- Name: users_phoneprefix_prefix_cf696d7a_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_phoneprefix_prefix_cf696d7a_like ON public.users_phoneprefix USING btree (prefix varchar_pattern_ops);


--
-- Name: users_user_email_243f6e77_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_email_243f6e77_like ON public.users_user USING btree (email varchar_pattern_ops);


--
-- Name: users_user_first_n_6d862e_idx; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_first_n_6d862e_idx ON public.users_user USING btree (first_name, last_name);


--
-- Name: users_user_groups_group_id_9afc8d0e; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_groups_group_id_9afc8d0e ON public.users_user_groups USING btree (group_id);


--
-- Name: users_user_groups_user_id_5f6f5a90; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_groups_user_id_5f6f5a90 ON public.users_user_groups USING btree (user_id);


--
-- Name: users_user_phone_prefix_id_b192777a; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_phone_prefix_id_b192777a ON public.users_user USING btree (phone_prefix_id);


--
-- Name: users_user_user_permissions_permission_id_0b93982e; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_user_permissions_permission_id_0b93982e ON public.users_user_user_permissions USING btree (permission_id);


--
-- Name: users_user_user_permissions_user_id_20aca447; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_user_permissions_user_id_20aca447 ON public.users_user_user_permissions USING btree (user_id);


--
-- Name: users_user_username_06e46fe6_like; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_user_username_06e46fe6_like ON public.users_user USING btree (username varchar_pattern_ops);


--
-- Name: users_usernotification_user_id_4cef5e00; Type: INDEX; Schema: public; Owner: pavshop
--

CREATE INDEX users_usernotification_user_id_4cef5e00 ON public.users_usernotification USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blog blog_blog_author_id_8791af69_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_author_id_8791af69_fk_users_user_id FOREIGN KEY (author_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blog blog_blog_category_id_c34d5f94_fk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blog
    ADD CONSTRAINT blog_blog_category_id_c34d5f94_fk_product_category_id FOREIGN KEY (category_id) REFERENCES public.product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogtag blog_blogtag_blog_id_1bf00095_fk_blog_blog_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blogtag
    ADD CONSTRAINT blog_blogtag_blog_id_1bf00095_fk_blog_blog_id FOREIGN KEY (blog_id) REFERENCES public.blog_blog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogtag blog_blogtag_tag_name_id_c128fa6b_fk_blog_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_blogtag
    ADD CONSTRAINT blog_blogtag_tag_name_id_c128fa6b_fk_blog_tag_id FOREIGN KEY (tag_name_id) REFERENCES public.blog_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_comment blog_comment_author_id_4f11e2e0_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_comment
    ADD CONSTRAINT blog_comment_author_id_4f11e2e0_fk_users_user_id FOREIGN KEY (author_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_comment blog_comment_comment_id_867709d7_fk_blog_blog_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_comment
    ADD CONSTRAINT blog_comment_comment_id_867709d7_fk_blog_blog_id FOREIGN KEY (comment_id) REFERENCES public.blog_blog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_comment blog_comment_parent_id_f2a027bb_fk_blog_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.blog_comment
    ADD CONSTRAINT blog_comment_parent_id_f2a027bb_fk_blog_comment_id FOREIGN KEY (parent_id) REFERENCES public.blog_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cart cart_cart_user_id_9b4220b9_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cart
    ADD CONSTRAINT cart_cart_user_id_9b4220b9_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_cart_id_370ad265_fk_cart_cart_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_cart_id_370ad265_fk_cart_cart_id FOREIGN KEY (cart_id) REFERENCES public.cart_cart(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_product_id_b24e265a_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_product_id_b24e265a_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_user_id_292943b8_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_user_id_292943b8_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_discount_user cart_discount_user_id_discount_id_41ac463d_fk_cart_discount_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_discount_user
    ADD CONSTRAINT cart_discount_user_id_discount_id_41ac463d_fk_cart_discount_id FOREIGN KEY (discount_id) REFERENCES public.cart_discount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_discount_user cart_discount_user_id_user_id_e8f4698a_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_discount_user
    ADD CONSTRAINT cart_discount_user_id_user_id_e8f4698a_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_whislist cart_whislist_product_id_58259e32_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_whislist
    ADD CONSTRAINT cart_whislist_product_id_58259e32_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_whislist cart_whislist_user_id_1900f0cc_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.cart_whislist
    ADD CONSTRAINT cart_whislist_user_id_1900f0cc_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_userdashboardmodule dashboard_userdashboardmodule_user_id_97c13132_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.dashboard_userdashboardmodule
    ADD CONSTRAINT dashboard_userdashboardmodule_user_id_97c13132_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_clocked_id_47a69f82_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_clocked_id_47a69f82_fk_django_ce FOREIGN KEY (clocked_id) REFERENCES public.django_celery_beat_clockedschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_crontab_id_d3cba168_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_crontab_id_d3cba168_fk_django_ce FOREIGN KEY (crontab_id) REFERENCES public.django_celery_beat_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_interval_id_a8ca27da_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_interval_id_a8ca27da_fk_django_ce FOREIGN KEY (interval_id) REFERENCES public.django_celery_beat_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_solar_id_a87ce72c_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_solar_id_a87ce72c_fk_django_ce FOREIGN KEY (solar_id) REFERENCES public.django_celery_beat_solarschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: jet_bookmark jet_bookmark_user_id_8efdc332_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.jet_bookmark
    ADD CONSTRAINT jet_bookmark_user_id_8efdc332_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: jet_pinnedapplication jet_pinnedapplication_user_id_7765bcf9_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.jet_pinnedapplication
    ADD CONSTRAINT jet_pinnedapplication_user_id_7765bcf9_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: knox_authtoken knox_authtoken_user_id_e5a5d899_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.knox_authtoken
    ADD CONSTRAINT knox_authtoken_user_id_e5a5d899_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_billing order_billing_user_id_f6e5d6f2_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_billing
    ADD CONSTRAINT order_billing_user_id_f6e5d6f2_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_billing_info_id_38540e03_fk_order_billing_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_billing_info_id_38540e03_fk_order_billing_id FOREIGN KEY (billing_info_id) REFERENCES public.order_billing(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_payment_id_d8fb3a38_fk_order_payment_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_payment_id_d8fb3a38_fk_order_payment_id FOREIGN KEY (payment_id) REFERENCES public.order_payment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_shipping_id_c723e72f_fk_order_shipping_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_shipping_id_c723e72f_fk_order_shipping_id FOREIGN KEY (shipping_id) REFERENCES public.order_shipping(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_user_id_7cf9bc2b_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_user_id_7cf9bc2b_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderitem order_orderitem_cart_id_d3c2c463_fk_cart_cart_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_orderitem
    ADD CONSTRAINT order_orderitem_cart_id_d3c2c463_fk_cart_cart_id FOREIGN KEY (cart_id) REFERENCES public.cart_cart(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderitem order_orderitem_order_id_aba34f44_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_orderitem
    ADD CONSTRAINT order_orderitem_order_id_aba34f44_fk_order_order_id FOREIGN KEY (order_id) REFERENCES public.order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderitem order_orderitem_product_id_c5c6b07a_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_orderitem
    ADD CONSTRAINT order_orderitem_product_id_c5c6b07a_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderitem order_orderitem_user_id_625e0887_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_orderitem
    ADD CONSTRAINT order_orderitem_user_id_625e0887_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_shipping order_shipping_user_id_7ac589a2_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.order_shipping
    ADD CONSTRAINT order_shipping_user_id_7ac589a2_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_image product_image_product_id_8b9355c5_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_product_id_8b9355c5_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_brand_id_fcf1b3f3_fk_product_brand_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_brand_id_fcf1b3f3_fk_product_brand_id FOREIGN KEY (brand_id) REFERENCES public.product_brand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_category_id_0c725779_fk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_category_id_0c725779_fk_product_category_id FOREIGN KEY (category_id) REFERENCES public.product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product_color product_product_color_color_id_8f3ae534_fk_product_color_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product_color
    ADD CONSTRAINT product_product_color_color_id_8f3ae534_fk_product_color_id FOREIGN KEY (color_id) REFERENCES public.product_color(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product_color product_product_color_product_id_31c3247c_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product_color
    ADD CONSTRAINT product_product_color_product_id_31c3247c_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_designer_id_1b4eef55_fk_product_designer_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_designer_id_1b4eef55_fk_product_designer_id FOREIGN KEY (designer_id) REFERENCES public.product_designer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_producttag product_producttag_product_id_93f9e9d0_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_producttag
    ADD CONSTRAINT product_producttag_product_id_93f9e9d0_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_producttag product_producttag_tag_name_id_d286e48a_fk_blog_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_producttag
    ADD CONSTRAINT product_producttag_tag_name_id_d286e48a_fk_blog_tag_id FOREIGN KEY (tag_name_id) REFERENCES public.blog_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_review product_review_product_id_428b0c5c_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_product_id_428b0c5c_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_variation product_variation_product_id_c2273cd9_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT product_variation_product_id_c2273cd9_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_user_id_17d28448_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_user_id_17d28448_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_group_id_9afc8d0e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_group_id_9afc8d0e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_groups users_user_groups_user_id_5f6f5a90_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_groups
    ADD CONSTRAINT users_user_groups_user_id_5f6f5a90_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user users_user_phone_prefix_id_b192777a_fk_users_phoneprefix_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user
    ADD CONSTRAINT users_user_phone_prefix_id_b192777a_fk_users_phoneprefix_id FOREIGN KEY (phone_prefix_id) REFERENCES public.users_phoneprefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_perm_permission_id_0b93982e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_perm_permission_id_0b93982e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_user_permissions users_user_user_permissions_user_id_20aca447_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_user_user_permissions
    ADD CONSTRAINT users_user_user_permissions_user_id_20aca447_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_usernotification users_usernotification_user_id_4cef5e00_fk_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: pavshop
--

ALTER TABLE ONLY public.users_usernotification
    ADD CONSTRAINT users_usernotification_user_id_4cef5e00_fk_users_user_id FOREIGN KEY (user_id) REFERENCES public.users_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7
-- Dumped by pg_dump version 13.7

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: pavshop
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO pavshop;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: pavshop
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

