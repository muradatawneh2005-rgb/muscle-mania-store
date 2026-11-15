-- Muscle Mania Online Store: PostgreSQL 16 schema (SRS section 8)
BEGIN;

CREATE TABLE users (
  id             BIGSERIAL PRIMARY KEY,
  full_name      VARCHAR(120) NOT NULL,
  email          VARCHAR(160) UNIQUE,
  phone          VARCHAR(20)  NOT NULL UNIQUE,
  password_hash  VARCHAR(255) NOT NULL,              -- Argon2id, never the plain password
  role           VARCHAR(10)  NOT NULL DEFAULT 'CUSTOMER' CHECK (role IN ('CUSTOMER', 'EMPLOYEE', 'ADMIN')),
  preferred_lang CHAR(2)      NOT NULL DEFAULT 'ar' CHECK (preferred_lang IN ('ar', 'en')),
  is_active      BOOLEAN      NOT NULL DEFAULT TRUE,
  failed_logins  SMALLINT     NOT NULL DEFAULT 0,
  locked_until   TIMESTAMPTZ,
  created_at     TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE sessions (
  id          BIGSERIAL PRIMARY KEY,
  user_id     BIGINT      NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash  CHAR(64)    NOT NULL UNIQUE,           -- SHA-256 of the cookie token
  csrf_token  CHAR(64)    NOT NULL,
  expires_at  TIMESTAMPTZ NOT NULL
);

CREATE TABLE categories (
  id        SERIAL PRIMARY KEY,
  parent_id INT REFERENCES categories(id),
  name_ar   VARCHAR(80) NOT NULL,
  name_en   VARCHAR(80) NOT NULL,
  slug      VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE brands (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(80) NOT NULL UNIQUE,
  logo_url VARCHAR(255)
);

CREATE TABLE products (
  id             BIGSERIAL PRIMARY KEY,
  erp_id         INT UNIQUE,
  category_id    INT NOT NULL REFERENCES categories(id),
  brand_id       INT NOT NULL REFERENCES brands(id),
  slug           VARCHAR(160) NOT NULL UNIQUE,
  name_ar        VARCHAR(200) NOT NULL,
  name_en        VARCHAR(200) NOT NULL,
  description_ar TEXT,
  description_en TEXT,
  is_active      BOOLEAN NOT NULL DEFAULT TRUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX products_search_idx ON products USING GIN (to_tsvector('simple', name_ar || ' ' || name_en));

CREATE TABLE product_variants (
  id               BIGSERIAL PRIMARY KEY,
  product_id       BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  sku              VARCHAR(40) NOT NULL UNIQUE,
  flavour          VARCHAR(80),
  size             VARCHAR(40),
  price            NUMERIC(10,2) NOT NULL CHECK (price > 0),
  compare_at_price NUMERIC(10,2) CHECK (compare_at_price IS NULL OR compare_at_price > price),
  stock_qty        INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0)
);

CREATE TABLE product_images (
  id         BIGSERIAL PRIMARY KEY,
  product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  url        VARCHAR(255) NOT NULL,
  sort_order SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE cart_items (
  user_id    BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  variant_id BIGINT NOT NULL REFERENCES product_variants(id) ON DELETE CASCADE,
  quantity   INT    NOT NULL CHECK (quantity > 0),
  PRIMARY KEY (user_id, variant_id)
);

CREATE TABLE wishlist_items (
  user_id    BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  added_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, product_id)
);

CREATE TABLE delivery_regions (
  id        SERIAL PRIMARY KEY,
  name_ar   VARCHAR(80)  NOT NULL,
  name_en   VARCHAR(80)  NOT NULL,
  fee       NUMERIC(8,2) NOT NULL CHECK (fee >= 0),
  free_from NUMERIC(10,2) NOT NULL DEFAULT 400
);

CREATE TABLE orders (
  id             BIGSERIAL PRIMARY KEY,
  order_no       VARCHAR(20)  NOT NULL UNIQUE,
  user_id        BIGINT REFERENCES users(id),        -- NULL for guest orders (BR-09)
  customer_name  VARCHAR(120) NOT NULL,
  phone          VARCHAR(20)  NOT NULL CHECK (phone ~ '^\+97[02][0-9]{8,9}$'),
  region_id      INT NOT NULL REFERENCES delivery_regions(id),
  city           VARCHAR(80)  NOT NULL,
  address        VARCHAR(255) NOT NULL,
  status         VARCHAR(12)  NOT NULL DEFAULT 'PENDING'
                 CHECK (status IN ('PENDING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'CANCELLED')),
  subtotal       NUMERIC(10,2) NOT NULL CHECK (subtotal > 0),   -- BR-01: no empty orders
  delivery_fee   NUMERIC(8,2)  NOT NULL DEFAULT 0,
  total          NUMERIC(10,2) NOT NULL,
  payment_method VARCHAR(10)   NOT NULL DEFAULT 'COD' CHECK (payment_method = 'COD'),
  created_at     TIMESTAMPTZ   NOT NULL DEFAULT now()
);
CREATE INDEX orders_status_idx ON orders (status, created_at DESC);

CREATE TABLE order_items (
  id           BIGSERIAL PRIMARY KEY,
  order_id     BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  variant_id   BIGINT NOT NULL REFERENCES product_variants(id),
  product_name VARCHAR(200) NOT NULL,                 -- copied at order time
  unit_price   NUMERIC(10,2) NOT NULL,
  quantity     INT NOT NULL CHECK (quantity > 0)
);

CREATE TABLE order_status_history (
  id         BIGSERIAL PRIMARY KEY,
  order_id   BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  status     VARCHAR(12) NOT NULL,
  changed_by BIGINT REFERENCES users(id),             -- NULL = system
  changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE reviews (
  id         BIGSERIAL PRIMARY KEY,
  product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  user_id    BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  rating     SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment    TEXT,
  status     VARCHAR(10) NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'HIDDEN')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (product_id, user_id)                        -- BR-10: one review per product
);

CREATE TABLE audit_logs (
  id         BIGSERIAL PRIMARY KEY,
  user_id    BIGINT REFERENCES users(id),
  action     VARCHAR(40) NOT NULL,
  entity     VARCHAR(40) NOT NULL,
  entity_id  BIGINT,
  details    JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMIT;
