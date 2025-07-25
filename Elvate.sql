PGDMP  '    5                 }            Elvate    17.4    17.4 �    >           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public               postgres    false    222   �                0    29605 	   complaint 
   TABLE DATA           N   COPY public.complaint (id, user_id, message, status, "createdAt") FROM stdin;
    public               postgres    false    224   �                 0    29613    complaint_response 
   TABLE DATA           `   COPY public.complaint_response (id, response, "createdAt", given_by, "complaintId") FROM stdin;
    public               postgres    false    226   �!                0    29620    coupons 
   TABLE DATA           _   COPY public.coupons (id, code, type, value, expiry_date, usage_limit, usage_count) FROM stdin;
    public               postgres    false    228   &"                0    29627    flash_sales 
   TABLE DATA           `   COPY public.flash_sales (id, discount, start_time, end_time, is_active, product_id) FROM stdin;
    public               postgres    false    230   �"      ;          0    30111    notification 
   TABLE DATA           ]   COPY public.notification (id, title, message, "isRead", type, data, "createdAt") FROM stdin;
    public               postgres    false    269   �"                0    29632    order 
   TABLE DATA             COPY public."order" (id, "totalAmount", status, "createdAt", "updatedAt", "userId", "shippingAddressFullname", "shippingAddressStreet", "shippingAddressCity", "shippingAddressState", "shippingAddressPostalcode", "shippingAddressCountry", "shippingAddressPhonenumber") FROM stdin;
    public               postgres    false    232   �#                0    29641 
   order_item 
   TABLE DATA           Q   COPY public.order_item (id, quantity, price, "orderId", "productId") FROM stdin;
    public               postgres    false    234   0(                0    29645    order_status_history 
   TABLE DATA           i   COPY public.order_status_history (id, "previousStatus", "newStatus", "changedAt", "orderId") FROM stdin;
    public               postgres    false    236   R+                0    29652    password_reset 
   TABLE DATA           R   COPY public.password_reset (id, email, otp, "createdAt", "expiresAt") FROM stdin;
    public               postgres    false    238   o+                0    29659    pending_user 
   TABLE DATA           M   COPY public.pending_user (id, email, password, otp, "createdAt") FROM stdin;
    public               postgres    false    240   �+                 0    29666    product 
   TABLE DATA           �   COPY public.product (id, title, description, base_price, brand_id, category_id, created_by, updated_by, created_at, updated_at) FROM stdin;
    public               postgres    false    242   �0      "          0    29674    product_image 
   TABLE DATA           �   COPY public.product_image (id, product_id, variant_id, image_url, is_main, created_at, updated_at, updated_by, created_by) FROM stdin;
    public               postgres    false    244   �2      $          0    29683    product_image_log 
   TABLE DATA           �   COPY public.product_image_log (id, product_image_id, action, previous_state, new_state, performed_by, performed_by_role, "timestamp") FROM stdin;
    public               postgres    false    246   E9      &          0    29690    product_log 
   TABLE DATA           �   COPY public.product_log (id, product_id, action, previous_state, new_state, performed_by, performed_by_role, "timestamp") FROM stdin;
    public               postgres    false    248   �E      9          0    30088    product_review 
   TABLE DATA           �   COPY public.product_review (id, user_id, product_id, status, title, description, rating, recommender, "imageUrls", created_at) FROM stdin;
    public               postgres    false    267   �I      (          0    29697    product_variant 
   TABLE DATA           Z   COPY public.product_variant (id, product_id, variant_name, price, stock, sku) FROM stdin;
    public               postgres    false    250   �L      *          0    29703    promo_code_usages 
   TABLE DATA           L   COPY public.promo_code_usages (id, user_id, coupon_id, used_at) FROM stdin;
    public               postgres    false    252   [M      ,          0    29707    refresh_tokens 
   TABLE DATA           J   COPY public.refresh_tokens (token, "expiresAt", id, "userId") FROM stdin;
    public               postgres    false    254   �M      .          0    29713    review 
   TABLE DATA           ^   COPY public.review (id, status, rating, comment, created_at, user_id, product_id) FROM stdin;
    public               postgres    false    256   ud      0          0    29721    user 
   TABLE DATA           V   COPY public."user" (id, email, password, role, "lastLogin", "lastLogout") FROM stdin;
    public               postgres    false    258   @e      7          0    29955 	   user_cart 
   TABLE DATA           ^   COPY public.user_cart (id, user_id, product_id, quantity, created_at, updated_at) FROM stdin;
    public               postgres    false    265   Ih      2          0    29734 	   user_logs 
   TABLE DATA           o   COPY public.user_logs (id, action, ip_address, user_agent, success, "timestamp", "userId", jwt_id) FROM stdin;
    public               postgres    false    260   �h      4          0    29742    user_rewards 
   TABLE DATA           b   COPY public.user_rewards (id, user_id, balance, points, reason, order_id, created_at) FROM stdin;
    public               postgres    false    262   �y      ]           0    0    address_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.address_id_seq', 20, true);
          public               postgres    false    219            ^           0    0    blacklist_tokens_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.blacklist_tokens_id_seq', 11, true);
          public               postgres    false    221            _           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 10, true);
          public               postgres    false    223            `           0    0    complaint_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.complaint_id_seq', 6, true);
          public               postgres    false    225            a           0    0    complaint_response_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.complaint_response_id_seq', 20, true);
          public               postgres    false    227            b           0    0    coupons_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.coupons_id_seq', 3, true);
          public               postgres    false    229            c           0    0    flash_sales_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.flash_sales_id_seq', 2, true);
          public               postgres    false    231            d           0    0    notification_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.notification_id_seq', 14, true);
          public               postgres    false    268            e           0    0    order_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.order_id_seq', 57, true);
          public               postgres    false    233            f           0    0    order_item_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.order_item_id_seq', 200, true);
          public               postgres    false    235            g           0    0    order_status_history_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.order_status_history_id_seq', 1, false);
          public               postgres    false    237            h           0    0    password_reset_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.password_reset_id_seq', 8, true);
          public               postgres    false    239            i           0    0    pending_user_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pending_user_id_seq', 91, true);
          public               postgres    false    241            j           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 34, true);
          public               postgres    false    243            k           0    0    product_image_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_image_id_seq', 117, true);
          public               postgres    false    245            l           0    0    product_image_log_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.product_image_log_id_seq', 81, true);
          public               postgres    false    247            m           0    0    product_log_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.product_log_id_seq', 31, true);
          public               postgres    false    249            n           0    0    product_review_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_review_id_seq', 22, true);
          public               postgres    false    266            o           0    0    product_variant_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.product_variant_id_seq', 16, true);
          public               postgres    false    251            p           0    0    promo_code_usages_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.promo_code_usages_id_seq', 6, true);
          public               postgres    false    253            q           0    0    refresh_tokens_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 201, true);
          public               postgres    false    255            r           0    0    review_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.review_id_seq', 6, true);
          public               postgres    false    257            s           0    0    user_cart_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_cart_id_seq', 14, true);
          public               postgres    false    264            t           0    0    user_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.user_id_seq', 79, true);
          public               postgres    false    259            u           0    0    user_logs_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.user_logs_id_seq', 301, true);
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
   i  x���ێ�H���)�0E�p��vr�&F"��"<��&�����̍��H�G���_'�G��H�s#�5���k�`�x��ھ�ݙ.��NL̺]T͛p5|����+���r�Ǵ��\Vh���c��Zq����.b�����l<.ju���Q(���e���0`�r��R-��>���9��[�ej��s���<K7��}��iu�2V>M~��E4���aE�D���W�;��_x��Z� ���NN�F�'m�>��C}��EW8�=X��|�yZ(G��ǉ,G���8,g���/k�����v���;zG��i\��$=���j� pO�z��U�OxcY�D)��<���w'�v'>����t�9+��ॻ��\�gK!b����c���ҹ �H�����A"
���}��������48I(L��ꜱ��D��eil=���`>��5/���<ÖЃWB�Z;�D�U�^��>*o
�����u��ơ���8��/<F�C���y���7<̐��T�y���Z�.�4V����"�/�;j�˪���V�3���&��;�}��R�2���>��ϴ�'e��iU���iɪ�C�>� �����,1[s��Kp�7-�p��$w�V��T���DR��L�7�e��4)�we�-����������B�	���wM`̖հ�:C�"o^G3TD,�:ɶ�}8"+�'��6~\� k����˖�˾���m�3�\b���[A��U�"z����y����]�P���@��.YdsФK%�Ү@�&�p�j��^m�F�&����sC�`��,0���"�o��H���f:e��O����W/��-�z�	k�ˑ������B�EQ?O�;�         �   x�}�Mj�0F��)|�I���#�0�n%m�I`�Y����	��i	ȫ��?1����z�L�|��0�4.I1*f��/g���y��ո	�i���c�$EL��ˬ^��DT�xx�y�QĆ�%R	�TsA|:Cu� �S� c��\@����jx�����E�Ɛ��j�нt}��o�-�U��c���P�d��2j���DGӾ��h=n�Y�~�bi�JpD���N��>�;�i�1��Hv�         �   x���An� �5�b.`4`0�\��(�lT"C\���*��V��/���$H|-/�C�5�!�r�~��e�^+����q{Ԓ8	Br�A[@��j�QiO��l��y��۞o�`��Z�ߒ�h���t���zpI����t�I��qF�'��� �q�������E�ʇ���JJ��U|         d   x����	�0 �s3E�$1�o'�Ń�(
"t}�뻿�ڄm�6lǹ��5����:V$*�E�7����8�ߏ���K2���:���h�KVM���H�*`         Z   x�3�v�q56�H-JN�+ILO�46�30�4202�50�ʙppr��8�p��$� e�j�t�9A\.c�q�x�"�=... r�         E   x�3�46�30�4202�50�50T00�20�B�P00�2�"�Nc.#NS$=&X�BO�!W� 0�^      ;   �   x����j�0��"=Gh�o�K��{qmA���R�߽�C��<���o�!���Ƀz�:7�����붙�[uR�9��z�U�#E��b7�u�o����i'Р��Ǩ�b"�b@'���9_ڹ���zU��eu�K۬�	1N?eL211��^�?��sյ�s��s]nH 	�v�/g�M�D�C��P��f�dI�'˳��,��:옝�jq������[��l!1��B�@���-t�)x�勖R~����         /  x��X=o#G�׿B}�?����I�TF�4�i/ Ȃ}��g�s��H��4.��y�C�I��9{��i8�3�ރ�#�G�Q1��Yɀ�c_�߯�9?=��;�!-� 	�+#� G��5I.�ކ̌p�m�e�q���S�.m��K�J�[(�0@�6��6R�R�X���E	�y�͌��������BmH�tk(�6P2�d��d[R�A�h�)y�؈��R5{B+$[)e�2
/�/`!b�6�"�b�?��N�ߞ��w>N��/��cx8�Ĺ��q?�~<Nχ�!�=�:�R"5��H���HWUQ�Ш�L���MH3�L�*�VE�BX�N	9`� �U��\P㈥f�;[R��#����֓3��ޡ0IՎ�V�r�f�^abT��ޠ8S:���)���:
�����!+V˳��˝��Z3
�_�z�z�Պ+��a��I�����,P����P{���-^�҆��:f;�x�k�$FJO?.�w�
�9�+�4�B)�\36�B �5E�o��Hb����"۠H*����Oȼ��s٠HSv�
�HϨ�E9���Uh�&��H%�3> !4S�(����/B�,"j#�E:�Q��+�l�}�D���x�)�W�Ѐ%�ǖ�� ����a_h%�d��Ǚ�#T�K�җ�}��QJ��޿��Rd�� �ÞikK��eǯ����Ttð/�Zi��������~�E1����҄4��Y$�I.m� !�MS�YJh�k�|d�2w1mC�:֛��1G��"MM���%����FJf��I*�$��+��I��5���j�M܆�r�m�t�D"j��ק��<��9����
�uq��VZ�?�����Z]t9�u%�!����,+�R�O�ÿ����f�W`��h�3t��-·�ӷ�x��Yw+�8��ɵT��[�3��1/r*߃ׅI�9o似OL�!A��)�瑺����喚j_D� 	A>�m�T�cC���I�V\�� w|\b�F(��M��òcf�,�&�!��qҼ��bƮ�ǫ�>5- ɘ{�S�{�w[ϼ�_�h
�P1�9���������/           x�e�[r�0D��Ť,����Z�PUj�9�nc��s�z�J�'���zS�
�/)7�K>��<a#��f�]�ӆ�`�ZmR&Ml�M�_%�*��9T�O�-��&O��͔<�)9{���	֓�4ϑ<Ŕ3{�J�4֞�?w+ѳ>���sQ
��q�T��)�ZL�3Z4f�X�H�z���U�-3Z,eTm{ʨ���Ѣ1��RF
�3eTm�{�hј�H),���"�##ДXΨ�g�ȶc����rF�G#gd�1��@SF`9#ۣ�3��GF�)#�������v�##Д�1��Iʈl;$g�h�h���Iʈl;$g�h�h�����oI�mGyrHǔ6L1��RyRND��6�Im��"��p'���Eɡ*����mQ)ŋD�[-D���U�U�Q�V�S5�U�U(����K�2*��:+[�RC�"�V�S՝ՄU(] 
m_H���b���o�Ft�\����/�D���S��nG�_:c�ٷ}�r�\��ϡt�2��o�N�k;c�9��9f����P5�vƴ�P:清�/D�ʷ��B��ھ�8U���J�����ʩ�mǴw���-���B�#c"�覌���M����0w_Ø_�F�T�k:��o����0�zV�w%fWO�pe���	s����̦���H���a������	��C������ӣ�9a�&'�{'�S�91���4H�O� ���/(F��$snV��v
��7��4�]Y%���k(!_@��t+@�W@G�}}0B̯��
���n����0Ϳ����[�            x������ � �         L   x���,�//�L345�pH�M���K���460�05�4202�50�54T02�2��26Գ0�016D�2�J�s��qqq �~           x���[r7E��P ��n̗����C3QL[�P.o?�d� űJ��H⠟�{ڴ]��w��<*�����i��z�:�M�ll����z�4��Z25#�Dea1 ���٬�������: Lg�\K�
x�B$<"��-7s��HV�6���%2yia�taMI����3{Vn�����AZG������+���F��Ģ�x"_gs1��!GFb-��'I�;��L�{��hb���Fs���x,͋�9��+���M�@ks$��Agk� ���	�]�F�5�H<V���6�xQ\�&�9�h�E>R�1�H��tF@Q��FԦ���&x����4��rK�+��vI@2�Xq֪��*�G�UY] 5<V�E$*b~�G�Q��u�*��)k�I�`�D�$�`��i�����\#ȓ�i&$���.٤�h�5�4��v�@�{/MԽ8�V�QIN��/�eq��&Y�Lr�M.<F�WKR����?���s��=#�ޝDn|���%;CN#��&�
?d$�,577�H]������/?6������ǧ�y�㄃qz��d5*�q�C��/�np��8�7��� G����ߖݎ��G ��#.w��謚'�%��S������G��/jc�ߧY�/��f*�9bU)i�XQ0}$�U(������I��G+W��a���e�AR����Xj;;*hҹ`�j�<N&e#����-3A.k2�^�{1u��+v����娨�v���n�m'ᯧ���k�~
`����Мj��t4�8:�}�t$�LŨ�ާe������zޢ���
��`�)v�g�+�0(V��P����
G0I�Kַ��l~��7�h���bB!���Ee�z��| ��P�~�^k�XX�����������E� �fA0���F���ʷ	z�g�"f!�
[W�r,����Ԫ+�p����Q��R�i�_6G����?|�}D"���z��O1�?�70�@���fx��e�,}���q%1Z��;��QS�W��i��`l�,Xb<Z�x`3�v�>�1�}�~�׌9� �0FF1�D���$�[-q��9�����@؟y���k�(j���~�ZHM��V��dL�17�?>��p�T�(hǒ�8<�yo�|��t����T�0�b��QLZ)",	�|��|>d���l0Mt<|��A��I|t�U���aŖP������V�ut�T��բ	#��p�b�5ڸ���X���Zʖ��j{@0X1�!1P�?A�ᡥ?sJ�(���          �  x�͖͎� �����"�~���U��q/(�u�8�lgW����&���lK#���0àȷ6��m�^j����Y���*t=��"������/��z
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
!�˱�      9   �  x��UM��6=K�B��*��ojOA7IsI�M�S ���ֲ����N��^Jo�l6�$� 9�f�<I�Hn^��~��M��`��?f�w�P�ɇ�=��:d��U�i��Ӵo=4(��1�6;�!:Z'���Lx�E<ZP(A�k�d*z����M���	�m��ܘ`����m��k�G���L�j��T٦��NK����F�'Q��A�9R @ ��Ĩ^�����?����;�9����71�3Q?�	}o���b�Ww�_�U�m��ͰiQ:�����-BＹ��=,��Ζ��VM].����P��bX�dZI�����@����庻G��~��|�#��8�A��,�FJH�y*���mlӸ�ٚP�����6Wq�\M3�TB�!�@p���'�m!mϿֿ��i�8Ҁ�T_�����în��V�}�;���}ƫ.(A�h£N�7��1�{)���K9��4�� F���_������r
�q�����܆q��k{_��~ڸ|�U�F�����u�����X�)W)�%�S)k���x
��'���)A5S2��m�~>.w����C�|��֚��!_5��K�8��:������l.)��ԵO8"ll%�1�De��II�J0�,��{��.U1S���ykK�}�7y&pNъH���:������ 
cLS�3�\P��/���h*�X��Mό6^QI����c�b�Ż���h<�D ƀH��#����@3�4%D��i�?���      (   �   x���;�0���9E.�*Σ��Q%66�%U�ޟJ5���؎���4��l�q�3g@m|�=8� ��V�o�󵫔Ba��2����4���@����G�r�iX[�V����1n�}ON�*���O��t�p�p�@��j!��h��      *   @   x�3�4B##]C]CSC+c+.#N#Nc�2@QzL�:��1�4�!c�i�C&F��� �A�      ,      x��\钢ʺ�]�)�h@&c�CdR0n!���3���L���UT�{bW�۞���J���oXߐ�5	'Qj���
���U9Zt4V%?y˱�w�JF`ل����7r���9YR���{�S�*��2U�����&u����+�YQ)zv�=352	�OiNLj�pUK
�B͉�5��*mJg[9�r����z���=%R�R�s�O��?X���Q�����d�I���|��!MQ/����=���@Ϥ>J�9��#�T���H����'f�8���(�6�e�ߠ�
�t��y�-J�|��W�2��磌h��Y-�(|�{����&~0��-�[1����2>\M���7
2�;�����Y�������(!1<ف�sWɛR��ӛ�A*�*{�j�tr��l��q�>A	�$��烌	��?�l�Z?é31N���+ĸ�Owzur��k=�����W����0�43�����	M�?��E�2�[>�d5R$����h��EJ������V:�߲q%_?���g�4��[���ֳj�,g"�K�U�9����"؇Y��'�~��[U�L�煖��8���4�,�B_Fy�s�����:?���/�I?U}���돟[�kO������s+Z[�<���<Y����3�f��ls�k#_g�\�Fu@-�#*�Y*��|��!�P/�B=]DN?�"t�F��R�B�dQ�[�㩒_���XX�~�t��oL4�ѡ`CCȰ/�2���B#�P}�҄:�C��љ�E�&�]=�M؂����L�Q�֣��)I�Я���lTa�d���۷��^D�ME��I�z׆]�k/�0+�������U����}���H�+{S'���1s0X6g��B~H�䏅γ �&ƭ6� ��3�B �������#oG����ř\�W�s�5��T8������I�$�v
Hd����=vJ#�J�Y��N;y�R?���|,jo�_g�*�p�%է�z>� �D���GI�v!�5�8�$:���G4AGB���J>�c:�Ѵە�� O;����{`&6+����sjM�H��b7��@����$��^���T-��ϐ07��
�?�h�?�KH�&���ҙۇ� rI��~��B��h��KFH��$�X�-np�3X�����
t3�� ]X�y��?��T��b���1@�"t_�ؿ�O�\EZ�$�����n)\�r�ܱ!���
�� ڂs���.���vJ���^	j�Q��<`�)@� V��μ�ZD�i�	[ɏ�MTd��:�_n'e�O �C��^h�� 3j���!F58�l!��Y%�'�ّ��6F��"龦%�����r���+*�IrȲ �ݠ��f��O�j�������x��N�}W?����
�����vw��J��'b��E�´�Q�$Ѭfw�F�B�L'�~0� �iX��n��p4�!�
���Î�M����Jy~_�欵mթI��u�N	'?�u�b�/�}؀���`ġ�>��dШF�i�~�5�{W\-T��#�3��OךM��N�1>v�(��fɒ/7�{�� J~�������w��LJ�PWF�U��	6�΂���䚿��d��E�ǖ3X�/�ʞ���%	���9��c�i���4�C�m]�=c{��+�6�K�Y#�ǽ9^I��$'"]N�O��&��"�5%J�lW9sO�V��[���z"�=Gzo��TZO��i���!����vWV�~����Q~V΀�"үY^x���gJe���$�S8��v��>e�\������6?z�ʑ���i�ڴ"�|Ĉ�z0)�N)��LTo�ki\y
 �����n�v���o6�p��s"oTf�sƌ7 ^��1~T=�4�JC ���J뱅�i�!�ʒ?���s�\v-��ل�(��6����*�Ǽ���(�-jĎo���ld?۵is<�C��fb9/��<ղ��Z/�"O������O^C곓G����n���/���$O��d�����q�wnzu�w'OvY�(�����p�J�Й�+-�	����w�bp9F�f������z����X,�2;�{��oa�n�8dh���W�ɑƏ?�ą���������9I�{3w�0�Q�����qt'g�"��$qNpC	��F\�~~���_O�@莋F�����e��,�*�!�i�-5���玧K�T��!ү4��?B����;]�� i��'|�H;a9�m3�O��oW�L��wf����h�y4�pϞf��GǽBrH�m��mM�!�NGI(Ƶ�������,,#�/�%ʹ��Yn�`�����pd��հ��'��ݯ�S�W;6���t�H+�̐$B���͔��-s�~H2�W���uL�U��+7�#_S(Հ<��Q��צ�g�����C�3��:*V�N��5�~���}1�ή�(�5��U(�ҽ"��xEg����~o�])���Dz\�'�^Or�g��	�����-�Щ�";	���� �@��Hv�<�]������sli���<x��~i ^H�ٺ0G5)�Hb��!q�S��kj��&٪�.�/
����?�+�&Al�06�s����?i��H�Y�O�����~<�W/��*�lb{5�d�7�� �e�Х���A��r1��78i\�A��#�G�߷��u��D�%{��Yk�֕3�@����N&�#��U4q�d���b��)����x�tak��	Q����m��ϯ���7��=޴�it�8����>rT
�?����,��;f������Jo̭�l٢��4�~r�t,VKC��.���T���p�Mȍr�'��t2B؜��,�Ov�nȇ���jH���}. n"RH1B�T���S��t5�GA���![w���Bx_��"����<�v}�KrWb��U ��� 䐡�U�gD�/�ED"��}�0p�k��pT�҅��)��\���n��1Y-\6[�w�A��ǎ��#��+D�F6���_a(j6z����3��0�&�|#�]���P�6քQ���12b:V� \�R��e\*�!�Cx����/�?9��o�:Ro�����y���(kjx���B)�5۝�P/VW�rl�˱^��)K��(^��k�>|��WI�x��>x$�wtQ��6�Y����],�\ݍSG���87-��9���=�n��f��C�Q��J/@��ctD�����@6=Q��Sj/�����ֻ]3?�N�����e�{Y��P�
8L�7����%���q!!����۽�	w�������ԙ=
��e��>6�x!�as?�`��)��1��t>E��k�\8q�7���S��yD>�-�ZqG�KʴY�P�:/�6 �w\��խ*��)���gM���	T/k�Tb��%8;N�S��է*�m�*7���֝���Έ�o���d��	pC�����*�uv����h�߳�)�����x�6�X����LF����s�����V�;᱿��p�Ro� �W�x�0(VP���#Ps\��Bk4�3A\XBB���L0��%�3�-��N���Yʺ�N�,a��7���'J�3�i������"��ܦvc�����v&��ca�^>�7��[�f�,�������.�!Pܤ�Ҏ�
Po��s��#.�rx�k����.�s��7�^���O̪��Z9����Ǳr4��)�Կ�*D��!��SG�%o3��&�=�Gc�=��^���������Z��[.@�S;�m5����� kGk�Lovi�����x�gE8]'ۉ�~��ا����=H�#���@���N�����Mȩ;�fj�0��A��;�X=�wt���9\����J�Z&}���
f��^��l����.��ٽ�՛h0iI\�R�N�D�/�����NwSx0����J�14ĸ�\�#p�5�`��Pѩ57�|���S��֭f:�re�!���I`p��������]X���A^��("	�B$'i�]�"\I�\1s���o��e �  3��4[x��. �.� "y��72���!�]Gji���/���kky�2y~Ӗ�&�sO3�D|�*cv>0u�03�z�5*���������+#�7K���1�{hc�B�7 �����������i�Ň�0Zlވ���~6&�q���=4��&����J򷧢?��E����}���q�rܭ�~�pbZk<�y�ZBu?RX�r�?9�f�0y����c�{d��c��J�B�"h�Կ�
+T^��V�*�V��T�n��M�F�6��wRu٥�]�L���X�6�9� ��Awg��-����S̤����q�LZ��D�Bfr��ԒM7~������Y������Y1P�4^e{�}j��&��-����<����g15N��W�V�Dv'�q���\�IߜY>�2���؃��QU�ϬYy~">�"؃����3�^=�d.��6�r����.�l�<�=/7�d2��J��dq���u�#�� ��/ 
x��5��3���&i���[�QWp��P��n��c{S�*
�Ov?k�]L�9�24���7��:.4$��\����[��ț]��9�e�'�f*6�ë�r��UQof�$if�,D��+O�+A;��|�0�e\�:�`���+ฤ�-��21?�]�L��if&�� #�j1��c�rn�˩R��Rv@�n��IO����|��n�	q�q�����n���Av-�J�&0�3�� ��Ή��S:��ŏ�KR��~��ɯ��S��׻p|=#q�bC{t2O��vP�(6�LHۘӼ���$[U?���MZ���<�V�ߠ��q��>��h��G��!jV�t"3��U��d����Y~*�)%���i\R|���Q��}��z��D��8���A`��ptqK���@v�f6���>�e�f圻�=.�B���u��ɩO�^��z����z�ר���bvr�A������8ݭv!q���-�:���v�c㾣��[��2�r��*����^��5��{_rh3)#D���l�jDSd*�Z���`6R#�?�C74D��a�)����*EjK�k���t`�Q�i����=�tp��Fr��TطҎ^�̼f��F���:�L�-dw	�C
�t�w���̄�3����$�Q]��F��A��Ƅ="[?h��L'	�IB4s�v�5��+k����w�!ã��}����f�;�}���5&�Ej����S^��7��H9��i[XU,)y�Ń�;��w\��F^)zH�m%�H:��L�â����c�->��tG�b���cD;� T{�5cvw��A���\�e7�9��s���Sѕ��*����u�.cc��vi�6�Wb�^H5��+��t�]�v��
���1�p���8�7����\@-Sh̅q��G˶�4�֏�A�Ң�j}��p��佒�뛬����q�f� g�w��:.��A�a.L
��ħ�&ΦS�D鞬dW�l�?���ދ��6�,�>��n��=e��+\Pzۯ]�n���]��I��ùr5Jv+�^B�$ǋ̪S������y�<b`��D�w�e�B.Qh��] ��w�.���tf!�̝���8i9��KK��%\_�nt�o���i1d�Ip��ZWG�BJEuTpc3,�J�gbb��L\J�ȭ����o�y�x�"$D)���hp]������?���e�      .   �   x��бn�@��~�{N��w���RPĒD�X�	5��cQ�U�f�bɟ�_�c?����nZ����auLU�r񚬙  c���-��/��e����zv��2?O�?�!MU�JY�1�:&��8�(5$��pa�������09��5��B��5��G	k�R)�l�4�$�?}G#�J�M����#���e�      0   �  x��UKv�0\S���G�_i���0����OR⶧/ ;�$��{^�`0�NL��E�V c ��X���2O�/ҠE<�����6�f�P�|�fnZƙ_��P��)�ȕ*���J,�\A�����,X�U@X�qJ����Ǿ�W�b{n���s�K?�ئ��UQ�.��������-���J�@�bWɱMS�����Pq������Q�P��:G�r%(	 �CѦC�F2���V������]�����K, ��Z"�=�9��TVj�3���X�Kj��q��زM���B�d��!n�$��f^���1�vpK�5��,�c�!�{�0:Q7FE��B���Ŧa��4߃�s���꾍�&����"���I��-�M!���j�ε<���m������4�gA��Q��S5���Eߤw"}�Ӵ��k�&[�T��EA�ҼͶq�]����0�����m?����C霻��N+^*Ic�ϼ�=�6SZ+Aa�.��U`KQ/�6;,r�\��jG;�V�l��AdNm���M��c�6@�y���\5M��q8����G�b��p���,4���_cwӣ��S�6!�<na!�O�������nc�4��GJ�y��X��q�Cii�����y�S��6�YE�ɠa>�x�
�~Æ\��C��w�[\\�o*__Sq�*oPɎ�����8��4�x����z�W�~|GKUH��K�I.BV<����96ܣ0��¼��W�L�IfY����      7   j   x�}���0��Y ��H��Y��uP�hQ�~�G�����d��l����	�� �-�ì��A����^}�֪I�~����_���R#�Z���,�<TD��$
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
3��0�_=��	������B�/X�/(�V�0IO��o�y3?-��g�z�2_�T���v�pὰ#a���u�jV��`��lĵ]��O&15��* ��54Xf�Z4$ �   +�Y])�&i
�p�����K)�_���r�6JB��B=�l_YԜo�� },k�d=�j_��$w�5���-_�Q�K5�ow`/�+8���v�p�%Gm*������Ôt-�E��ڞ�F=������1��5��iw׼����(@^w�l�g
��0o\��t�a��e]2E-�*���n��I�cJ�´Ʈ�B&PZ/���ې��Uy�دy�I+^noo�&u�      4   �   x�m�A� ��p
.P2���vS˨]X�x}I����w�[���{/�}�/}�k�`<!q���^�& |T-�`;�2?�Mt��TXr�1[��&�v�dGmΒD���-�K��Ӳ͹���*���M�(��(����-h     