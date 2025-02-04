PGDMP      0                 }            resource_dashboard    17.2    17.2 >    7           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            8           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            9           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            :           1262    17239    resource_dashboard    DATABASE     �   CREATE DATABASE resource_dashboard WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 "   DROP DATABASE resource_dashboard;
                     postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            ;           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1255    17773 "   update_financial_target_achieved()    FUNCTION       CREATE FUNCTION public.update_financial_target_achieved() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the achieved_till_date
    UPDATE financial_target
    SET achieved_till_date = (
        SELECT SUM(total_amount_billed)
        FROM sales
        WHERE user_id = NEW.user_id
    )
    WHERE user_id = NEW.user_id;

    -- Update balance_to_go
    UPDATE financial_target
    SET balance_to_go = business_target - achieved_till_date
    WHERE user_id = NEW.user_id;

    RETURN NEW; -- return the new row
END;
$$;
 9   DROP FUNCTION public.update_financial_target_achieved();
       public               postgres    false    4            �            1259    17701    company_id_seq    SEQUENCE     w   CREATE SEQUENCE public.company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.company_id_seq;
       public               postgres    false    4            �            1259    17732    company    TABLE     �  CREATE TABLE public.company (
    id integer DEFAULT nextval('public.company_id_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    address text,
    company_logo character varying(255) DEFAULT ''::character varying,
    city character varying(100) DEFAULT ''::character varying,
    state character varying(100) DEFAULT ''::character varying,
    country character varying(100) DEFAULT ''::character varying,
    mobile character varying(25) DEFAULT ''::character varying,
    pincode character varying(20) DEFAULT ''::character varying,
    gstin character varying(15) DEFAULT ''::character varying,
    email character varying(100) DEFAULT ''::character varying,
    website character varying(100) DEFAULT ''::character varying,
    pan_number character varying(20) DEFAULT ''::character varying,
    financial_year_beginning date DEFAULT CURRENT_DATE,
    books_beginning date DEFAULT CURRENT_DATE,
    currency character varying(20) DEFAULT 'INR'::character varying,
    bank_name character varying(100) DEFAULT ''::character varying,
    account_number character varying(50) DEFAULT ''::character varying,
    ifsc character varying(20) DEFAULT ''::character varying,
    branch character varying(100) DEFAULT ''::character varying,
    swift_code character varying(20) DEFAULT ''::character varying,
    upi_id character varying(100) DEFAULT ''::character varying,
    whatsapp_number character varying(15) DEFAULT ''::character varying,
    instance_id character varying(50) DEFAULT ''::character varying,
    created_by character varying(50),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_by character varying(50),
    updated_date timestamp without time zone
);
    DROP TABLE public.company;
       public         heap r       postgres    false    230    4            �            1259    17600    financial_target    TABLE     �  CREATE TABLE public.financial_target (
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
 $   DROP TABLE public.financial_target;
       public         heap r       postgres    false    4            �            1259    17599    financial_target_id_seq    SEQUENCE     �   CREATE SEQUENCE public.financial_target_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.financial_target_id_seq;
       public               postgres    false    4    229            <           0    0    financial_target_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.financial_target_id_seq OWNED BY public.financial_target.id;
          public               postgres    false    228            �            1259    17272 	   quotation    TABLE       CREATE TABLE public.quotation (
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
    updated_date timestamp without time zone,
    user_id integer
);
    DROP TABLE public.quotation;
       public         heap r       postgres    false    4            �            1259    17271    quotation_id_seq    SEQUENCE     �   CREATE SEQUENCE public.quotation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.quotation_id_seq;
       public               postgres    false    220    4            =           0    0    quotation_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.quotation_id_seq OWNED BY public.quotation.id;
          public               postgres    false    219            �            1259    17253    sales    TABLE       CREATE TABLE public.sales (
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
    updated_date timestamp without time zone,
    user_id integer
);
    DROP TABLE public.sales;
       public         heap r       postgres    false    4            �            1259    17252    sales_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.sales_id_seq;
       public               postgres    false    4    218            >           0    0    sales_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;
          public               postgres    false    217            �            1259    17338    session    TABLE     �   CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);
    DROP TABLE public.session;
       public         heap r       postgres    false    4            �            1259    17572    status    TABLE     e   CREATE TABLE public.status (
    name character varying(255) NOT NULL,
    level integer NOT NULL
);
    DROP TABLE public.status;
       public         heap r       postgres    false    4            �            1259    17567 
   user_level    TABLE     i   CREATE TABLE public.user_level (
    name character varying(255) NOT NULL,
    level integer NOT NULL
);
    DROP TABLE public.user_level;
       public         heap r       postgres    false    4            �            1259    17561 
   user_roles    TABLE     �   CREATE TABLE public.user_roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    level integer NOT NULL,
    status integer NOT NULL
);
    DROP TABLE public.user_roles;
       public         heap r       postgres    false    4            �            1259    17560    user_roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.user_roles_id_seq;
       public               postgres    false    223    4            ?           0    0    user_roles_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;
          public               postgres    false    222            �            1259    17582    users    TABLE     �  CREATE TABLE public.users (
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
    DROP TABLE public.users;
       public         heap r       postgres    false    4            �            1259    17581    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               postgres    false    227    4            @           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               postgres    false    226            `           2604    17603    financial_target id    DEFAULT     z   ALTER TABLE ONLY public.financial_target ALTER COLUMN id SET DEFAULT nextval('public.financial_target_id_seq'::regclass);
 B   ALTER TABLE public.financial_target ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    229    229            Q           2604    17275    quotation id    DEFAULT     l   ALTER TABLE ONLY public.quotation ALTER COLUMN id SET DEFAULT nextval('public.quotation_id_seq'::regclass);
 ;   ALTER TABLE public.quotation ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    220    220            G           2604    17256    sales id    DEFAULT     d   ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);
 7   ALTER TABLE public.sales ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            [           2604    17564    user_roles id    DEFAULT     n   ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);
 <   ALTER TABLE public.user_roles ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    222    223            \           2604    17585    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    227    226    227            4          0    17732    company 
   TABLE DATA                 public               postgres    false    231   P       2          0    17600    financial_target 
   TABLE DATA                 public               postgres    false    229   rQ       )          0    17272 	   quotation 
   TABLE DATA                 public               postgres    false    220   UR       '          0    17253    sales 
   TABLE DATA                 public               postgres    false    218   HS       *          0    17338    session 
   TABLE DATA                 public               postgres    false    221   �U       .          0    17572    status 
   TABLE DATA                 public               postgres    false    225   FW       -          0    17567 
   user_level 
   TABLE DATA                 public               postgres    false    224   �W       ,          0    17561 
   user_roles 
   TABLE DATA                 public               postgres    false    223   #X       0          0    17582    users 
   TABLE DATA                 public               postgres    false    227   �X       A           0    0    company_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.company_id_seq', 1, false);
          public               postgres    false    230            B           0    0    financial_target_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.financial_target_id_seq', 2, true);
          public               postgres    false    228            C           0    0    quotation_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.quotation_id_seq', 2, true);
          public               postgres    false    219            D           0    0    sales_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.sales_id_seq', 18, true);
          public               postgres    false    217            E           0    0    user_roles_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.user_roles_id_seq', 1, false);
          public               postgres    false    222            F           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public               postgres    false    226            �           2606    17761    company company_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.company DROP CONSTRAINT company_pkey;
       public                 postgres    false    231            �           2606    17609 &   financial_target financial_target_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.financial_target
    ADD CONSTRAINT financial_target_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.financial_target DROP CONSTRAINT financial_target_pkey;
       public                 postgres    false    229                       2606    17288    quotation quotation_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT quotation_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.quotation DROP CONSTRAINT quotation_pkey;
       public                 postgres    false    220            }           2606    17270    sales sales_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.sales DROP CONSTRAINT sales_pkey;
       public                 postgres    false    218            �           2606    17344    session session_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);
 >   ALTER TABLE ONLY public.session DROP CONSTRAINT session_pkey;
       public                 postgres    false    221            �           2606    17576    status status_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (name);
 <   ALTER TABLE ONLY public.status DROP CONSTRAINT status_pkey;
       public                 postgres    false    225            �           2606    17571    user_level user_level_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.user_level
    ADD CONSTRAINT user_level_pkey PRIMARY KEY (name);
 D   ALTER TABLE ONLY public.user_level DROP CONSTRAINT user_level_pkey;
       public                 postgres    false    224            �           2606    17566    user_roles user_roles_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
       public                 postgres    false    223            �           2606    17596    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    227            �           2606    17598    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public                 postgres    false    227            �           1259    17345    idx_session_expire    INDEX     H   CREATE INDEX idx_session_expire ON public.session USING btree (expire);
 &   DROP INDEX public.idx_session_expire;
       public                 postgres    false    221            �           2620    17774    sales after_sales_insert    TRIGGER     �   CREATE TRIGGER after_sales_insert AFTER INSERT ON public.sales FOR EACH ROW EXECUTE FUNCTION public.update_financial_target_achieved();
 1   DROP TRIGGER after_sales_insert ON public.sales;
       public               postgres    false    232    218            �           2606    17610    financial_target fk_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.financial_target
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.financial_target DROP CONSTRAINT fk_user_id;
       public               postgres    false    227    4746    229            �           2606    17763    sales fk_user_id    FK CONSTRAINT     o   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);
 :   ALTER TABLE ONLY public.sales DROP CONSTRAINT fk_user_id;
       public               postgres    false    227    4746    218            �           2606    17768    quotation fk_user_id    FK CONSTRAINT     s   ALTER TABLE ONLY public.quotation
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);
 >   ALTER TABLE ONLY public.quotation DROP CONSTRAINT fk_user_id;
       public               postgres    false    220    227    4746            4   C  x�e�[o�@����f��ew`�/�WR�4���E)���}�jM&9�93ɜ@�㹂@��$߮Ȫ�tq�� \�cx�h�~M�t�)ʼ̮�TB5" �z�C���Y;8�z�_Y^�[n�q�~��B��N�����]Ox�0��;��ZbO��|�'#U���R�-{����ƭ��$ɩ�<�ma��X�t��ٖ�]�v���9�U���i�:���렋i��5M|���wv�~��,O	e��޴q�q�ۡ\����Xv�Y=ʈe1ʩ9���~\�n6q����a$'a0T0�@Fj��K����Tz�      2   �   x���AK�@����
i�l<�iՅ�&�Q&u[�f�[��P:0����F�f��B��"����{(�<�/�ƃKxZn7.T�E��Z�T)rT�k.%��R�ͰO4:�ݻ��F���<��9����+�X�����57[]�X[��is{��3���x9S�r�,��T�N�ףc&���{�!q����9d�)�o�      )   �   x��O]K�0}ﯸo�`-7i��*هJ&�U��m��jl��{�m"����q�=�r9\�Փ.���~S�m�޷]�ٶ����\)�	�i��IWu}�[�V�t�ml���1ph{;g���Nb�R�#N`FΝ%���r��n�Lՙח�q�e�k"� IN0g4�Ih�Sϊ�(�+���b]����!�#���qz���4OY�`������;� �;�      '   B  x�Ֆ�n�@���sG"�GӪ�e')�R��e��6E%q��>}9���UJj�]ɰ�]��?��vo?y`ٞO�:
-�#����ru���� �TT}���G��h���e�Ԭ�X����	­��[*%�,�$���~Z]&8��sVߦ�A9b����h`>�G�'��'W���u�R��r�u���4�qa	@��̤\�B/W��rٞ�586��ni�=X8`;�G˾7���	��?d"(�<y�y��u:�x���|�R-t�K�q�y4;U��ɻ���3�鶤�3�/.QRlZ67������t�4#k�)<��zw?���8.��0��ÏYM�U{�aL�`��rh]9UZz��n�t��u�s�z2-����n��I���|,r۹ޗ0�/yqo���u�q�"1(�qd#���9��g?�����f��%�f���qVKp�/΀G��\��&���h:�w��;���T�׍������)��0��XinXY�� 0�M,�D�,�ؘ�!�}Y`!�$}���oӨ�&ÚN���!52���m+���#�Ά줃[�Q_e��}{2�f��b      *   �  x���Mo�0𻟢��-֖�;9���)��� V%� �[�݇�x�2�zzҤ���<�i��L�u@��'Q(��,�l�mkd�M�W���M�R�x�9��(-�y,���Ɂ�;�,���0+�U�	�~�o��"k��>�
VB
	"2���D*��J��ສrg� ���`T������d���C��A��N%�8^�; ��5o�cݱ;�������>�v��a��/�i��y!n�L4/d�Â�e��v���{%_=�F1Z�|!�b�,����#�I������>�k __�=x���1���\�{�A�	��(�N�G�L�B�r%}�D��������5���,/:��^ov�.jQ,Q		���K�t.떛0
���⫁���/`�x��ۃh4>�)Z      .   ]   x���v
Q���W((M��L�+.I,)-Vs�	uV�PwL.�,KU�Q0�T��Sp��s��tQp�W�����s���$l�g^"� #�qq �)�      -   `   x���v
Q���W((M��L�+-N-��I-K�Qs�	uV�PwL���S�Q0�T��Sp��s��tQp�W�����s���$ΤP�� #�qq -�+      ,   g   x���v
Q���W((M��L�+-N-�/��I-Vs�	uV�0�QPwL���S�Q �5������|<�C\���C<<�ܭ�<�2�h^(Ph�^㸸 �6-%      0   �  x���Ko�@�����D+%d��i�1&���$Mv`�`^�����TG��."�fq�{ϧ3��(�
h����ϒ5�T�O���8���$n�^,���	� ���^���2�1���٥F����Fm�WV��Ƅ�X�/�(��6m�9�K4Z\Dr[Gj�߀~Uu��p��!fo!���Pb��4��ؾz?]h��6D D�J��$���� �i�tM^��	s5���H�u熲����˯��燭��b��W����M��lJa�I���Ν����O�;5v����H��;4�8�#���L�I,���%F�k�9�^�Uq�����ʱ��N���[:��%0�s�h��a�6�7���"���[s���<��^�}���	A]�pu���"ҭ�&�.�"��,�w�p�����]����o�j�0�K����Z�n+�[.|8��r�N�,����X`"!A��+�!�O���3 A�a$��!��r4z��O     