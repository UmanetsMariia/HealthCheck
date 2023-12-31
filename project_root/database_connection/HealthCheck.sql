PGDMP                      {            HealthCheck    16.1    16.1     E           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            H           1262    16397    HealthCheck    DATABASE     o   CREATE DATABASE "HealthCheck" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE "HealthCheck";
                postgres    false                        3079    16409    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            I           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2                       1255    16446    verify(text, text)    FUNCTION     	  CREATE FUNCTION public.verify(e_mail text, pwd text) RETURNS integer
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
       public          postgres    false            �            1259    16458    clinics    TABLE     x   CREATE TABLE public.clinics (
    id bigint NOT NULL,
    name character varying(60),
    city character varying(50)
);
    DROP TABLE public.clinics;
       public         heap    postgres    false            �            1259    16457    clinics_id_seq    SEQUENCE     w   CREATE SEQUENCE public.clinics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.clinics_id_seq;
       public          postgres    false    219            J           0    0    clinics_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.clinics_id_seq OWNED BY public.clinics.id;
          public          postgres    false    218            �            1259    16465    doctors    TABLE     �   CREATE TABLE public.doctors (
    id bigint NOT NULL,
    name character varying(100),
    spec character varying(100),
    clinic_id integer
);
    DROP TABLE public.doctors;
       public         heap    postgres    false            �            1259    16464    doctors_id_seq    SEQUENCE     w   CREATE SEQUENCE public.doctors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.doctors_id_seq;
       public          postgres    false    221            K           0    0    doctors_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.doctors_id_seq OWNED BY public.doctors.id;
          public          postgres    false    220            �            1259    16399    users    TABLE     5  CREATE TABLE public.users (
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
       public          postgres    false    217            L           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    216            �           2604    16461 
   clinics id    DEFAULT     h   ALTER TABLE ONLY public.clinics ALTER COLUMN id SET DEFAULT nextval('public.clinics_id_seq'::regclass);
 9   ALTER TABLE public.clinics ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    16468 
   doctors id    DEFAULT     h   ALTER TABLE ONLY public.doctors ALTER COLUMN id SET DEFAULT nextval('public.doctors_id_seq'::regclass);
 9   ALTER TABLE public.doctors ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    16402    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    216    217    217            @          0    16458    clinics 
   TABLE DATA           1   COPY public.clinics (id, name, city) FROM stdin;
    public          postgres    false    219          B          0    16465    doctors 
   TABLE DATA           <   COPY public.doctors (id, name, spec, clinic_id) FROM stdin;
    public          postgres    false    221   f       >          0    16399    users 
   TABLE DATA           [   COPY public.users (user_id, first_name, last_name, email, password, dob, city) FROM stdin;
    public          postgres    false    217          M           0    0    clinics_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.clinics_id_seq', 2, true);
          public          postgres    false    218            N           0    0    doctors_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.doctors_id_seq', 5, true);
          public          postgres    false    220            O           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 4, true);
          public          postgres    false    216            �           2606    16463    clinics clinics_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.clinics
    ADD CONSTRAINT clinics_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.clinics DROP CONSTRAINT clinics_pkey;
       public            postgres    false    219            �           2606    16470    doctors doctors_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.doctors DROP CONSTRAINT doctors_pkey;
       public            postgres    false    221            �           2606    16408    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    217            �           2606    16406    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            @   >   x�3�0�bÅ/6]�pa7��L���ˈ�)�#51�$�������v]������� ��B      B   �   x�}�M
�0���)r�@���äu#�t�B)x ��h���ȉ������f>޼D�D#�84��V֠��x ��l�^��Jt�PI��$�U���D�L�'ۑ
����u�&
{Z5���7�1ͧz��4?��l��~��)���M2Z�^��s�����V      >   �   x�m�1k�@���~G��]R�ln�Ppn蒴A%�*�R�&����B頔�Am����~;8�ǽ���������ʾ��*�f��3J^t�=��d\t�&�<�EųL����Q!ӫnv?6�t0��,�TH�R�2$|��؊��A�w=`�e{��2���"[�:AB�[���,�n_�g��3��WL�~�Fq�8���CX3�8��?��^�b�y�x�B��X��     