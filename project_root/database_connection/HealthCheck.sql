PGDMP  1                    {            HealthCheck    16.1    16.1     1           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            2           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            3           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            4           1262    16397    HealthCheck    DATABASE     o   CREATE DATABASE "HealthCheck" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE "HealthCheck";
                postgres    false                        3079    16409    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            5           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2            �            1255    16446    verify(text, text)    FUNCTION     	  CREATE FUNCTION public.verify(e_mail text, pwd text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	declare
	verified integer;
	begin
		select 1 into verified from users where email=e_mail and password=crypt(pwd,password);
		return coalesce(verified,0);
	end;
$$;
 4   DROP FUNCTION public.verify(e_mail text, pwd text);
       public          postgres    false            �            1259    16399    users    TABLE     5  CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    dob date NOT NULL,
    city character varying(255) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16398    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    217            6           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    216            �           2604    16402    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    216    217    217            .          0    16399    users 
   TABLE DATA           [   COPY public.users (user_id, first_name, last_name, email, password, dob, city) FROM stdin;
    public          postgres    false    217   �       7           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 3, true);
          public          postgres    false    216            �           2606    16408    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    217            �           2606    16406    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            .   �   x�m��
�@���H�K�Hg'�`m�I4h0�`'b!�)���}��3̽�w6ZX��͌ �����r<Q�^��T?��h�L���d�f��H�#� ��1h9*2��I7U���$�	�8�\.\����.�#Q��O��p1aw{���O��|���B|��j��37�^�nʯH����0�
�l7�v�1�L�l�     