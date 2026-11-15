-- Sample reference data for development (no real customer data)
INSERT INTO delivery_regions (name_ar, name_en, fee, free_from) VALUES
  ('الضفة الغربية', 'West Bank', 20, 400),
  ('القدس', 'Jerusalem', 30, 400),
  ('الداخل', 'Inside 1948 areas', 70, 400);

INSERT INTO categories (name_ar, name_en, slug) VALUES
  ('المكملات الغذائية', 'Supplements', 'supplements'),
  ('الملابس الرياضية', 'Sportswear', 'sportswear');
INSERT INTO categories (parent_id, name_ar, name_en, slug) VALUES
  (1, 'البروتين', 'Protein', 'protein'),
  (1, 'الكرياتين', 'Creatine', 'creatine');

INSERT INTO brands (name) VALUES ('BiotechUSA'), ('Scitec Nutrition'), ('GASP'), ('Gorilla Wear');

INSERT INTO products (category_id, brand_id, slug, name_ar, name_en) VALUES
  (3, 1, '100-pure-whey-2000g-biotechusa', '100% بيور واي 2000 غرام', '100% Pure Whey 2000 g'),
  (4, 2, '100-creatine-monohydrate-300g-scitec', '100% كرياتين مونوهيدرات 300 غرام', '100% Creatine Monohydrate 300 g');
INSERT INTO product_variants (product_id, sku, flavour, price, stock_qty) VALUES
  (1, 'BT-PW-2000-CHOC', 'Chocolate', 370.00, 12),
  (1, 'BT-PW-2000-VAN', 'Vanilla', 370.00, 0),
  (2, 'SC-CM-300-UNF', 'Unflavoured', 150.00, 30);

-- Development admin. Password hash must be generated with Argon2id by the app; this placeholder cannot log in.
INSERT INTO users (full_name, phone, password_hash, role) VALUES ('Store Admin', '+970590000000', 'SET-BY-APP', 'ADMIN');
