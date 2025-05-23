PGDMP      )                }            card_management    17.4    17.4     2           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            3           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            4           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            5           1262    16388    card_management    DATABASE     �   CREATE DATABASE card_management WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE card_management;
                     postgres    false                        3079    16532    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                        false            6           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                             false    2            �            1259    16480 
   bank_cards    TABLE     �  CREATE TABLE public.bank_cards (
    id bigint NOT NULL,
    card_number_encrypted character varying(255) NOT NULL,
    card_number_masked character varying(255) NOT NULL,
    card_holder character varying(255) NOT NULL,
    expiry_date date NOT NULL,
    status character varying(255) NOT NULL,
    balance numeric(38,2) DEFAULT 0.00 NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_blocked boolean DEFAULT false,
    CONSTRAINT bank_cards_status_check CHECK (((status)::text = ANY (ARRAY[('ACTIVE'::character varying)::text, ('BLOCKED'::character varying)::text, ('EXPIRED'::character varying)::text])))
);
    DROP TABLE public.bank_cards;
       public         heap r       postgres    false            �            1259    16479    bank_cards_id_seq    SEQUENCE     �   ALTER TABLE public.bank_cards ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bank_cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    221            �            1259    16510    transactions    TABLE       CREATE TABLE public.transactions (
    id bigint NOT NULL,
    source_card_id bigint,
    destination_card_id bigint,
    amount numeric(38,2) NOT NULL,
    description character varying(100),
    status character varying(10),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "timestamp" timestamp(6) without time zone,
    CONSTRAINT transactions_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'COMPLETED'::character varying, 'FAILED'::character varying])::text[])))
);
     DROP TABLE public.transactions;
       public         heap r       postgres    false            �            1259    16509    transactions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.transactions_id_seq;
       public               postgres    false    223            7           0    0    transactions_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;
          public               postgres    false    222            �            1259    16450    users    TABLE     �   CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    16449    users_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    219            �           2604    16596    transactions id    DEFAULT     r   ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);
 >   ALTER TABLE public.transactions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    223    223            -          0    16480 
   bank_cards 
   TABLE DATA           �   COPY public.bank_cards (id, card_number_encrypted, card_number_masked, card_holder, expiry_date, status, balance, user_id, created_at, updated_at, is_blocked) FROM stdin;
    public               postgres    false    221   k"       /          0    16510    transactions 
   TABLE DATA           �   COPY public.transactions (id, source_card_id, destination_card_id, amount, description, status, created_at, "timestamp") FROM stdin;
    public               postgres    false    223   $       +          0    16450    users 
   TABLE DATA           7   COPY public.users (id, username, password) FROM stdin;
    public               postgres    false    219   +$       8           0    0    bank_cards_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.bank_cards_id_seq', 3, true);
          public               postgres    false    220            9           0    0    transactions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);
          public               postgres    false    222            :           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 3, true);
          public               postgres    false    218            �           2606    16571    bank_cards bank_cards_pk 
   CONSTRAINT     V   ALTER TABLE ONLY public.bank_cards
    ADD CONSTRAINT bank_cards_pk PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.bank_cards DROP CONSTRAINT bank_cards_pk;
       public                 postgres    false    221            �           2606    16598    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public                 postgres    false    223            �           2606    16623    users users_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pk;
       public                 postgres    false    219            �           2606    16635    users users_unique 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_unique UNIQUE (username);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT users_unique;
       public                 postgres    false    219            �           2606    16624 "   bank_cards bank_cards_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bank_cards
    ADD CONSTRAINT bank_cards_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 L   ALTER TABLE ONLY public.bank_cards DROP CONSTRAINT bank_cards_user_id_fkey;
       public               postgres    false    221    4751    219            �           2606    16603 2   transactions transactions_destination_card_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_destination_card_id_fkey FOREIGN KEY (destination_card_id) REFERENCES public.bank_cards(id);
 \   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_destination_card_id_fkey;
       public               postgres    false    221    223    4755            �           2606    16612 -   transactions transactions_source_card_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_source_card_id_fkey FOREIGN KEY (source_card_id) REFERENCES public.bank_cards(id);
 W   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_source_card_id_fkey;
       public               postgres    false    223    4755    221            -   �  x���=�0��Sl� Y�ۅ�"}H��-Kg�Qr��}r�9RKl��
��$,/OO?�`�����u����C5�`ēM�2����L2;R�ۢ��5��ӎz0��l2�;DJ,
��S�H��2�Y8{w�[�$%`��4�|8��_D�/�������������e���8>^>}������_L8�i<��4�L�����%��\�֢DVy��� .'
G7��L�
խ��յ�LWkq��9wF���-������l�b�^3�<f����R�� �ŧV�x7P�P$oY}�נ�a�G��i����su���ju����xF�j��Ո���C��Q6�h�����-�� �Y��{��P����Ǉ_uK�m;��(�+�[V_�n���/���      /      x������ � �      +   R   x�3�LL����T1JT10S�LOK�6tv3�H�(��	���-�t1�L��736r�.L)��HJ/(p6r�(w*����� >D�     