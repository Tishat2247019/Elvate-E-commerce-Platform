PGDMP      3                }            Elvate    17.4    17.4 �    >           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            @           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            A           1262    29556    Elvate    DATABASE     n   CREATE DATABASE "Elvate" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en-US';
    DROP DATABASE "Elvate";
                     postgres    false                        3079    29557 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                        false            B           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                             false    2            �           1247    29569    order_status_enum    TYPE     }   CREATE TYPE public.order_status_enum AS ENUM (
    'pending',
    'paid',
    'shipped',
    'delivered',
    'cancelled'
);
 $   DROP TYPE public.order_status_enum;
       public               postgres    false            �           1247    30080    product_review_status_enum    TYPE     i   CREATE TYPE public.product_review_status_enum AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);
 -   DROP TYPE public.product_review_status_enum;
       public               postgres    false            �           1247    29580    review_status_enum    TYPE     a   CREATE TYPE public.review_status_enum AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);
 %   DROP TYPE public.review_status_enum;
       public               postgres    false            �            1259    29587    address    TABLE     x  CREATE TABLE public.address (
    id integer NOT NULL,
    "fullName" character varying NOT NULL,
    street character varying NOT NULL,
    city character varying NOT NULL,
    state character varying NOT NULL,
    "postalCode" character varying NOT NULL,
    country character varying NOT NULL,
    "phoneNumber" character varying NOT NULL,
    "userId" integer NOT NULL
);
    DROP TABLE public.address;
       public         heap r       postgres    false            �            1259    29592    address_id_seq    SEQUENCE     �   CREATE SEQUENCE public.address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.address_id_seq;
       public               postgres    false    218            C           0    0    address_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.address_id_seq OWNED BY public.address.id;
          public               postgres    false    219            �            1259    29593    blacklist_tokens    TABLE     �   CREATE TABLE public.blacklist_tokens (
    id integer NOT NULL,
    token character varying NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);
 $   DROP TABLE public.blacklist_tokens;
       public         heap r       postgres    false            �            1259    29598    blacklist_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.blacklist_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.blacklist_tokens_id_seq;
       public               postgres    false    220            D           0    0    blacklist_tokens_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.blacklist_tokens_id_seq OWNED BY public.blacklist_tokens.id;
          public               postgres    false    221            �            1259    29599    category    TABLE       CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    parent_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_by integer
);
    DROP TABLE public.category;
       public         heap r       postgres    false            �            1259    29604    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public               postgres    false    222            E           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public               postgres    false    223            �            1259    29605 	   complaint    TABLE       CREATE TABLE public.complaint (
    id integer NOT NULL,
    user_id integer NOT NULL,
    message character varying NOT NULL,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.complaint;
       public         heap r       postgres    false            �            1259    29612    complaint_id_seq    SEQUENCE     �   CREATE SEQUENCE public.complaint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.complaint_id_seq;
       public               postgres    false    224            F           0    0    complaint_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.complaint_id_seq OWNED BY public.complaint.id;
          public               postgres    false    225            �            1259    29613    complaint_response    TABLE     �   CREATE TABLE public.complaint_response (
    id integer NOT NULL,
    response character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    given_by integer NOT NULL,
    "complaintId" integer
);
 &   DROP TABLE public.complaint_response;
       public         heap r       postgres    false            �            1259    29619    complaint_response_id_seq    SEQUENCE     �   CREATE SEQUENCE public.complaint_response_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.complaint_response_id_seq;
       public               postgres    false    226            G           0    0    complaint_response_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.complaint_response_id_seq OWNED BY public.complaint_response.id;
          public               postgres    false    227            �            1259    29620    coupons    TABLE       CREATE TABLE public.coupons (
    id integer NOT NULL,
    code character varying NOT NULL,
    type character varying NOT NULL,
    value numeric(10,2) NOT NULL,
    expiry_date date NOT NULL,
    usage_limit integer NOT NULL,
    usage_count integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.coupons;
       public         heap r       postgres    false            �            1259    29626    coupons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.coupons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.coupons_id_seq;
       public               postgres    false    228            H           0    0    coupons_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.coupons_id_seq OWNED BY public.coupons.id;
          public               postgres    false    229            �            1259    29627    flash_sales    TABLE       CREATE TABLE public.flash_sales (
    id integer NOT NULL,
    discount numeric(10,2) NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    product_id integer NOT NULL
);
    DROP TABLE public.flash_sales;
       public         heap r       postgres    false            �            1259    29631    flash_sales_id_seq    SEQUENCE     �   CREATE SEQUENCE public.flash_sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.flash_sales_id_seq;
       public               postgres    false    230            I           0    0    flash_sales_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.flash_sales_id_seq OWNED BY public.flash_sales.id;
          public               postgres    false    231                       1259    30111    notification    TABLE     2  CREATE TABLE public.notification (
    id integer NOT NULL,
    title character varying NOT NULL,
    message character varying NOT NULL,
    "isRead" boolean DEFAULT false NOT NULL,
    type character varying NOT NULL,
    data jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);
     DROP TABLE public.notification;
       public         heap r       postgres    false                       1259    30110    notification_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.notification_id_seq;
       public               postgres    false    269            J           0    0    notification_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;
          public               postgres    false    268            �            1259    29632    order    TABLE     �  CREATE TABLE public."order" (
    id integer NOT NULL,
    "totalAmount" numeric(10,2) NOT NULL,
    status public.order_status_enum DEFAULT 'pending'::public.order_status_enum NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "userId" integer NOT NULL,
    "shippingAddressFullname" character varying NOT NULL,
    "shippingAddressStreet" character varying NOT NULL,
    "shippingAddressCity" character varying NOT NULL,
    "shippingAddressState" character varying NOT NULL,
    "shippingAddressPostalcode" character varying NOT NULL,
    "shippingAddressCountry" character varying NOT NULL,
    "shippingAddressPhonenumber" character varying NOT NULL
);
    DROP TABLE public."order";
       public         heap r       postgres    false    908    908            �            1259    29640    order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.order_id_seq;
       public               postgres    false    232            K           0    0    order_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;
          public               postgres    false    233            �            1259    29641 
   order_item    TABLE     �   CREATE TABLE public.order_item (
    id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    "orderId" integer,
    "productId" integer
);
    DROP TABLE public.order_item;
       public         heap r       postgres    false            �            1259    29644    order_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.order_item_id_seq;
       public               postgres    false    234            L           0    0    order_item_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.order_item_id_seq OWNED BY public.order_item.id;
          public               postgres    false    235            �            1259    29645    order_status_history    TABLE     �   CREATE TABLE public.order_status_history (
    id integer NOT NULL,
    "previousStatus" character varying NOT NULL,
    "newStatus" character varying NOT NULL,
    "changedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "orderId" integer
);
 (   DROP TABLE public.order_status_history;
       public         heap r       postgres    false            �            1259    29651    order_status_history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_status_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.order_status_history_id_seq;
       public               postgres    false    236            M           0    0    order_status_history_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.order_status_history_id_seq OWNED BY public.order_status_history.id;
          public               postgres    false    237            �            1259    29652    password_reset    TABLE       CREATE TABLE public.password_reset (
    id integer NOT NULL,
    email character varying NOT NULL,
    otp character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);
 "   DROP TABLE public.password_reset;
       public         heap r       postgres    false            �            1259    29658    password_reset_id_seq    SEQUENCE     �   CREATE SEQUENCE public.password_reset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.password_reset_id_seq;
       public               postgres    false    238            N           0    0    password_reset_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.password_reset_id_seq OWNED BY public.password_reset.id;
          public               postgres    false    239            �            1259    29659    pending_user    TABLE     �   CREATE TABLE public.pending_user (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    otp character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);
     DROP TABLE public.pending_user;
       public         heap r       postgres    false            �            1259    29665    pending_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pending_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.pending_user_id_seq;
       public               postgres    false    240            O           0    0    pending_user_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.pending_user_id_seq OWNED BY public.pending_user.id;
          public               postgres    false    241            �            1259    29666    product    TABLE     �  CREATE TABLE public.product (
    id integer NOT NULL,
    title character varying NOT NULL,
    description character varying NOT NULL,
    base_price numeric NOT NULL,
    brand_id integer NOT NULL,
    category_id integer NOT NULL,
    created_by integer,
    updated_by integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.product;
       public         heap r       postgres    false            �            1259    29673    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public               postgres    false    242            P           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public               postgres    false    243            �            1259    29674    product_image    TABLE     �  CREATE TABLE public.product_image (
    id integer NOT NULL,
    product_id integer NOT NULL,
    variant_id integer NOT NULL,
    image_url text NOT NULL,
    is_main boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_by integer,
    created_by integer
);
 !   DROP TABLE public.product_image;
       public         heap r       postgres    false            �            1259    29682    product_image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.product_image_id_seq;
       public               postgres    false    244            Q           0    0    product_image_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.product_image_id_seq OWNED BY public.product_image.id;
          public               postgres    false    245            �            1259    29683    product_image_log    TABLE     Y  CREATE TABLE public.product_image_log (
    id integer NOT NULL,
    product_image_id integer NOT NULL,
    action character varying NOT NULL,
    previous_state jsonb,
    new_state jsonb,
    performed_by integer NOT NULL,
    performed_by_role character varying NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);
 %   DROP TABLE public.product_image_log;
       public         heap r       postgres    false            �            1259    29689    product_image_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_image_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.product_image_log_id_seq;
       public               postgres    false    246            R           0    0    product_image_log_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.product_image_log_id_seq OWNED BY public.product_image_log.id;
          public               postgres    false    247            �            1259    29690    product_log    TABLE     M  CREATE TABLE public.product_log (
    id integer NOT NULL,
    product_id integer NOT NULL,
    action character varying NOT NULL,
    previous_state jsonb,
    new_state jsonb,
    performed_by integer NOT NULL,
    performed_by_role character varying NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.product_log;
       public         heap r       postgres    false            �            1259    29696    product_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.product_log_id_seq;
       public               postgres    false    248            S           0    0    product_log_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.product_log_id_seq OWNED BY public.product_log.id;
          public               postgres    false    249                       1259    30088    product_review    TABLE     �  CREATE TABLE public.product_review (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    status public.product_review_status_enum DEFAULT 'PENDING'::public.product_review_status_enum NOT NULL,
    title character varying NOT NULL,
    description text NOT NULL,
    rating integer NOT NULL,
    recommender boolean DEFAULT false NOT NULL,
    "imageUrls" text[],
    created_at timestamp without time zone DEFAULT now() NOT NULL
);
 "   DROP TABLE public.product_review;
       public         heap r       postgres    false    986    986            
           1259    30087    product_review_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.product_review_id_seq;
       public               postgres    false    267            T           0    0    product_review_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.product_review_id_seq OWNED BY public.product_review.id;
          public               postgres    false    266            �            1259    29697    product_variant    TABLE     �   CREATE TABLE public.product_variant (
    id integer NOT NULL,
    product_id integer NOT NULL,
    variant_name character varying NOT NULL,
    price numeric NOT NULL,
    stock integer NOT NULL,
    sku character varying NOT NULL
);
 #   DROP TABLE public.product_variant;
       public         heap r       postgres    false            �            1259    29702    product_variant_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_variant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.product_variant_id_seq;
       public               postgres    false    250            U           0    0    product_variant_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.product_variant_id_seq OWNED BY public.product_variant.id;
          public               postgres    false    251            �            1259    29703    promo_code_usages    TABLE     �   CREATE TABLE public.promo_code_usages (
    id integer NOT NULL,
    user_id integer NOT NULL,
    coupon_id integer NOT NULL,
    used_at timestamp without time zone NOT NULL
);
 %   DROP TABLE public.promo_code_usages;
       public         heap r       postgres    false            �            1259    29706    promo_code_usages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.promo_code_usages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.promo_code_usages_id_seq;
       public               postgres    false    252            V           0    0    promo_code_usages_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.promo_code_usages_id_seq OWNED BY public.promo_code_usages.id;
          public               postgres    false    253            �            1259    29707    refresh_tokens    TABLE     �   CREATE TABLE public.refresh_tokens (
    token character varying NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    id integer NOT NULL,
    "userId" integer NOT NULL
);
 "   DROP TABLE public.refresh_tokens;
       public         heap r       postgres    false            �            1259    29712    refresh_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.refresh_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.refresh_tokens_id_seq;
       public               postgres    false    254            W           0    0    refresh_tokens_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;
          public               postgres    false    255                        1259    29713    review    TABLE     N  CREATE TABLE public.review (
    id integer NOT NULL,
    status public.review_status_enum DEFAULT 'PENDING'::public.review_status_enum NOT NULL,
    rating integer NOT NULL,
    comment text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL
);
    DROP TABLE public.review;
       public         heap r       postgres    false    911    911                       1259    29720    review_id_seq    SEQUENCE     �   CREATE SEQUENCE public.review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.review_id_seq;
       public               postgres    false    256            X           0    0    review_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.review_id_seq OWNED BY public.review.id;
          public               postgres    false    257                       1259    29721    user    TABLE     )  CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying DEFAULT 'user'::character varying NOT NULL,
    "lastLogin" timestamp without time zone,
    "lastLogout" timestamp without time zone
);
    DROP TABLE public."user";
       public         heap r       postgres    false            	           1259    29955 	   user_cart    TABLE       CREATE TABLE public.user_cart (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.user_cart;
       public         heap r       postgres    false                       1259    29954    user_cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_cart_id_seq;
       public               postgres    false    265            Y           0    0    user_cart_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.user_cart_id_seq OWNED BY public.user_cart.id;
          public               postgres    false    264                       1259    29733    user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public               postgres    false    258            Z           0    0    user_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;
          public               postgres    false    259                       1259    29734 	   user_logs    TABLE     2  CREATE TABLE public.user_logs (
    id integer NOT NULL,
    action character varying NOT NULL,
    ip_address character varying,
    user_agent text,
    success boolean DEFAULT true NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    "userId" integer,
    jwt_id integer
);
    DROP TABLE public.user_logs;
       public         heap r       postgres    false                       1259    29741    user_logs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_logs_id_seq;
       public               postgres    false    260            [           0    0    user_logs_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.user_logs_id_seq OWNED BY public.user_logs.id;
          public               postgres    false    261                       1259    29742    user_rewards    TABLE       CREATE TABLE public.user_rewards (
    id integer NOT NULL,
    user_id integer NOT NULL,
    balance integer NOT NULL,
    points integer NOT NULL,
    reason character varying NOT NULL,
    order_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);
     DROP TABLE public.user_rewards;
       public         heap r       postgres    false                       1259    29748    user_rewards_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.user_rewards_id_seq;
       public               postgres    false    262            \           0    0    user_rewards_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.user_rewards_id_seq OWNED BY public.user_rewards.id;
          public               postgres    false    263            �           2604    29749 
   address id    DEFAULT     h   ALTER TABLE ONLY public.address ALTER COLUMN id SET DEFAULT nextval('public.address_id_seq'::regclass);
 9   ALTER TABLE public.address ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    218            �           2604    29750    blacklist_tokens id    DEFAULT     z   ALTER TABLE ONLY public.blacklist_tokens ALTER COLUMN id SET DEFAULT nextval('public.blacklist_tokens_id_seq'::regclass);
 B   ALTER TABLE public.blacklist_tokens ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    220            �           2604    29751    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    222            �           2604    29752    complaint id    DEFAULT     l   ALTER TABLE ONLY public.complaint ALTER COLUMN id SET DEFAULT nextval('public.complaint_id_seq'::regclass);
 ;   ALTER TABLE public.complaint ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    225    224            �           2604    29753    complaint_response id    DEFAULT     ~   ALTER TABLE ONLY public.complaint_response ALTER COLUMN id SET DEFAULT nextval('public.complaint_response_id_seq'::regclass);
 D   ALTER TABLE public.complaint_response ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    227    226            �           2604    29754 
   coupons id    DEFAULT     h   ALTER TABLE ONLY public.coupons ALTER COLUMN id SET DEFAULT nextval('public.coupons_id_seq'::regclass);
 9   ALTER TABLE public.coupons ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    229    228            �           2604    29755    flash_sales id    DEFAULT     p   ALTER TABLE ONLY public.flash_sales ALTER COLUMN id SET DEFAULT nextval('public.flash_sales_id_seq'::regclass);
 =   ALTER TABLE public.flash_sales ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    231    230                        2604    30114    notification id    DEFAULT     r   ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);
 >   ALTER TABLE public.notification ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    269    268    269            �           2604    29756    order id    DEFAULT     f   ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);
 9   ALTER TABLE public."order" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    233    232            �           2604    29757    order_item id    DEFAULT     n   ALTER TABLE ONLY public.order_item ALTER COLUMN id SET DEFAULT nextval('public.order_item_id_seq'::regclass);
 <   ALTER TABLE public.order_item ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    235    234            �           2604    29758    order_status_history id    DEFAULT     �   ALTER TABLE ONLY public.order_status_history ALTER COLUMN id SET DEFAULT nextval('public.order_status_history_id_seq'::regclass);
 F   ALTER TABLE public.order_status_history ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    237    236            �           2604    29759    password_reset id    DEFAULT     v   ALTER TABLE ONLY public.password_reset ALTER COLUMN id SET DEFAULT nextval('public.password_reset_id_seq'::regclass);
 @   ALTER TABLE public.password_reset ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    239    238            �           2604    29760    pending_user id    DEFAULT     r   ALTER TABLE ONLY public.pending_user ALTER COLUMN id SET DEFAULT nextval('public.pending_user_id_seq'::regclass);
 >   ALTER TABLE public.pending_user ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    241    240                       2604    29761 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    243    242                       2604    29762    product_image id    DEFAULT     t   ALTER TABLE ONLY public.product_image ALTER COLUMN id SET DEFAULT nextval('public.product_image_id_seq'::regclass);
 ?   ALTER TABLE public.product_image ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    245    244                       2604    29763    product_image_log id    DEFAULT     |   ALTER TABLE ONLY public.product_image_log ALTER COLUMN id SET DEFAULT nextval('public.product_image_log_id_seq'::regclass);
 C   ALTER TABLE public.product_image_log ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    247    246            
           2604    29764    product_log id    DEFAULT     p   ALTER TABLE ONLY public.product_log ALTER COLUMN id SET DEFAULT nextval('public.product_log_id_seq'::regclass);
 =   ALTER TABLE public.product_log ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    249    248                       2604    30091    product_review id    DEFAULT     v   ALTER TABLE ONLY public.product_review ALTER COLUMN id SET DEFAULT nextval('public.product_review_id_seq'::regclass);
 @   ALTER TABLE public.product_review ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    267    266    267                       2604    29765    product_variant id    DEFAULT     x   ALTER TABLE ONLY public.product_variant ALTER COLUMN id SET DEFAULT nextval('public.product_variant_id_seq'::regclass);
 A   ALTER TABLE public.product_variant ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    251    250                       2604    29766    promo_code_usages id    DEFAULT     |   ALTER TABLE ONLY public.promo_code_usages ALTER COLUMN id SET DEFAULT nextval('public.promo_code_usages_id_seq'::regclass);
 C   ALTER TABLE public.promo_code_usages ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    253    252                       2604    29767    refresh_tokens id    DEFAULT     v   ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);
 @   ALTER TABLE public.refresh_tokens ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    255    254                       2604    29768 	   review id    DEFAULT     f   ALTER TABLE ONLY public.review ALTER COLUMN id SET DEFAULT nextval('public.review_id_seq'::regclass);
 8   ALTER TABLE public.review ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    257    256                       2604    29769    user id    DEFAULT     d   ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    259    258                       2604    29958    user_cart id    DEFAULT     l   ALTER TABLE ONLY public.user_cart ALTER COLUMN id SET DEFAULT nextval('public.user_cart_id_seq'::regclass);
 ;   ALTER TABLE public.user_cart ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    264    265    265                       2604    29771    user_logs id    DEFAULT     l   ALTER TABLE ONLY public.user_logs ALTER COLUMN id SET DEFAULT nextval('public.user_logs_id_seq'::regclass);
 ;   ALTER TABLE public.user_logs ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    261    260                       2604    29772    user_rewards id    DEFAULT     r   ALTER TABLE ONLY public.user_rewards ALTER COLUMN id SET DEFAULT nextval('public.user_rewards_id_seq'::regclass);
 >   ALTER TABLE public.user_rewards ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    263    262                      0    29587    address 
   TABLE DATA           v   COPY public.address (id, "fullName", street, city, state, "postalCode", country, "phoneNumber", "userId") FROM stdin;
    public               postgres    false    218   �      
          0    29593    blacklist_tokens 
   TABLE DATA           B   COPY public.blacklist_tokens (id, token, "expiresAt") FROM stdin;
    public               postgres    false    220   r                0    29599    category 
   TABLE DATA           [   COPY public.category (id, name, parent_id, created_at, updated_at, updated_by) FROM stdin;
    public               postgres    false    222   �                 0    29605 	   complaint 
   TABLE DATA           N   COPY public.complaint (id, user_id, message, status, "createdAt") FROM stdin;
    public               postgres    false    224   �!                0    29613    complaint_response 
   TABLE DATA           `   COPY public.complaint_response (id, response, "createdAt", given_by, "complaintId") FROM stdin;
    public               postgres    false    226   x"                0    29620    coupons 
   TABLE DATA           _   COPY public.coupons (id, code, type, value, expiry_date, usage_limit, usage_count) FROM stdin;
    public               postgres    false    228   �"                0    29627    flash_sales 
   TABLE DATA           `   COPY public.flash_sales (id, discount, start_time, end_time, is_active, product_id) FROM stdin;
    public               postgres    false    230   V#      ;          0    30111    notification 
   TABLE DATA           ]   COPY public.notification (id, title, message, "isRead", type, data, "createdAt") FROM stdin;
    public               postgres    false    269   �#                0    29632    order 
   TABLE DATA             COPY public."order" (id, "totalAmount", status, "createdAt", "updatedAt", "userId", "shippingAddressFullname", "shippingAddressStreet", "shippingAddressCity", "shippingAddressState", "shippingAddressPostalcode", "shippingAddressCountry", "shippingAddressPhonenumber") FROM stdin;
    public               postgres    false    232   %                0    29641 
   order_item 
   TABLE DATA           Q   COPY public.order_item (id, quantity, price, "orderId", "productId") FROM stdin;
    public               postgres    false    234   l)                0    29645    order_status_history 
   TABLE DATA           i   COPY public.order_status_history (id, "previousStatus", "newStatus", "changedAt", "orderId") FROM stdin;
    public               postgres    false    236   �,                0    29652    password_reset 
   TABLE DATA           R   COPY public.password_reset (id, email, otp, "createdAt", "expiresAt") FROM stdin;
    public               postgres    false    238   �,                0    29659    pending_user 
   TABLE DATA           M   COPY public.pending_user (id, email, password, otp, "createdAt") FROM stdin;
    public               postgres    false    240   -                 0    29666    product 
   TABLE DATA           �   COPY public.product (id, title, description, base_price, brand_id, category_id, created_by, updated_by, created_at, updated_at) FROM stdin;
    public               postgres    false    242   B2      "          0    29674    product_image 
   TABLE DATA           �   COPY public.product_image (id, product_id, variant_id, image_url, is_main, created_at, updated_at, updated_by, created_by) FROM stdin;
    public               postgres    false    244   .4      $          0    29683    product_image_log 
   TABLE DATA           �   COPY public.product_image_log (id, product_image_id, action, previous_state, new_state, performed_by, performed_by_role, "timestamp") FROM stdin;
    public               postgres    false    246   �:      &          0    29690    product_log 
   TABLE DATA           �   COPY public.product_log (id, product_id, action, previous_state, new_state, performed_by, performed_by_role, "timestamp") FROM stdin;
    public               postgres    false    248   �F      9          0    30088    product_review 
   TABLE DATA           �   COPY public.product_review (id, user_id, product_id, status, title, description, rating, recommender, "imageUrls", created_at) FROM stdin;
    public               postgres    false    267   K      (          0    29697    product_variant 
   TABLE DATA           Z   COPY public.product_variant (id, product_id, variant_name, price, stock, sku) FROM stdin;
    public               postgres    false    250   GN      *          0    29703    promo_code_usages 
   TABLE DATA           L   COPY public.promo_code_usages (id, user_id, coupon_id, used_at) FROM stdin;
    public               postgres    false    252   �N      ,          0    29707    refresh_tokens 
   TABLE DATA           J   COPY public.refresh_tokens (token, "expiresAt", id, "userId") FROM stdin;
    public               postgres    false    254   FO      .          0    29713    review 
   TABLE DATA           ^   COPY public.review (id, status, rating, comment, created_at, user_id, product_id) FROM stdin;
    public               postgres    false    256   �Z      0          0    29721    user 
   TABLE DATA           V   COPY public."user" (id, email, password, role, "lastLogin", "lastLogout") FROM stdin;
    public               postgres    false    258   �[      7          0    29955 	   user_cart 
   TABLE DATA           ^   COPY public.user_cart (id, user_id, product_id, quantity, created_at, updated_at) FROM stdin;
    public               postgres    false    265   �^      2          0    29734 	   user_logs 
   TABLE DATA           o   COPY public.user_logs (id, action, ip_address, user_agent, success, "timestamp", "userId", jwt_id) FROM stdin;
    public               postgres    false    260   M_      4          0    29742    user_rewards 
   TABLE DATA           b   COPY public.user_rewards (id, user_id, balance, points, reason, order_id, created_at) FROM stdin;
    public               postgres    false    262   �p      ]           0    0    address_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.address_id_seq', 20, true);
          public               postgres    false    219            ^           0    0    blacklist_tokens_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.blacklist_tokens_id_seq', 14, true);
          public               postgres    false    221            _           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 10, true);
          public               postgres    false    223            `           0    0    complaint_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.complaint_id_seq', 6, true);
          public               postgres    false    225            a           0    0    complaint_response_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.complaint_response_id_seq', 20, true);
          public               postgres    false    227            b           0    0    coupons_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.coupons_id_seq', 3, true);
          public               postgres    false    229            c           0    0    flash_sales_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.flash_sales_id_seq', 2, true);
          public               postgres    false    231            d           0    0    notification_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.notification_id_seq', 19, true);
          public               postgres    false    268            e           0    0    order_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.order_id_seq', 58, true);
          public               postgres    false    233            f           0    0    order_item_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.order_item_id_seq', 201, true);
          public               postgres    false    235            g           0    0    order_status_history_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.order_status_history_id_seq', 1, false);
          public               postgres    false    237            h           0    0    password_reset_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.password_reset_id_seq', 8, true);
          public               postgres    false    239            i           0    0    pending_user_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pending_user_id_seq', 92, true);
          public               postgres    false    241            j           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 34, true);
          public               postgres    false    243            k           0    0    product_image_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_image_id_seq', 117, true);
          public               postgres    false    245            l           0    0    product_image_log_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.product_image_log_id_seq', 81, true);
          public               postgres    false    247            m           0    0    product_log_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.product_log_id_seq', 31, true);
          public               postgres    false    249            n           0    0    product_review_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_review_id_seq', 26, true);
          public               postgres    false    266            o           0    0    product_variant_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.product_variant_id_seq', 16, true);
          public               postgres    false    251            p           0    0    promo_code_usages_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.promo_code_usages_id_seq', 6, true);
          public               postgres    false    253            q           0    0    refresh_tokens_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 203, true);
          public               postgres    false    255            r           0    0    review_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.review_id_seq', 6, true);
          public               postgres    false    257            s           0    0    user_cart_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_cart_id_seq', 15, true);
          public               postgres    false    264            t           0    0    user_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.user_id_seq', 79, true);
          public               postgres    false    259            u           0    0    user_logs_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.user_logs_id_seq', 307, true);
          public               postgres    false    261            v           0    0    user_rewards_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.user_rewards_id_seq', 3, true);
          public               postgres    false    263            D           2606    29774 0   product_image_log PK_0109e40e6c2cdcc891ee2f64ec2 
   CONSTRAINT     p   ALTER TABLE ONLY public.product_image_log
    ADD CONSTRAINT "PK_0109e40e6c2cdcc891ee2f64ec2" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.product_image_log DROP CONSTRAINT "PK_0109e40e6c2cdcc891ee2f64ec2";
       public                 postgres    false    246            6           2606    29776 $   order PK_1031171c13130102495201e3e20 
   CONSTRAINT     f   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_1031171c13130102495201e3e20" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "PK_1031171c13130102495201e3e20";
       public                 postgres    false    232            &           2606    29778 /   blacklist_tokens PK_1713bcba6ce8eec7cdb1c4fef44 
   CONSTRAINT     o   ALTER TABLE ONLY public.blacklist_tokens
    ADD CONSTRAINT "PK_1713bcba6ce8eec7cdb1c4fef44" PRIMARY KEY (id);
 [   ALTER TABLE ONLY public.blacklist_tokens DROP CONSTRAINT "PK_1713bcba6ce8eec7cdb1c4fef44";
       public                 postgres    false    220            H           2606    29780 .   product_variant PK_1ab69c9935c61f7c70791ae0a9f 
   CONSTRAINT     n   ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT "PK_1ab69c9935c61f7c70791ae0a9f" PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.product_variant DROP CONSTRAINT "PK_1ab69c9935c61f7c70791ae0a9f";
       public                 postgres    false    250            J           2606    29782 0   promo_code_usages PK_23c4867b2c9e4bbcf82d677c50b 
   CONSTRAINT     p   ALTER TABLE ONLY public.promo_code_usages
    ADD CONSTRAINT "PK_23c4867b2c9e4bbcf82d677c50b" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.promo_code_usages DROP CONSTRAINT "PK_23c4867b2c9e4bbcf82d677c50b";
       public                 postgres    false    252            N           2606    29784 %   review PK_2e4299a343a81574217255c00ca 
   CONSTRAINT     e   ALTER TABLE ONLY public.review
    ADD CONSTRAINT "PK_2e4299a343a81574217255c00ca" PRIMARY KEY (id);
 Q   ALTER TABLE ONLY public.review DROP CONSTRAINT "PK_2e4299a343a81574217255c00ca";
       public                 postgres    false    256            Z           2606    30098 -   product_review PK_6c00bd3bbee662e1f7a97dbce9a 
   CONSTRAINT     m   ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT "PK_6c00bd3bbee662e1f7a97dbce9a" PRIMARY KEY (id);
 Y   ALTER TABLE ONLY public.product_review DROP CONSTRAINT "PK_6c00bd3bbee662e1f7a97dbce9a";
       public                 postgres    false    267            4           2606    29786 *   flash_sales PK_70299593044ffcba05cc30b97dc 
   CONSTRAINT     j   ALTER TABLE ONLY public.flash_sales
    ADD CONSTRAINT "PK_70299593044ffcba05cc30b97dc" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.flash_sales DROP CONSTRAINT "PK_70299593044ffcba05cc30b97dc";
       public                 postgres    false    230            \           2606    30120 +   notification PK_705b6c7cdf9b2c2ff7ac7872cb7 
   CONSTRAINT     k   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT "PK_705b6c7cdf9b2c2ff7ac7872cb7" PRIMARY KEY (id);
 W   ALTER TABLE ONLY public.notification DROP CONSTRAINT "PK_705b6c7cdf9b2c2ff7ac7872cb7";
       public                 postgres    false    269            T           2606    29788 (   user_logs PK_773dbba6ad8ad2cdecfef243953 
   CONSTRAINT     h   ALTER TABLE ONLY public.user_logs
    ADD CONSTRAINT "PK_773dbba6ad8ad2cdecfef243953" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.user_logs DROP CONSTRAINT "PK_773dbba6ad8ad2cdecfef243953";
       public                 postgres    false    260            L           2606    29790 -   refresh_tokens PK_7d8bee0204106019488c4c50ffa 
   CONSTRAINT     m   ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT "PK_7d8bee0204106019488c4c50ffa" PRIMARY KEY (id);
 Y   ALTER TABLE ONLY public.refresh_tokens DROP CONSTRAINT "PK_7d8bee0204106019488c4c50ffa";
       public                 postgres    false    254            <           2606    29792 -   password_reset PK_8515e60a2cc41584fa4784f52ce 
   CONSTRAINT     m   ALTER TABLE ONLY public.password_reset
    ADD CONSTRAINT "PK_8515e60a2cc41584fa4784f52ce" PRIMARY KEY (id);
 Y   ALTER TABLE ONLY public.password_reset DROP CONSTRAINT "PK_8515e60a2cc41584fa4784f52ce";
       public                 postgres    false    238            V           2606    29794 +   user_rewards PK_86078010f64a891601beef7c54f 
   CONSTRAINT     k   ALTER TABLE ONLY public.user_rewards
    ADD CONSTRAINT "PK_86078010f64a891601beef7c54f" PRIMARY KEY (id);
 W   ALTER TABLE ONLY public.user_rewards DROP CONSTRAINT "PK_86078010f64a891601beef7c54f";
       public                 postgres    false    262            B           2606    29796 ,   product_image PK_99d98a80f57857d51b5f63c8240 
   CONSTRAINT     l   ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT "PK_99d98a80f57857d51b5f63c8240" PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.product_image DROP CONSTRAINT "PK_99d98a80f57857d51b5f63c8240";
       public                 postgres    false    244            (           2606    29798 '   category PK_9c4e4a89e3674fc9f382d733f03 
   CONSTRAINT     g   ALTER TABLE ONLY public.category
    ADD CONSTRAINT "PK_9c4e4a89e3674fc9f382d733f03" PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.category DROP CONSTRAINT "PK_9c4e4a89e3674fc9f382d733f03";
       public                 postgres    false    222            *           2606    29800 (   complaint PK_a9c8dbc2ab4988edcc2ff0a7337 
   CONSTRAINT     h   ALTER TABLE ONLY public.complaint
    ADD CONSTRAINT "PK_a9c8dbc2ab4988edcc2ff0a7337" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.complaint DROP CONSTRAINT "PK_a9c8dbc2ab4988edcc2ff0a7337";
       public                 postgres    false    224            @           2606    29802 &   product PK_bebc9158e480b949565b4dc7a82 
   CONSTRAINT     f   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PK_bebc9158e480b949565b4dc7a82" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.product DROP CONSTRAINT "PK_bebc9158e480b949565b4dc7a82";
       public                 postgres    false    242            X           2606    29962 (   user_cart PK_c506b756aa0682057bf66bdb3d3 
   CONSTRAINT     h   ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT "PK_c506b756aa0682057bf66bdb3d3" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.user_cart DROP CONSTRAINT "PK_c506b756aa0682057bf66bdb3d3";
       public                 postgres    false    265            P           2606    29806 #   user PK_cace4a159ff9f2512dd42373760 
   CONSTRAINT     e   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "PK_cace4a159ff9f2512dd42373760";
       public                 postgres    false    258            8           2606    29808 )   order_item PK_d01158fe15b1ead5c26fd7f4e90 
   CONSTRAINT     i   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT "PK_d01158fe15b1ead5c26fd7f4e90" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.order_item DROP CONSTRAINT "PK_d01158fe15b1ead5c26fd7f4e90";
       public                 postgres    false    234            F           2606    29810 *   product_log PK_d43f6188372b9260739b30c0133 
   CONSTRAINT     j   ALTER TABLE ONLY public.product_log
    ADD CONSTRAINT "PK_d43f6188372b9260739b30c0133" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.product_log DROP CONSTRAINT "PK_d43f6188372b9260739b30c0133";
       public                 postgres    false    248            0           2606    29812 &   coupons PK_d7ea8864a0150183770f3e9a8cb 
   CONSTRAINT     f   ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT "PK_d7ea8864a0150183770f3e9a8cb" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.coupons DROP CONSTRAINT "PK_d7ea8864a0150183770f3e9a8cb";
       public                 postgres    false    228            $           2606    29814 &   address PK_d92de1f82754668b5f5f5dd4fd5 
   CONSTRAINT     f   ALTER TABLE ONLY public.address
    ADD CONSTRAINT "PK_d92de1f82754668b5f5f5dd4fd5" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.address DROP CONSTRAINT "PK_d92de1f82754668b5f5f5dd4fd5";
       public                 postgres    false    218            :           2606    29816 3   order_status_history PK_e6c66d853f155531985fc4f6ec8 
   CONSTRAINT     s   ALTER TABLE ONLY public.order_status_history
    ADD CONSTRAINT "PK_e6c66d853f155531985fc4f6ec8" PRIMARY KEY (id);
 _   ALTER TABLE ONLY public.order_status_history DROP CONSTRAINT "PK_e6c66d853f155531985fc4f6ec8";
       public                 postgres    false    236            >           2606    29818 +   pending_user PK_ea2c9c5daf7f8339c58f5325734 
   CONSTRAINT     k   ALTER TABLE ONLY public.pending_user
    ADD CONSTRAINT "PK_ea2c9c5daf7f8339c58f5325734" PRIMARY KEY (id);
 W   ALTER TABLE ONLY public.pending_user DROP CONSTRAINT "PK_ea2c9c5daf7f8339c58f5325734";
       public                 postgres    false    240            ,           2606    29820 1   complaint_response PK_f6712870fb7b52964a75de380ae 
   CONSTRAINT     q   ALTER TABLE ONLY public.complaint_response
    ADD CONSTRAINT "PK_f6712870fb7b52964a75de380ae" PRIMARY KEY (id);
 ]   ALTER TABLE ONLY public.complaint_response DROP CONSTRAINT "PK_f6712870fb7b52964a75de380ae";
       public                 postgres    false    226            .           2606    29822 1   complaint_response REL_360fbfdcfc73664a804b59b6eb 
   CONSTRAINT     w   ALTER TABLE ONLY public.complaint_response
    ADD CONSTRAINT "REL_360fbfdcfc73664a804b59b6eb" UNIQUE ("complaintId");
 ]   ALTER TABLE ONLY public.complaint_response DROP CONSTRAINT "REL_360fbfdcfc73664a804b59b6eb";
       public                 postgres    false    226            2           2606    29824 &   coupons UQ_e025109230e82925843f2a14c48 
   CONSTRAINT     c   ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT "UQ_e025109230e82925843f2a14c48" UNIQUE (code);
 R   ALTER TABLE ONLY public.coupons DROP CONSTRAINT "UQ_e025109230e82925843f2a14c48";
       public                 postgres    false    228            R           2606    29826 #   user UQ_e12875dfb3b1d92d7d7c5377e22 
   CONSTRAINT     c   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22";
       public                 postgres    false    258            g           2606    29827 &   product FK_0dce9bc93c2d2c399982d04bef1    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_0dce9bc93c2d2c399982d04bef1" FOREIGN KEY (category_id) REFERENCES public.category(id);
 R   ALTER TABLE ONLY public.product DROP CONSTRAINT "FK_0dce9bc93c2d2c399982d04bef1";
       public               postgres    false    242    222    4904            ^           2606    29832 '   category FK_1117b4fcb3cd4abb4383e1c2743    FK CONSTRAINT     �   ALTER TABLE ONLY public.category
    ADD CONSTRAINT "FK_1117b4fcb3cd4abb4383e1c2743" FOREIGN KEY (parent_id) REFERENCES public.category(id);
 S   ALTER TABLE ONLY public.category DROP CONSTRAINT "FK_1117b4fcb3cd4abb4383e1c2743";
       public               postgres    false    222    222    4904            _           2606    29837 (   complaint FK_1ab3e07eb3ce33129dfb6d6af83    FK CONSTRAINT     �   ALTER TABLE ONLY public.complaint
    ADD CONSTRAINT "FK_1ab3e07eb3ce33129dfb6d6af83" FOREIGN KEY (user_id) REFERENCES public."user"(id);
 T   ALTER TABLE ONLY public.complaint DROP CONSTRAINT "FK_1ab3e07eb3ce33129dfb6d6af83";
       public               postgres    false    224    258    4944            q           2606    29842 (   user_logs FK_21c46c2b3ab66ef0773e5db3464    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_logs
    ADD CONSTRAINT "FK_21c46c2b3ab66ef0773e5db3464" FOREIGN KEY ("userId") REFERENCES public."user"(id);
 T   ALTER TABLE ONLY public.user_logs DROP CONSTRAINT "FK_21c46c2b3ab66ef0773e5db3464";
       public               postgres    false    4944    260    258            o           2606    29847 %   review FK_26b533e15b5f2334c96339a1f08    FK CONSTRAINT     �   ALTER TABLE ONLY public.review
    ADD CONSTRAINT "FK_26b533e15b5f2334c96339a1f08" FOREIGN KEY (product_id) REFERENCES public.product(id);
 Q   ALTER TABLE ONLY public.review DROP CONSTRAINT "FK_26b533e15b5f2334c96339a1f08";
       public               postgres    false    4928    242    256            `           2606    29852 1   complaint_response FK_360fbfdcfc73664a804b59b6eb1    FK CONSTRAINT     �   ALTER TABLE ONLY public.complaint_response
    ADD CONSTRAINT "FK_360fbfdcfc73664a804b59b6eb1" FOREIGN KEY ("complaintId") REFERENCES public.complaint(id);
 ]   ALTER TABLE ONLY public.complaint_response DROP CONSTRAINT "FK_360fbfdcfc73664a804b59b6eb1";
       public               postgres    false    226    224    4906            s           2606    29973 (   user_cart FK_39d1fccbe23fcb34a95ef4b6f6c    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT "FK_39d1fccbe23fcb34a95ef4b6f6c" FOREIGN KEY (product_id) REFERENCES public.product(id);
 T   ALTER TABLE ONLY public.user_cart DROP CONSTRAINT "FK_39d1fccbe23fcb34a95ef4b6f6c";
       public               postgres    false    265    4928    242            i           2606    29857 ,   product_image FK_59a7d2355ee55c185cc88b8a26d    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT "FK_59a7d2355ee55c185cc88b8a26d" FOREIGN KEY (variant_id) REFERENCES public.product_variant(id);
 X   ALTER TABLE ONLY public.product_image DROP CONSTRAINT "FK_59a7d2355ee55c185cc88b8a26d";
       public               postgres    false    250    4936    244            u           2606    30099 -   product_review FK_5f6c7c546f26cafa704aa7d5801    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT "FK_5f6c7c546f26cafa704aa7d5801" FOREIGN KEY (user_id) REFERENCES public."user"(id);
 Y   ALTER TABLE ONLY public.product_review DROP CONSTRAINT "FK_5f6c7c546f26cafa704aa7d5801";
       public               postgres    false    267    4944    258            d           2606    29862 )   order_item FK_646bf9ece6f45dbe41c203e06e0    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT "FK_646bf9ece6f45dbe41c203e06e0" FOREIGN KEY ("orderId") REFERENCES public."order"(id);
 U   ALTER TABLE ONLY public.order_item DROP CONSTRAINT "FK_646bf9ece6f45dbe41c203e06e0";
       public               postgres    false    232    4918    234            f           2606    29867 3   order_status_history FK_689db3835e5550e68d26ca32676    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_status_history
    ADD CONSTRAINT "FK_689db3835e5550e68d26ca32676" FOREIGN KEY ("orderId") REFERENCES public."order"(id);
 _   ALTER TABLE ONLY public.order_status_history DROP CONSTRAINT "FK_689db3835e5550e68d26ca32676";
       public               postgres    false    236    4918    232            b           2606    29872 *   flash_sales FK_68e8572774fc097c535d6441c94    FK CONSTRAINT     �   ALTER TABLE ONLY public.flash_sales
    ADD CONSTRAINT "FK_68e8572774fc097c535d6441c94" FOREIGN KEY (product_id) REFERENCES public.product(id);
 V   ALTER TABLE ONLY public.flash_sales DROP CONSTRAINT "FK_68e8572774fc097c535d6441c94";
       public               postgres    false    242    4928    230            p           2606    29882 %   review FK_81446f2ee100305f42645d4d6c2    FK CONSTRAINT     �   ALTER TABLE ONLY public.review
    ADD CONSTRAINT "FK_81446f2ee100305f42645d4d6c2" FOREIGN KEY (user_id) REFERENCES public."user"(id);
 Q   ALTER TABLE ONLY public.review DROP CONSTRAINT "FK_81446f2ee100305f42645d4d6c2";
       public               postgres    false    256    4944    258            a           2606    29887 1   complaint_response FK_89d50e91f3879f8d8203e6fea72    FK CONSTRAINT     �   ALTER TABLE ONLY public.complaint_response
    ADD CONSTRAINT "FK_89d50e91f3879f8d8203e6fea72" FOREIGN KEY (given_by) REFERENCES public."user"(id);
 ]   ALTER TABLE ONLY public.complaint_response DROP CONSTRAINT "FK_89d50e91f3879f8d8203e6fea72";
       public               postgres    false    226    258    4944            m           2606    29892 0   promo_code_usages FK_8e5c7604dc8d8ef10c2cb0e45ca    FK CONSTRAINT     �   ALTER TABLE ONLY public.promo_code_usages
    ADD CONSTRAINT "FK_8e5c7604dc8d8ef10c2cb0e45ca" FOREIGN KEY (coupon_id) REFERENCES public.coupons(id);
 \   ALTER TABLE ONLY public.promo_code_usages DROP CONSTRAINT "FK_8e5c7604dc8d8ef10c2cb0e45ca";
       public               postgres    false    4912    252    228            e           2606    30073 )   order_item FK_904370c093ceea4369659a3c810    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT "FK_904370c093ceea4369659a3c810" FOREIGN KEY ("productId") REFERENCES public.product(id);
 U   ALTER TABLE ONLY public.order_item DROP CONSTRAINT "FK_904370c093ceea4369659a3c810";
       public               postgres    false    234    4928    242            n           2606    29902 0   promo_code_usages FK_b2a9368ad108f5fd2296b9d3526    FK CONSTRAINT     �   ALTER TABLE ONLY public.promo_code_usages
    ADD CONSTRAINT "FK_b2a9368ad108f5fd2296b9d3526" FOREIGN KEY (user_id) REFERENCES public."user"(id);
 \   ALTER TABLE ONLY public.promo_code_usages DROP CONSTRAINT "FK_b2a9368ad108f5fd2296b9d3526";
       public               postgres    false    258    252    4944            h           2606    29907 &   product FK_b5effca691499d21c5ec683ced6    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_b5effca691499d21c5ec683ced6" FOREIGN KEY (created_by) REFERENCES public."user"(id);
 R   ALTER TABLE ONLY public.product DROP CONSTRAINT "FK_b5effca691499d21c5ec683ced6";
       public               postgres    false    242    258    4944            l           2606    29912 .   product_variant FK_ca67dd080aac5ecf99609960cd2    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT "FK_ca67dd080aac5ecf99609960cd2" FOREIGN KEY (product_id) REFERENCES public.product(id);
 Z   ALTER TABLE ONLY public.product_variant DROP CONSTRAINT "FK_ca67dd080aac5ecf99609960cd2";
       public               postgres    false    242    4928    250            c           2606    29917 $   order FK_caabe91507b3379c7ba73637b84    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_caabe91507b3379c7ba73637b84" FOREIGN KEY ("userId") REFERENCES public."user"(id);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "FK_caabe91507b3379c7ba73637b84";
       public               postgres    false    4944    258    232            r           2606    29922 +   user_rewards FK_cc6556a0f2fe56932c9187240de    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_rewards
    ADD CONSTRAINT "FK_cc6556a0f2fe56932c9187240de" FOREIGN KEY (user_id) REFERENCES public."user"(id);
 W   ALTER TABLE ONLY public.user_rewards DROP CONSTRAINT "FK_cc6556a0f2fe56932c9187240de";
       public               postgres    false    262    258    4944            ]           2606    29927 &   address FK_d25f1ea79e282cc8a42bd616aa3    FK CONSTRAINT     �   ALTER TABLE ONLY public.address
    ADD CONSTRAINT "FK_d25f1ea79e282cc8a42bd616aa3" FOREIGN KEY ("userId") REFERENCES public."user"(id);
 R   ALTER TABLE ONLY public.address DROP CONSTRAINT "FK_d25f1ea79e282cc8a42bd616aa3";
       public               postgres    false    218    258    4944            v           2606    30104 -   product_review FK_d7608150bffea47ff5caec8f265    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT "FK_d7608150bffea47ff5caec8f265" FOREIGN KEY (product_id) REFERENCES public.product(id);
 Y   ALTER TABLE ONLY public.product_review DROP CONSTRAINT "FK_d7608150bffea47ff5caec8f265";
       public               postgres    false    242    267    4928            j           2606    29932 ,   product_image FK_dbc7d9aa7ed42c9141b968a9ed3    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT "FK_dbc7d9aa7ed42c9141b968a9ed3" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.product_image DROP CONSTRAINT "FK_dbc7d9aa7ed42c9141b968a9ed3";
       public               postgres    false    4928    244    242            k           2606    29937 ,   product_image FK_ef6fbf7b57c1c7f81c957853d15    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT "FK_ef6fbf7b57c1c7f81c957853d15" FOREIGN KEY (created_by) REFERENCES public."user"(id);
 X   ALTER TABLE ONLY public.product_image DROP CONSTRAINT "FK_ef6fbf7b57c1c7f81c957853d15";
       public               postgres    false    258    4944    244            t           2606    29963 (   user_cart FK_f47da2f31dce6d741ab6c106f55    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_cart
    ADD CONSTRAINT "FK_f47da2f31dce6d741ab6c106f55" FOREIGN KEY (user_id) REFERENCES public."user"(id);
 T   ALTER TABLE ONLY public.user_cart DROP CONSTRAINT "FK_f47da2f31dce6d741ab6c106f55";
       public               postgres    false    258    265    4944               �   x��ұ��0��y�� T'iS�"@L�[|JJ#�5-�>H�t��t�`o�,�F�}���*-��l���	��ҹ>:���2T�m��.�Z�L���J(>J�Q��Ң�,�D�G��(,\����ϛ:�f��J6_�<�:8��<Z6���s�t�q���B��]��9��#��{V��e�jVmͩ����>����S�\	!�.�      
   /  x�Ֆm��8�?�b�����o(��i9(�����A�#ʯ_�����8�a&Y�IIH۴�����~I��6T���t��4H3���KM5^�U�3Յa?	F�s�Y���r����T�wa����
���Y��L����~�K��g��l6.��}��+��>Kd�%y�a�p����-�wW�C#�ե�\.M�W�|��K��ɦU?�SR�Ô���/,`� �m��"�"�2�����Ox4�Z:��R��b��d}�f��0��Hֹ����dI��<Nd�8=�#r
���m߇	��n�6�o���`sM�8*�U����i5�1�$q�����O�ʲ"'�1ܓ�,��{�͵����V����I�V/]d\d�.]!<L_��)w�
��J�A� �C"�~:���i����sܐ(��0���z�sƢ4�S�g��xsɫ���y��E 0���ҋa}�3,	��
�k��IY�W���;A\׽ڲ�������9|��"�������?�#���S=d�f�k=��3x��Y[�y���7�c���ߨTr��E�3�_��;]��R����m�Ѻ�b��mѲ��?"�vKWmx��&�L֐Le	��C�[��`��\���L"����j�Kj�"�;����J�<ǈVA�@�oFx}L�4�[���TElQ��w5��>tgU8�yȂ��l)�~Ge��K��"�'����Vv��N�<����a:���K��O����`q��a~��-��>J!��JL�GZt�"��&Y(��\s<o�%	�Bm5�X���P
i�)+y��kѷ^���=�-����R�=��٢�L�90�q
�ݻ�W���Ւ˰���}�f�n"���w�����Ir+����k|���o~�Cu[�ڏ"w�b�*���ٚ^���i`;���ɸ{�{?�jq�?�v��?iq���M���2Q0JV	�*d�O��t\q��6Q�$fm��+�� �[�d���c�oVb��򾜱����ڒ~lO�a��"���Q�M�Y��|>��赵�C�M,�ND�?���	{7         �   x�}�Mj�0F��)|�I���#�0�n%m�I`�Y����	��i	ȫ��?1����z�L�|��0�4.I1*f��/g���y��ո	�i���c�$EL��ˬ^��DT�xx�y�QĆ�%R	�TsA|:Cu� �S� c��\@����jx�����E�Ɛ��j�нt}��o�-�U��c���P�d��2j���DGӾ��h=n�Y�~�bi�JpD���N��>�;�i�1��Hv�         �   x���An� �5�b.`4`0�\��(�lT"C\���*��V��/���$H|-/�C�5�!�r�~��e�^+����q{Ԓ8	Br�A[@��j�QiO��l��y��۞o�`��Z�ߒ�h���t���zpI����t�I��qF�'��� �q�������E�ʇ���JJ��U|         d   x����	�0 �s3E�$1�o'�Ń�(
"t}�뻿�ڄm�6lǹ��5����:V$*�E�7����8�ߏ���K2���:���h�KVM���H�*`         Z   x�3�v�q56�H-JN�+ILO�46�30�4202�50�ʙppr��8�p��$� e�j�t�9A\.c�q�x�"�=... r�         E   x�3�46�30�4202�50�50T00�20�B�P00�2�"�Nc.#NS$=&X�BO�!W� 0�^      ;   ]  x���Kn�0�5>�Eױ<��_7�&}m��@$"�*��א�R�$�J���7#��e��7mQ�����H����WQ�ʶ��,�<oˬ�%]2}LҁO/�E����&J*ZH�P�+�
�v�)�����Uq�4ۑ[6����䛶�U���X��OLK.e�>�-s'��>���u��>�.H A9a���(%���ypF1��,H��0Zj��>���0��z��A ���� ��+G��YCFK��Y�����+��}�������U���O�?�V�G��>�����*J��2pg�M�|���=�i��u��0��k����4�oF�����a��1�R&V         D  x��Y=o#G�׿B}�?����I�TF�4�i/ Ȃ}��g�s��H��4.��y�C�#���p�N��韁���aG<������H�_���u�������i�Cr����2�p�8Z��"�m���FY�(�88e��҆(������2�CDkCnZl#%�*���hI\��ڐ�̈[9�/	k.Ԇ�I���h%�H�(K�%�d����7P��().U��!�B��R�(���"lC,R+v������y�x����{��2M?���K���0�������|x2���ï�/%R3�D��tUE
���D-�ބ4s̈́n��mUT/�5�$���!��QՊ�5�Xjf0���!E��\1�,l=93.��
�T��j�+gj��&Fe���3�c^�R��Q ��ܵY�Z��T�X�L=�Z�Q��R�$`��V\y��Ln��e��U���ڣ�&���9#u�v�!>���I4FJ��ѻ@�sϜ�E�G�I��P!����"�L��**҆f���6(��J%/��2���\6(Ҕ���B.�3j�AQN%�-EEZǨ	�+RI�֌H�T:
��x0B̋�"���g��nsE�ͻO�(�/=�X�����R��{ڣ�0��DK�ܩ>B��t,}�a�Z������] E����0왶��Sv���!W���n��V+-1�6Kr�ڏ�(V��TZ��F���d6ɥ ā�i�`0K	MpM��,Q�.�mH S�zS<�h�T��I���\b;ʮm�d����bH�����-_#�9����m�,���L�IT� �F�px}:���~�:�5> �_��>��'-����x�@�?�.���ېC��J��K������e�Bh��+0^A������+·�ӷ�x��Y�Vbp�y�k!��[_y4��8�Ƽȩ|^L���E�����D���ny���j�Yn���E4/���CچH;*뚴.j`Ņڐp��k5@�Xg�h"�p0,;v��bnB⼎/N�W4Q��u}��j�[�����=E�G~��̏�C�b*F=�8-W�0�-����HM(b=�������?��8n           x�e�[r�0D��Ť,����Z�PUj�9�nc��s�z�J�'���zS�
�/)7�K>��<a#��f�]�ӆ�`�ZmR&Ml�M�_%�*��9T�O�-��&O��͔<�)9{���	֓�4ϑ<Ŕ3{�J�4֞�?w+ѳ>���sQ
��q�T��)�ZL�3Z4f�X�H�z���U�-3Z,eTm{ʨ���Ѣ1��RF
�3eTm�{�hј�H),���"�##ДXΨ�g�ȶc����rF�G#gd�1��@SF`9#ۣ�3��GF�)#�������v�##Д�1��Iʈl;$g�h�h���Iʈl;$g�h�h�����oI�mGyrHǔ6L1��RyRND��6�Im��"��p'���Eɡ*����mQ)ŋD�[-D���U�U�Q�V�S5�U�U(����K�2*��:+[�RC�"�V�S՝ՄU(] 
m_H���b���o�Ft�\����/�D���S��nG�_:c�ٷ}�r�\��ϡt�2��o�N�k;c�9��9f����P5�vƴ�P:清�/D�ʷ��B��ھ�8U���J�����ʩ�mǴw���-���B�#c"�覌���M����0w_Ø_�F�T�k:��o����0�zV�w%fWO�pe���	s����̦���H���a������	��C������ӣ�9a�&'�{'�S�91���4H�O� ���/(F��$snV��v
��7��4�]Y%���k(!_@��t+@�W@G�}}0B̯��
���n����0M���%�������� : f            x������ � �         L   x���,�//�L345�pH�M���K���460�05�4202�50�54T02�2��26Գ0�016D�2�J�s��qqq �~         $  x����R9��GO�> *�Iݚ+x����ㄍ�ԚT^�m�aB����O}���M�������C��/���.���8�M�ll�ۂ�z�4��Z25#�Dea1 ���٬���| ��u �ά��B6�
��HxDԙ[n�\9�� �mX>Kd����
��3υg���B%���,��%Ge%8RWw���/�Ea�D���4"b�!B���ZR9�O��7$(��$�@b��
1i1��"�-�%�X��r��W�!ٛ
�0��H *ra���rA���9�5�  �k��x��1�%Lm$ �"��&^+LVs��z�|�pc(̑PC5茀�,3��M-q����ҾB�҄��-����%��b�AX�ʆ��sTeu���X������qCu��ժ�6(��)&i��W5�����ފC>(s� O�����<"�Td�ޢI�4ӔB��4Q�V��ZiF%9����	z�dM3ɵ6�D@�}^-I�^�_�����a{F(�;���
��Y1Kv��F��P+���������#u!�[�:�[�ۿ��|~z��ÏO����	�����.jT(��d)8^�}�QG����dG0�~>?-���@��G\n�Y5NhK�ӧ���eT��-�_�0�z%�O�z[���T�sĪR�X��`�H@�P��	Z��!:�\!H��Q2���I��g�c!��쨠I�I��8���(�ǯm�	rY����܋���\��]N.GEu���v�l;	=�_��S Cmu���T+��	G��	��#�f�(F��>-����v�mw�#���V�M�sX=�P_i�A�����8DW8�I�]�]/�e�$��G��(�
q��,*��y^D��1 ��B]��yz��cI`�������C^+9К����!"�*L��=�A0�VغR�#`ٟX�w�V]ن�}�D��d��N���9��g����=]4?�Ы}�yu�a�i:߮`�4�@�S}/Sf�蓅�'�+�ђ.��������"�N��c��`�����	�+�I���賜�=�f�ș �12��%T�C���W��
�M^���oݾ6���/�w0����n�IJ�Ǆss��C|L��v,9��C�����w
���5ӛ��X8�I+E�%!�/?�χ�r��������1� �6��vUu�rX�%k����p��:��q��R�jфsy�G���m���z�Z�e�eK��C�� ,����(������R�i�������ӗ�f�~�\��H���g�f����wN)��V�k          �  x�͖͎� �����"�~���U��q/(�u�8�lgW����&���lK#���0àȷ6��m�^j����Y���*t=��"������/��z
��uh=+��m�tܡ#Hd|_�	�O"� r-r-�p�NM2���$Z�G@���2��&0$a~�W��1EcS��$8�p�z�'��K�7�9������>Y`w�\�a�R�#"�QH@<�LAbmL�"�b9��_�%IT4�7�n(�z_�+߇�G�M��EO��E�{���h�.�����Ќ��VB�FB(����ۤ�pg%7a� ���R��k�W�e��CT�hL�k��93�h�(�3Hq��=9�u���]Q_y�!J�S�ٓ���ĸ�2Ǆ�"�/M[�{��@�Wˎ�����Y9d�"
��2�s��gZ��&L4n�\%�k�*�������W���A�t^^��\�ʄ�0�WN)�8�      "   l  x���]r�6�g�� `�����%I�6�6��N��wYA�%�|3f8у�f�3.vI�L N��<=��������??�|�������|��������㧏�������㏏�?������=|~����ϯ��~<����K��W��翂q�4%6�bl"Z�y��4}�������t >�U'�I�ɯ���u�%�&�]�}��%<�m�pJ5��j�%<մKx�y��T�r��/�Kx�w�Q���܀�'���.�!�i�Őa�e-d�vً��t�a���þ��G���}ݬD�M�����A��P��I���)� [kfŔ򫦋�84: �րc#�p�����:\*4չgZ�:��Z@���:]���?oE�΃�*؊:�n�Í�.�)�p���ő��ý2..�s��6����Y�r���\�ߞ~c9@T��v{�^E���d%���۱Ui�[Q�� ;6��6����1�e+:ڭ�;aa�=	rݬۡ����D��� e^1���bՎ��C�t��Q��(;��T�����r�9�a��[Q�S�C��>J^\� �ֻg{U��{�u��<��\�@�n��K����n�Qv1���in�y���=��V��:ʮyɋ�����f��E�����m�ݲ�)�Ƹe������}���dK !+u&�^��e�u{�{c�B�ƞ5z��c;�V���n��Ut�{��7s�?�b^/*4�����p�S�͢��p+�vd���=��f�Xj�;07O%�%�9�ve��T
"�G.�u;U�N�`+�ve'��h�;ωo��ռ�,]�s��<ʾ� �Or�盖�6�t�t��ճ}/ܴ�.U��g���7lE�n���y��{�P�X܏>��H5X��N�1t�	5Jf�&��e�+��V��1�����,n��]�S��nZ���H�6�NڨdmD�P[�sms5��a�i��$�wYz0s�) �
�:�tEW��3�l�%/-�Vt�s�������ҙo�]�ҙۄ]����)᝞���)ѝ����)�ґ��)������d��4,�P��٭<� <4�&�¶��h�(:�h^��0���?�D��o��n�QvVjs���+��ԚS�ybtu���k�E���}!�p��^E�n��!^�Z�������7/bn�n�Qvo�À|e��^�y����*��ew�VH='QÕQ�tE��y�*:ڡ��G�)g1/�4?c\{P�@�:����5s�Nvd�[U�׎f[v��t�^�D';�c���I-�9M���>y��Nve7���Tַ&���Kk���<�N(Yg8�n\w��F��\��]F�U�(�����v��	�ڙKt�� {�H+�.:��޲�R�<''�M1D��3RK~˵��/*#G^W�����H���]�m��c�����lE'z��gM*Yk$oص�_��)R3[�!/Q�Cdύ�Y�gX>�؁8�#](��d�Av䤰d�Yy�{��5^ڗ.щ���nT"�`�}c�P��#�%:�i���m/��/S��%C�Hpi_�D'{�{����X/��"g&pΝI���7��k��E���[�ɮ�������#Ȫ]**��2o��<�=~9�m�k�X~	�(�6?{�_�;oEG������?�MC$      $   :  x�ݝKo7���Oa���b=X�9�ؓO� �l)���H�X�oq�ٱ��5-ȭ:���r�7�d��"H�x}~z{�~�W��ۋ���7 �x������Ӌ��ןO/o�������������_���N9w}ޞ�]]~9=�9Y_�9e1����#�gdf�~���������j�˘��߁�JYM�����W�_��>޾_��o	굻��N��'?ԛ�|wy�~?��8���o�J�N�>]|N[Oo��� ��{gZ܄� ʯ��W7����?O?]]�O�|����,���Ͽ\��0�]��*�T���0Gs��6���H��M\�->�����I�`�ڈr�r�.�7_��嗋��������??��y{z����������M��Onn�\����p���o�oO��>\^|�|���0����LE��@MZ�r�އ�e����p�7@O j8p��=p�����wa!2b��8�p�r�� #�V(5�?J�m��-=D.k�qe�DCI�\�3��B�[���ʴB�r����5�����Il�$؀��������t�/�]ȱ�Ƴ�WW�?hj��E�/�}$ϖ3u×���k<~���2Xn�ߛ0�p�7?���A4���c���<���4��eÏ�%[�q+[7|��pw�gï�JF 'id�ҝU� �
���Nt�юH0��07 ���'@?��C���8����� �5�ۢ�;��L\���c���G���x6��/)�C|F��ߗ�CT�|�͊
<���?~#ЌP҆��+���G�[P7~�J9*�|h<�e9�N�[�d����X{E馏Ǌ�����W_dB����K�[��k4b�i�w�=������?~��� ��!�tɂ�J\��
�Ag�o+�r+������0�2�&mH.]��r`���O7�2EWu,���|�՗	��kI�K�,����!vC�p7~�|�5�Ѕk<����Cuy�Ɗ���X���?J(_���G'�V�مk<��:ۃ9iC��5�C<�0��S�'�W���o�����ɀ���yuɚ7��(\20x�K|��6is����x>��p�1iC��5�e�8��E����W,�ȷ�΃��ÿ�B8 %Ng��G-��ȕڗ^��l�9G.?it&�r]H��E��!=��M�3=j�a���bt�$١��N5K6�+˓�f�QԆ�A��b�*(30D��W��`�W��7��P�·j2�D:��v�>L%n���4gZ�N�Z�C��t�v>S�b��aj@K�ô�,jY����u�v6T��Q(�~O�wG��\�B�����n�2���v>V��N��r��ڞ�^(V�� NO�vm�c�HМ3�c;Xۓ�K�J���QX��ǪS��"Z1�bmO:/k�<�<=	ص���sdV9�D	vu�a�ﲭ��H���!�a;+N�	�
qUv��'���u-:	V%�Nh̿�W-���9�?tցJݱ����ȫC�b}➆�X#��#X%��������W����˫9E��i�]) �H��/	u��9 Z��ſ�P�W$�R-/LU&ps��<��W��R����6�{�8'�����^�/:k+�SfG��!��W��R���SV)�c��W^�XU�u���20%܅����P�L�I݇�SޕV�Z��Ҩ�D��c��()���,� 4R���(.຋��ɛ%Ũ���w���NR�߻�luT�d��b[nMq��#qqԞ�T� cԑVmG���l��U��O�5j�m�5�?�ݏ��5��)�HS�����z6�př1�ߒ5j�m�5�?1C���-w��I�u�E���l��с=Y��ؖ[S\���Z�z�S&ʭ��>�[���������D��������ȼIp(��Q)l˭.���h�Yr��b�K]�O��g�`L?0����$G��5*�m���[�3bu������K���7�s�]Y�C�d�Ba[n�p�W`��K���s �=@��[��]��Ƴ�WW�E���u¶�:�J��H*?�ӧIr+�颿5�M��B$JI�б�dkJ�i�<��h7}�r������x6��`�2���b}�*֔3��9��=Kϑ~�����7�� _ �#����K�A_��Rĳ��������l����X��kX�*�XF��G�o���c��c�ֳ�o\�3œ7$�/X�}�"!a9~��7�S[O<�4l���l��U��2HN�����[�PQ]2 �����2��q,}��ֳ�WW��@���K݀/�qG,����O`ߞ��e�,3�W����R�,u+}/6�"]G/����iG���g�W�3� ���u}�Z7�k��h�@
֧�j�m�'��ڶ�����H���������Hb�����}�MZ9g/���3�7!��%An�ݸ��/�"����;�R��I�`��:��:�c<��ڕ9� ��7..�?@���EcX?�r�����x6��*n����мqq��1CĿ"I(���_7���:�o����4��߂C���e���#�Qt��[xMȭ���x6��ʽ�ugdC���E�',��p$B���4���o������As�o߸�l�">
��@`��>�S4�X�[����+��kP��W��E�_��SGA+RG{�G�����������z�F^��%��]�B�hg�Hm�O�-�=��Ƴ��z�����7..���ݏ�1�b��ZUݜt����\�kWià��7..����ȁJe��~׈5�W���l�Օ���������`!��%����?�#�G�����p�W���������"����$�Ȃ��mzt��5~�� n������}䰉��7��������D��t����_]X��-��ȩK�O�}T��-k�C�R+���1~�JR�-���9?�}���=��!���7!ʈ�.�
�<��'���[�G�G{Sϯ�"g����A-����G��ʱ�rA��˿L(���>�[����+��B�6_l��f×�O1�F�3j�
U���/������DҖ�,�W�Dx�i����j�      &   
  x��Mo�8���|n	�?u�aO�E��(��R�d�Ew�����AmY�J���pV������X� %�E��e��`\��]:�����/��U9������w7��/U>+n��5_���j<|h�{(��u������j2�kC��u^�X�G�R��a5^���,v�g^�rY��yQN���z��ŷ|6,�t�O�*O�ʼ^U�rp�s㍮�L�b:�%�мW�e�2�V�z'�w3ag8����ibW0(/��x�r˔6O>M�^�泲��9R8�x�%��:��茘�N��	�dX��>�x�j��F苍�e<mS��;*>DU�]�7� TJ=���p�?�,�y�փv�:S�H�D��Iж(���R���PIM*�6Aע�5��U����E��:h��)b���ΐ#+\��E��:���)��)uA�C���kuFON�������ꁤ
�-2p�P-n��$��+�QV��R��I�$��W�������ѷy�y�7̌	����v����vg7��S@���Q�xkR:�'5+=�}ߺ}v����P�젵��[o�i��Q$������E��+��`3F��V0Wj��f�����ɰYei�(\Ve	[e���w[���:$�Waz��Ɉ��|.s\'�ȞO�_�\�4#�'-Ǭy�u�Y.�m�ѧmh�|�c��6���ݝ�p�����k��ۆ\<;^B����2��@�{G�!ĳ�ۋh����m�& /��.�����$���ޕ^'�J側HW��$hx_��9��J�m	�L[i����x΢�G���3A��B�؆���W j�5@>���`l��@�/������'u1A�9T��o��������mP>	����̵S��c^M�I�i4o�.�U>ߩk����WG�d���o�̀2��uP����e���f4^��ajku˨�=�}U*���B�fD�+����3z����Ӟ�Fv��zD���<A��4�����V�O6OgT�F�c�#/2����wк͘<I���Y
!�˱�      9   )  x��VMo�8=K�B��*���TNE�v{�f7EOZ�cŲ���������V���
�@��y�3&� �z�����_���Ζ}�E�7�4N*��X[&�)�o�u_���F7��h��h��'"��g)�hN!'e\a)�,�g`{�����0?&m��L� �$v�6n@��A����K���q�����m@|U�3�1G ��՛�������2z����)�n�����k�����Z�/��U�>��my���N����ի@v�;��Y�aaW���m���b�̾2�j�SRH�D/J�/��:�U�zF8� G�#�Y�X�,EN�����"~����k�[���E�����"�q慓P9c3ȸ��Ó@��{���}֟��4g)��XM���tA�~W��^u+���
��\�μ�U� L�A'�	�?�S����ʙͤ%3`��,]^��+��[���`ƫa���������\��q���������%�mo��E|8�)�1�4��Q<��/�~P
�!��c ��?y�圙ʨbR���͘���Ζ�5�o��R��5Χ��7iak�R]�7�1Nw!�K�EDj�g9"l(%��lH�?I2&��$`�Y($���DSU�DVaP4m�a�����&/�	"J!b��J?G��8�8
�D�����h�"��F��M��@p5���ц��XL��`<�)&Y�fF�A$b��1!��6y~4�HQ�A��#�u_lB�:�&T���m�aP*�P>$���N����Ӿ��P�Z���h��q�/�F�      (   �   x���;�0���9E.�*Σ��Q%66�%U�ޟJ5���؎���4��l�q�3g@m|�=8� ��V�o�󵫔Ba��2����4���@����G�r�iX[�V����1n�}ON�*���O��t�p�p�@��j!��h��      *   @   x�3�4B##]C]CSC+c+.#N#Nc�2@QzL�:��1�4�!c�i�C&F��� �A�      ,   �  x�ՙis���?�E������7A�2�X��TFG�_79C'&��:I���Vu���y���ŶѓP�R3�5�ՠ�j�`�h�qZ^.�C]���#zބ{�t��J���R�l��*T�[@�W-�҈��Zv��C�	� �N߾�}6%���J�l�r�b7�X�.�~�v��0Z��-��P���Uw�Ix���&%ޱ2+��h?���]��M��]�h@�@=��O�>(ĲO��m���p��F��4v�k(6[W8�GjZIc~!g+y[�A8ZW�qeF�䍗�\�/)!�#��B��'}=e�̷��q�],w̖M�u|���%��6�Nn ��ļw��㵽������P�bɳ�����}JP��
�2Z�Ys*���TA:_^�9U����ٱ��J����=d���l��8 j�fI[R�.
9����ҳ���\�i�,e]`s���$��G	�~b������7���U&)˻��m��~����^����۞tfk����[>~�d�>-R"�<1�WS��V��H��,f0��D�]G��Ex��v�LѯA����w�*S�`cZ��U���+�G4�x��<��R7��/.ӽq���g	�^���}�v��ޡHVZt^EZkk���Ǔ��'s9��b&]흓��Nmf��D���^�3�_e*���G,�8���O�W�E�t[*��0�ZjxM�3â��7�Bd��ܫ#���n7����E����4(��X��t?-C#�P�Ci1�C�1H��F�̅�g�Ŵ��x�M�Tm���v�8ၒ$)D�e��M�sltiI�d�W���K���(��C�E���$���Ƶ�T�r�T�*��Õb
�΢�*�KM����`����������pWD�������͛�����Bd�wF� �
�q��o ��� J�8��}���Ӆ[mf'8�����7ܨ��t�M�G�@2]�Ґ$)�0���SD�*kdћ<}�wd���+��^,��d��̅�R�����3��UZ/���)�>�SCz�'�2��eB��T08��R�C��4�hڍ�Ri�NT�~��gtJ�}�:����#H~�؎����Q�e��ԙ;m�j�Z@tb���G�*��S��jxw�![�l��Ӊ��J )I�4�	}Y�2���xS���9$���b��І�1�jԡ��3��΁���M_el�����	��3�� �xS���� ����\�X��*�#^r�;�g�7V�ەRT�{� �,%����y�!��4�2�Er)��������*k����o�k�m�@�B@xB��f��IQS�j8�)��Y%�%�na�9]���d�� �$sw�k��% �d=���y(|`;�M3oj����u5;��������8������n�M;n^*uK;�`w����F\7�25����ɰoR��H�����C���t7
N��|�@�J'I"C��E��w�&�^v֛��y��=ԇ���댍�t��ߴ\5TY��8d�Yz���U�F8���0F�X��[а;l@�G"I�'>�E?�#��9����&���ug)ۘV����k}�����8q�X�h�i�[-�_N���N�3�B4������ˈ�J8$��F�W�y���X�Ş|��>ƒ�®G�X�w����Z3�]L�҈;xo��n�n�c1ZԮ���-�rKCBK�ѡ�S\\��{Д_E�;A���.�땔/��&�=��U�z �qr�9iS�ccw�ϙ!m��9�D�Gbw�cyU����1�ߢ��?��C�,u�^�<W"˳��-R*�l'Y��uѵ����^�;]-����TlG�\P���Zp��cH���I��_G��h��V)���v�%��r3 �O�e�N�{������.����{Ԃ��-Y� )"H�`� ��H��A���"��� ������:N�@�g�-w�k/[�C��_JA���ODt��Y�������/��Zd�	�׾��\b,q�"��XM�'��aχF>�?OyX/�\�U��^ғ��.�.�?xR�[�z�-K�WF�w��)�M��zvtw��lf��v���������jQLq�,_�?��q�4�������{4�I�CW@����T6�O��,��6�ؽ7G���|���ƛ����@}�C�C
�{6��>-P ����~~���tq�W	�]��]�?[��"/�����^�M�X�>�ML��27X�����rh@�y��p�퉞߭q�'.wK����Y!�(�!�ѝ?���������0L��o�D5�]s���V��U6��Σ�6V�D�θ=�����`E����ζ#W�=ѐ��Ȥ�'Ew5��e��l�5����g�V���Ŗ�i>-��'�oV��:��g^蟼���n�>лQg��.�G)�Ke�qy~�s+�t�M��w�2'��dR��i+~���!�l�h
!{�~��#��������./���`���HG��Yٮ�k��\O�A�_J������E�'C����%@��D
Ab	>q0��.�C�`_�kU�D�E��$k�^e>��#�J�<Y����wS)eVv:�<tՓ~����wg�<$�{V��+eH]�SD�니����%�t;"�#m�i����Hs�\�#��{�,&a�)�T�1���Ӭ���h�g,����lg�i�y�BR7�E���MC��q�.���は����������,W7����[=J�u�����_O��F����FԤ��C����ދp8S�q����߆�4-W�v�p����jv:4,b|���3dA�($���_T2r�w��pgB���RN��ۉ[O��=���Y-��t�Mz��.��^�aA� ���u^��a�L�_�;i�����{m&�*�#�8���S5��d+��^
��۳�4�q���D�g��^��۷o�$��      .   �   x��бn�@��~�{N��w���RPĒD�X�	5��cQ�U�f�bɟ�_�c?����nZ����auLU�r񚬙  c���-��/��e����zv��2?O�?�!MU�JY�1�:&��8�(5$��pa�������09��5��B��5��G	k�R)�l�4�$�?}G#�J�M����#���e�      0      x��UKv�@\���7��a`��ތ%lF��Jr�t� %�{ZU3՟�n91��y��`�oCً��K2�~-¹��>�6!��g��X��9�|h�g\}�!C���� U� WX+1wS%��6���a�T~]�S��U�<w���k]N_^�0ܺ�L����T���X��OܤHe�B+I�$�%���8V�<��%'�1�=/e��;�SDJW�� �8M<U��%�>t톾�}=ε��;�}�~��\ZKD��RK�
e��:qZ���ź���p�%�5�)��S�Z+����Ȭ�I��B+CK�;X�aˮ,����K��7�N�#�<O�\��ֆ�f��?1t�*9V]vMN��C��0���")l�ՑY��WCy��%�~�;�t����<=Cj#�B���L�dZtu|��oU����1�¬���,
R��6�b�9��lU����iP��e?����C�[psЊ��R�Ͳ,K2+�{�M�Ǹ����+��+ϒ�^Im���q���XS�|ׇ!sh���e����@�e"Ṭ� _C�aCK1F|1�i�}~W����w�����.�(�l��P�+�p�[IH�c��O	a�g÷�~-���&V�2a��5�q���*��e��R��l�'#�U�Mz�^F|w��Sr�v�����w�Q��wt�P��D�k  ��>��?�7����j�vv���R���a����n��C�\:���q�� �&B+��P��j�vS&���
|�]�{�I��!��`      7   j   x�}���0��Y ��H��Y��uP�hQ�~�G�����d��l����	�� �-�ì��A����^}�֪I�~����_���R#�Z���,�<TD��$
      2      x��]Kod��^K���	�^$��r��pl\8�	L2R"d22���������C=� n�^�5�>��Ū"ܼy���ۛ?���}����U�� ����Uo�n���=�%+K�a�~����׫�?~|���_w_��i�����c�� pC����!��*�������_.�ɞ�qA!�˽��l�>�%"'�B'��tQ
uO�C<~�p�`�SXA��7�:�;C�;2�����Z$J#b{0��!�T7�E�D�L��n����=��vI�W3(�v�$���XS[�b�I��b�eàRRj�wP.�AwI�!V� y�i�&��y��Ǡ���M{�E��P10b���^x�lg����AI5�S	IF;3cPR]�,��k�qr}!�H;�)�B0I��`���b�i�0]�2=�t���
e*0�'��SSŘ� ��\5v��%P����V0�0����hH�;�I��f��ȭ�͗R�d���:�K�̢�!������K�`!�1�l\��+�t�7xK�"{�Sor)v^�b�bp�`D샙5_1�T�a�yW����W�!Ml���;��*cHߎ��M�;ʯ�\&��s�����4�a�iS�R�5��C��`���
U�&�&`��`��"��/�VbZ�`�)A's]��产�bj�O(n5�bPJ¶C�yPdV�b��j�tX0#�ǃb��|r] D�����ww��>��W�������0�{�K2�4�1M$/S�n���w�a5'2(����vGbS�uy�g����E�34�H��Һ>�28���<���nT���7�)Q�g�_@�����s�4$�X�XDuǭP��aZ<�79b[֐ls�M���ZMAR��5�}�:c�j�
�r�̢�91{�R1���`jS���qH�%� i�.qHS�Э+����Â�,ЬZ����1�%c\?퐘R����rnCbZ0lKM��r�Cb�b�V�������Ĕ��1�dǅ �PMAӊ!�*C��iHLWS mV-I�
aΗyM�uM�R��O\65��̏�ʩ�@r��"�s�Jk�#BmfTPy_�X;s�
jT�>��Z���C�UO/��UX2Q̓���S�S4�<w�Ƀ�jfa̩�1k�r�E��z�	EIƐ�r���c����d�`��<�DVs�*Ɛ�Vq��|0S�n�Ղb��O���67�j���f�t��dHZ�x(h�	��Ҋ2$�+��;j�Z�F:$��Q�k���"�;�C�ZQ�rY����!y�G��S���9D:(���"/VE���
EHL�WV2�uC��D0�7g�XOXb&�8��
:(�E=��T�K}I*�B�=�HS�^��V������P!ʯ��Q�0�s��EX�y6��a�W�K��|p��!�����d��
���*و��@x^�� �>G<W�LQW�Ϻs��C��(G6��>6�����޼y���W�_����������ǝ��ov������׻o���ݟ����Ç�My-w��������{��ϻ����ퟏ�������O�w��W���=��r��9�;����<�8���'�rf�<O�9x��iD�y"�=Os,��5���l�:EN����<cD�����U�<5&�~��e�����@�6�<+O
O��՘��h�����yiF�@��y��eO� h�ݾr��K�p��z.L[pa\��F���H��6�f�����f�K�"EI�:��̐_�x:�sN�����P����G�ⴕ�tfKR�����s:3TyzjLA�s4�*<1,9�m?�3C���I$��[yN�BK�̺����Q��~������Q���0�n5O1�A3f�M˟���6O��&���]�S�W3��^�*��Oj���r�dN�fhw'�I����:i����&4<^��!�n iB�C��l��W7��)K
̽`hB�Syj͝'Ohy�g\ m����ʓ�r������3��'4>�g���<aTYj�q�%�	� �Y.:�׍�h�
O�[�>���o����i��
����sNcd<����ɜ��x��Q��<U[<O^BL~ɾ��O��xM�4F�3*{���sNs�Iq�̐9͑wB̛9�9͑7�i�xNj��I�q���\���Z�_p����Z-���B�?D^�v�\FBJQx����\Fb���Shf�;1q.#�g���c��Ht��Pμ�r�\Fb�)���r�x�e$:O��J�ij�9���<�:<q�\F��T;���+�狢԰x)�x�{i�iջp���$y�� ���M`��>Sp���y+�\�6��'��U@���O�Z�h�W���8fw������X-m����s[��B��I�/��+�+��u�'A�<��3�B��;��bƱ�<_�}$y�	�R�2t�V��j�m CG����U�ȉ��^�9�K���-�B���9�&'y��P�y�<�a��Q���a�J�Vzs9ZF(@I�y �#�<���yꢚd+G�s9+O
��ʼ�\N��1H�"�<Wf�	OҒl�9Wf��%��ZI�
z+��&*
���\�X����[�Q�y��Ԕ3�c�sż+O;Fb����Nh�<���l��:�5�!�٣��Oh��^��v��Z#��M�����T?�<=r��[w��9O�����:0Lh���-���	͑�[�qk�ñ��C^kfbn����a��ŕ������y���,�P����v]�`n K��OH��s�	sX�u�4�|����fS_�T��ǬO��X�\t
���̺��#�$7�8Y�ԓp�M�>�{�u�نB%��%�v�.L�=X%�J��K����Q8WC&����sꍣ�	�*i��!��4�ɢ>f�9�o��LKzH�s5dv�~����w�ʷ�x�B��w���}#��I�v'��襨��q/��c��y��T�'��������}�����k��������/}y�7`�ۈ�'é�O�h��Ue�i�=d9� C��Jz�Z�W��>X��ˎ.b?�����Nv��������������[ѽ�lq��g��/�>�
�����@չ�#��cԖTZ���������KV��)�Nc�6�q��m��JW^��C�+��mX��=��T�?rR�ܣ	��*�,_�}C~��&��jW���#�,_�	�)�\���y�Ș��=���b��6�yX�і\�A�q�0��$��
���B�02�
�@���������c�����D<�ۚ����sL;�<���V�`�o6әW�й��B�W�ra�������X���L>��L���7���mR+�^R$ܢb�\��]6�E$��$�xY�^R����'�\`�����\Ҡ�0XF�������q� �LdO��\�W�4�(l����׳v���:��C���V�8��&#O�����X���s�\RiǒU��rM�O�K~�'0��OEϠh���;�&�ЮF���AOT7�LI�]DԔ;���ߌ��W���6�G��i{[��<�7Q�9SҶ#ԋ�V�3{�������.�Ӟ�|tڼ0���R�n��c-��$l�G��W�{hf��4�{������Bz�ߍ)n�<�qt�y�j�t�m�s��+_��Hد����2_�7̀̊[��"�'/�L�֍w}alM�7]���1i��z�-�9#������9h���	��_"�hy��j���>&֖]��Z�"Mk�j����D>@s�;e^��ByD�n��Y/<$t���� "K�)x�E[��t�!x��"����L�`�s3�&�؍c�<�����	{�y%���R~��m~j�<�q�%m3�ˤ)3��/�0����Y�3����S��5�;�>QA��.�!�M�
3��0�_=��	������B�/X�/(�V�0IO��o�y3?-��g�z�2_�T���v�pὰ#a���u�jV��`��lĵ]��O&15��* ��54Xf�Z4$ 4  +�Y])�&i
�p�����K)�_���r�6JB��B=�l_YԜo�� },k�d=�j_��$w�5���-_�Q�K5�ow`/�+8���v�p�%Gm*������Ôt-�E��ڞ�F=������1��5��iw׼����(@^w�l�g
��0o\��t�a��e]2E-�*���n��I�cJ�´Ʈ�B&PZ/���ې��Uy�دy�I+T;馓-��F�Fѫ] �W���4��Ί"F�m{�:�n8��Sy������5�neM�Ӎ!nn*�)#�N�~��[�m�X$�c�9&�ۉ��r{{��C~��      4   �   x�m�A� ��p
.P2���vS˨]X�x}I����w�[���{/�}�/}�k�`<!q���^�& |T-�`;�2?�Mt��TXr�1[��&�v�dGmΒD���-�K��Ӳ͹���*���M�(��(����-h     