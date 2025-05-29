-- Hapus semua data sebelum seeding (gunakan dengan hati-hati)
SET
    FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE user_roles;

TRUNCATE TABLE role_permissions;

TRUNCATE TABLE users;

TRUNCATE TABLE roles;

TRUNCATE TABLE permissions;

TRUNCATE TABLE product_categories;

TRUNCATE TABLE products;

SET
    FOREIGN_KEY_CHECKS = 1;





-- Users Entity
-- Insert Roles (Hak Akses)
INSERT INTO
    roles (name_role)
VALUES
    ('Super Admin'),
    ('Owner'),
    ('Admin'),
    ('Manager'),
    ('Kasir'),
    ('Karyawan');

-- Insert Permissions (Hak Akses yang Bisa Dilakukan)
INSERT INTO
    permissions (name)
VALUES
    ('manage_transactions'),
    ('process_transactions'),
    ('create_transactions'),
    ('read_transactions'),
    ('manage_inventory'),
    ('read_inventory'),
    ('manage_analytics'),
    ('process_analytics'),
    ('read_analytics'),
    ('manage_suppliers'),
    ('read_suppliers'),
    ('manage_members'),
    ('read_members'),
    ('update_members'),
    ('manage_employees'),
    ('read_employees'),
    ('manage_products'),
    ('read_products'),
    ('manage_payments'),
    ('process_payments'),
    ('read_payments'),
    ('manage_settings'),
    ('read_settings');

-- Insert Users 
-- Root
INSERT INTO
    users (name, email, nip, phone, password)
VALUES
    -- Super Admin
    ('root', 'root@gmail.com', '00000000001', '087765290290', SHA2 ('root', 256));

-- Owner
INSERT INTO
    users (name, email, nip, phone, password)
VALUES
    ('abya owner', 'abyaowner@gmail.com', '00000000002', '087765290291', SHA2 ('abya-owner', 256));

-- Admin
INSERT INTO
    users (name, email, nip, phone, password)
VALUES
    ('abya admin', 'abyaadmin@gmail.com', '00000000003', '087765290292', SHA2 ('abya-admin', 256));

-- Manager
INSERT INTO
    users (name, email, nip, phone, password)
VALUES
    ('abya manager', 'abyamanager@gmail.com', '00000000004', '087765290293', SHA2 ('abya-manager', 256));

-- Kasir
INSERT INTO
    users (name, email, nip, phone, password)
VALUES
    ('abya kasir', 'abyakasir@gmail.com', '00000000005', '087765290294', SHA2 ('abya-kasir', 256)),
    ('nina kasir', 'ninakasir@gmail.com', '00000000006', '087765290295', SHA2 ('nina-kasir', 256)),
    ('andi kasir', 'andikasir@gmail.com', '00000000007', '081234567891', SHA2 ('andi-kasir', 256)),
    ('dewi kasir', 'dewikasir@gmail.com', '00000000008', '081345678912', SHA2 ('dewi-kasir', 256)),
    ('rini kasir', 'rinikasir@gmail.com', '00000000009', '081456789123', SHA2 ('rini-kasir', 256));

-- Karyawan
INSERT INTO
    users (name, email, nip, phone, password)
VALUES
    ('abya karyawan', 'abyakaryawan@gmail.com', '00000000010', '087765290296', SHA2 ('abya-karyawan', 256));

-- Hubungkan User ke Role
INSERT INTO
    user_roles (id_user, id_role)
VALUES
    (1, 1), -- root → Super Admin
    (2, 2), -- abya owner → Owner
    (3, 3), -- abya admin → Admin
    (4, 4), -- abya manager → Manager
    (5, 5), -- abya kasir → Kasir
    (6, 5), -- nina kasir → Kasir
    (7, 5), -- andi kasir → Kasir
    (8, 5), -- dewi kasir → Kasir
    (9, 5), -- rini kasir → Kasir
    (10, 6) -- abya karyawan → Karyawan
;

-- Hubungkan Role ke Permission (Sesuai dengan spesifikasi akses)
-- Super Admin
INSERT INTO
    role_permissions (id_role, id_permission)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4), -- Transactions
    (1, 5),
    (1, 6), -- Inventaris
    (1, 7),
    (1, 8),
    (1, 9), -- Analytics
    (1, 10),
    (1, 11), -- Suppliers
    (1, 12),
    (1, 13),
    (1, 14), -- Members
    (1, 15),
    (1, 16), -- Karyawan
    (1, 17),
    (1, 18), -- Products
    (1, 19),
    (1, 20),
    (1, 21), -- Payments
    (1, 22),
    (1, 23) -- Settings
;

-- Owner
INSERT INTO
    role_permissions (id_role, id_permission)
VALUES
    (2, 1),
    (2, 4), -- Transactions
    (2, 5),
    (2, 6), -- Inventaris
    (2, 7),
    (2, 9), -- Analytics
    (2, 10),
    (2, 11), -- Suppliers
    (2, 12),
    (2, 13), -- Members
    (2, 15),
    (2, 16), -- Karyawan
    (2, 17),
    (2, 18), -- Products
    (2, 19),
    (2, 21), -- Payments
    (2, 22),
    (2, 23) -- Settings
;

-- Admin
INSERT INTO
    role_permissions (id_role, id_permission)
VALUES
    (3, 1),
    (3, 4), -- Transactions
    (3, 5),
    (3, 6), -- Inventaris
    (3, 8),
    (3, 9), -- Analytics
    (3, 10),
    (3, 11), -- Suppliers
    (3, 12),
    (3, 13),
    (3, 14), -- Members
    (3, 15),
    (3, 16), -- Karyawan
    (3, 17),
    (3, 18), -- Products
    (3, 21), -- Payments
    (3, 23) -- Settings
;

-- Manager
INSERT INTO
    role_permissions (id_role, id_permission)
VALUES
    (4, 4), -- Transactions (read)
    (4, 6), -- Inventaris (read)
    (4, 8),
    (4, 9), -- Analytics (process + read)
    (4, 11), -- Suppliers (read)
    (4, 13),
    (4, 14), -- Members (read + update)
    (4, 16), -- Karyawan (read)
    (4, 18), -- Products (read)
    (4, 21), -- Payments (read)
    (4, 23) -- Settings (read)
;

-- Kasir
INSERT INTO
    role_permissions (id_role, id_permission)
VALUES
    (5, 2), -- Transactions (process + create + read)
    (5, 3), -- Transactions (process + create + read)
    (5, 4), -- Transactions (process + create + read)
    (5, 6), -- Inventaris (read)
    (5, 9), -- Analytics (read)
    (5, 11), -- Suppliers (read)
    (5, 13),
    (5, 14), -- Members (read + update)
    (5, 16), -- Karyawan (read)
    (5, 18), -- Products (read)
    (5, 20),
    (5, 21), -- Payments (process + read)
    (5, 23) -- Settings (read) 
;

-- Karyawan
INSERT INTO
    role_permissions (id_role, id_permission)
VALUES
    (6, 4), -- Transactions (read)
    (6, 6), -- Inventaris (read)
    (6, 9), -- Analytics (read)
    (6, 11), -- Suppliers (read)
    (6, 13), -- Members (read)
    (6, 16), -- Karyawan (read)
    (6, 18), -- Products (read)
    (6, 21), -- Payments (read)
    (6, 23) -- Settings (read)
;


-- Products Entity
INSERT INTO
    product_categories (name)
VALUES
    ('Makanan'),
    ('Minuman'),
    ('Perlengkapan Rumah'),
    ('Elektronik'),
    ('Perawatan Pribadi'),
    ('Hair Styling');

INSERT INTO
    products (name, price, discount, barcode, category_id, stock_qty, is_active, cost_price, tax_rate)
VALUES
    -- Makanan
    ('Biskuit Roma Kelapa 300g', 12000.00, 0.00, '8991001101234', 1, 50, true, 8500.00, 0.10),
    ('Chitato BBQ 68g', 9500.00, 0.05, '8998866201234', 1, 30, true, 7000.00, 0.10),
    -- Minuman
    ('Aqua Botol 600ml', 4000.00, 0.00, '8998765432101', 2, 100, true, 2500.00, 0.10),
    ('Teh Botol Sosro 450ml', 5000.00, 0.00, '8992711234567', 2, 70, true, 3200.00, 0.10),
    -- Perlengkapan Rumah
    ('Sabun Cuci Piring Sunlight 755ml', 14500.00, 0.10, '8999999998888', 3, 40, true, 11000.00, 0.10),
    -- Elektronik
    ('Lampu LED Philips 10W', 29000.00, 0.00, '8998765987654', 4, 20, true, 22000.00, 0.10),
    -- Perawatan Pribadi
    ('Shampoo Pantene 180ml', 23000.00, 0.13, '8999991122334', 5, 25, true, 17000.00, 0.10),
    ('NIVEA MEN Extra Bright 50ml', 25000.00, 0.08, '8999777888350', 5, 53, true, 15000.00, 0.10),
    -- Hair Styling
    ('GATSBY Powder Clay Unbrekable smooth 20g', 49000.00, 0.00, '8992222056700', 6, 75, true, 45000.00, 0.10);



-- Dummy data transaksi untuk tahun 2024 (2 transaksi per bulan)
-- Januari 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (8, 'dewi kasir', 'TRX240105001', 'completed', 'cash', 35000.00, 1500.00, 33500.00, 1200.00, 3.35, 36853.50, 40000.00, 3146.50, 'Pembelian kebutuhan sehari-hari', '2024-01-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (7, 'andi kasir', 'TRX240118002', 'completed', 'debit', 78000.00, 5000.00, 73000.00, 2500.00, 7.30, 80307.30, 80000.00, -307.30, 'Pembelian beberapa item elektronik kecil', '2024-01-30 14:30:00');

-- Februari 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (5, 'abya kasir', 'TRX240202003', 'completed', 'cash', 22500.00, 250.00, 22250.00, 800.00, 2.23, 24482.25, 25000.00, 517.75, 'Beli minuman dan snack', '2024-02-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (9, 'rini kasir', 'TRX240215004', 'completed', 'credit', 120000.00, 12000.00, 108000.00, 4000.00, 10.80, 118810.80, 120000.00, 1189.20, 'Pembelian perlengkapan rumah tangga', '2024-02-29 14:30:00');

-- Maret 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (7, 'andi kasir', 'TRX240309005', 'completed', 'e-wallet', 45000.00, 0.00, 45000.00, 1500.00, 4.50, 49504.50, 50000.00, 495.50, 'Beli beberapa produk perawatan pribadi', '2024-03-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (8, 'dewi kasir', 'TRX240322006', 'completed', 'cash', 60000.00, 3000.00, 57000.00, 2000.00, 5.70, 62705.70, 65000.00, 2294.30, 'Pembelian makanan dan minuman untuk acara', '2024-03-30 14:30:00');

-- April 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (3, 'abya kasir', 'TRX240403007', 'completed', 'debit', 30000.00, 500.00, 29500.00, 1000.00, 2.95, 32452.95, 35000.00, 2547.05, 'Beli snack dan perlengkapan mandi', '2024-04-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (9, 'rini kasir', 'TRX240419008', 'completed', 'credit', 95000.00, 9500.00, 85500.00, 3200.00, 8.55, 94058.55, 95000.00, 941.45, 'Pembelian produk hair styling', '2024-04-30 14:30:00');

-- Mei 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (7, 'andi kasir', 'TRX240511009', 'completed', 'e-wallet', 55000.00, 2000.00, 53000.00, 1800.00, 5.30, 58305.30, 60000.00, 1694.70, 'Beli minuman dan beberapa makanan ringan', '2024-05-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (8, 'dewi kasir', 'TRX240525010', 'completed', 'cash', 110000.00, 5500.00, 104500.00, 3800.00, 10.45, 114960.45, 115000.00, 39.55, 'Pembelian perlengkapan rumah tangga dan makanan', '2024-05-30 14:30:00');

-- Juni 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (1, 'abya kasir', 'TRX240607011', 'completed', 'debit', 40000.00, 1000.00, 39000.00, 1300.00, 3.90, 42903.90, 45000.00, 2096.10, 'Beli beberapa jenis minuman', '2024-06-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (9, 'rini kasir', 'TRX240621012', 'completed', 'credit', 70000.00, 7000.00, 63000.00, 2200.00, 6.30, 69306.30, 70000.00, 693.70, 'Pembelian produk perawatan pribadi dan hair styling', '2024-06-30 14:30:00');

-- Juli 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (7, 'andi kasir', 'TRX240704013', 'completed', 'e-wallet', 28000.00, 0.00, 28000.00, 900.00, 2.80, 30802.80, 30000.00, -802.80, 'Beli snack untuk perjalanan', '2024-07-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (8, 'dewi kasir', 'TRX240719014', 'completed', 'cash', 150000.00, 15000.00, 135000.00, 5000.00, 13.50, 148513.50, 150000.00, 1486.50, 'Pembelian beberapa item elektronik', '2024-07-30 14:30:00');

-- Agustus 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (4, 'abya kasir', 'TRX240810015', 'completed', 'debit', 32000.00, 320.00, 31680.00, 1100.00, 3.17, 34853.17, 35000.00, 146.83, 'Beli minuman dan makanan ringan untuk di rumah', '2024-08-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (9, 'rini kasir', 'TRX240823016', 'completed', 'credit', 85000.00, 4250.00, 80750.00, 2800.00, 8.08, 88828.08, 90000.00, 1171.92, 'Pembelian perlengkapan mandi dan perawatan tubuh', '2024-08-30 14:30:00');

-- September 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (7, 'andi kasir', 'TRX240906017', 'completed', 'e-wallet', 62000.00, 1800.00, 60200.00, 2100.00, 6.02, 66226.02, 65000.00, -1226.02, 'Beli beberapa produk makanan dan minuman', '2024-09-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (8, 'dewi kasir', 'TRX240920018', 'completed', 'cash', 130000.00, 6500.00, 123500.00, 4500.00, 12.35, 135862.35, 140000.00, 4137.65, 'Pembelian perlengkapan rumah dan beberapa snack', '2024-09-30 14:30:00');

-- Oktober 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (2, 'abya kasir', 'TRX241008019', 'completed', 'debit', 38000.00, 0.00, 38000.00, 1400.00, 3.80, 41803.80, 40000.00, 196.20, 'Beli minuman dan perlengkapan mandi', '2024-10-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (9, 'rini kasir', 'TRX241026020', 'completed', 'credit', 90000.00, 9000.00, 81000.00, 3000.00, 8.10, 89108.10, 90000.00, 891.90, 'Pembelian produk hair styling dan perawatan pribadi', '2024-10-30 14:30:00');

-- November 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (7, 'andi kasir', 'TRX241103021', 'completed', 'e-wallet', 50000.00, 2500.00, 47500.00, 1700.00, 4.75, 52254.75, 55000.00, 2745.25, 'Beli beberapa makanan ringan dan minuman', '2024-11-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (8, 'dewi kasir', 'TRX241117022', 'completed', 'cash', 115000.00, 5750.00, 109250.00, 4000.00, 10.93, 120180.93, 120000.00, -180.93, 'Pembelian perlengkapan rumah dan beberapa snack', '2024-11-30 14:30:00');

-- Desember 2024
INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (2, 'abya kasir', 'TRX241201023', 'completed', 'debit', 42000.00, 0.00, 42000.00, 1500.00, 4.20, 46204.20, 50000.00, 3795.80, 'Beli minuman dan perlengkapan mandi', '2024-12-15 14:30:00');

INSERT INTO
    transactions (user_id, cashier, transaction_id, status, payment_method, subtotal, total_discount, total_price, total_profit, total_tax, last_price, pay_received, pay_return, notes, created_at)
VALUES
    (9, 'rini kasir', 'TRX241215024', 'completed', 'credit', 98000.00, 9800.00, 88200.00, 3300.00, 8.82, 97028.82, 100000.00, 2971.18, 'Pembelian produk hair styling dan perawatan pribadi untuk hadiah', '2024-12-30 14:30:00');



    -- Dummy data untuk transaction_items
-- Transaction 1 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (1, 1, '8991001101234', 'Biskuit Roma Kelapa 300g', 'Makanan', 2, 8500.00, 12000.00, 0.00, 0.10, 26400.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (1, 2, '8998866201234', 'Chitato BBQ 68g', 'Makanan', 1, 7000.00, 9500.00, 475.00, 0.10, 9930.00);

-- Transaction 2 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (2, 3, '8998765432101', 'Aqua Botol 600ml', 'Minuman', 3, 2500.00, 4000.00, 0.00, 0.10, 13200.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (2, 6, '8998765987654', 'Lampu LED Philips 10W', 'Elektronik', 1, 22000.00, 29000.00, 0.00, 0.10, 31900.00);

-- Transaction 3 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (3, 7, '8999991122334', 'Shampoo Pantene 180ml', 'Perawatan Pribadi', 1, 17000.00, 23000.00, 2300.00, 0.10, 22770.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (3, 9, '8992222056700', 'GATSBY Powder Clay Unbrekable smooth 20g', 'Hair Styling', 1, 45000.00, 49000.00, 0.00, 0.10, 53900.00);

-- Transaction 4 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (4, 4, '8992711234567', 'Teh Botol Sosro 450ml', 'Minuman', 2, 3200.00, 5000.00, 0.00, 0.10, 11000.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (4, 5, '8999999998888', 'Sabun Cuci Piring Sunlight 755ml', 'Perlengkapan Rumah', 1, 11000.00, 14500.00, 1450.00, 0.10, 14495.00);

-- Transaction 5 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (5, 8, '8999777888350', 'NIVEA MEN Extra Bright 50ml', 'Perawatan Pribadi', 1, 15000.00, 25000.00, 2000.00, 0.10, 25300.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (5, 1, '8991001101234', 'Biskuit Roma Kelapa 300g', 'Makanan', 1, 8500.00, 12000.00, 0.00, 0.10, 13200.00);

-- Transaction 6 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (6, 2, '8998866201234', 'Chitato BBQ 68g', 'Makanan', 2, 7000.00, 9500.00, 950.00, 0.10, 19910.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (6, 3, '8998765432101', 'Aqua Botol 600ml', 'Minuman', 1, 2500.00, 4000.00, 0.00, 0.10, 4400.00);

-- Transaction 7 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (7, 4, '8992711234567', 'Teh Botol Sosro 450ml', 'Minuman', 3, 3200.00, 5000.00, 500.00, 0.10, 14850.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (7, 5, '8999999998888', 'Sabun Cuci Piring Sunlight 755ml', 'Perlengkapan Rumah', 1, 11000.00, 14500.00, 0.00, 0.10, 15950.00);

-- Transaction 8 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (8, 6, '8998765987654', 'Lampu LED Philips 10W', 'Elektronik', 2, 22000.00, 29000.00, 2900.00, 0.10, 57200.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (8, 7, '8999991122334', 'Shampoo Pantene 180ml', 'Perawatan Pribadi', 1, 17000.00, 23000.00, 0.00, 0.10, 25300.00);

-- Transaction 9 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (9, 8, '8999777888350', 'NIVEA MEN Extra Bright 50ml', 'Perawatan Pribadi', 2, 15000.00, 25000.00, 2500.00, 0.10, 50050.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (9, 9, '8992222056700', 'GATSBY Powder Clay Unbrekable smooth 20g', 'Hair Styling', 1, 45000.00, 49000.00, 4900.00, 0.10, 48510.00);

-- Transaction 10 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (10, 1, '8991001101234', 'Biskuit Roma Kelapa 300g', 'Makanan', 3, 8500.00, 12000.00, 1200.00, 0.10, 35640.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (10, 2, '8998866201234', 'Chitato BBQ 68g', 'Makanan', 1, 7000.00, 9500.00, 0.00, 0.10, 10450.00);

-- Transaction 11 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (11, 3, '8998765432101', 'Aqua Botol 600ml', 'Minuman', 2, 2500.00, 4000.00, 400.00, 0.10, 8360.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (11, 4, '8992711234567', 'Teh Botol Sosro 450ml', 'Minuman', 1, 3200.00, 5000.00, 0.00, 0.10, 5500.00);

-- Transaction 12 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (12, 5, '8999999998888', 'Sabun Cuci Piring Sunlight 755ml', 'Perlengkapan Rumah', 2, 11000.00, 14500.00, 1450.00, 0.10, 28600.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (12, 6, '8998765987654', 'Lampu LED Philips 10W', 'Elektronik', 1, 22000.00, 29000.00, 0.00, 0.10, 31900.00);

-- Transaction 13 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (13, 7, '8999991122334', 'Shampoo Pantene 180ml', 'Perawatan Pribadi', 2, 17000.00, 23000.00, 2300.00, 0.10, 45540.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (13, 8, '8999777888350', 'NIVEA MEN Extra Bright 50ml', 'Perawatan Pribadi', 1, 15000.00, 25000.00, 0.00, 0.10, 27500.00);

-- Transaction 14 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (14, 9, '8992222056700', 'GATSBY Powder Clay Unbrekable smooth 20g', 'Hair Styling', 2, 45000.00, 49000.00, 4900.00, 0.10, 96020.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (14, 1, '8991001101234', 'Biskuit Roma Kelapa 300g', 'Makanan', 1, 8500.00, 12000.00, 1200.00, 0.10, 12100.00);

-- Transaction 15 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (15, 2, '8998866201234', 'Chitato BBQ 68g', 'Makanan', 3, 7000.00, 9500.00, 950.00, 0.10, 29790.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (15, 3, '8998765432101', 'Aqua Botol 600ml', 'Minuman', 1, 2500.00, 4000.00, 400.00, 0.10, 3960.00);

-- Transaction 16 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (16, 4, '8992711234567', 'Teh Botol Sosro 450ml', 'Minuman', 2, 3200.00, 5000.00, 0.00, 0.10, 11000.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (16, 5, '8999999998888', 'Sabun Cuci Piring Sunlight 755ml', 'Perlengkapan Rumah', 1, 11000.00, 14500.00, 1450.00, 0.10, 14495.00);

-- Transaction 17 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (17, 6, '8998765987654', 'Lampu LED Philips 10W', 'Elektronik', 1, 22000.00, 29000.00, 2900.00, 0.10, 31900.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (17, 7, '8999991122334', 'Shampoo Pantene 180ml', 'Perawatan Pribadi', 2, 17000.00, 23000.00, 0.00, 0.10, 50600.00);

-- Transaction 18 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (18, 8, '8999777888350', 'NIVEA MEN Extra Bright 50ml', 'Perawatan Pribadi', 1, 15000.00, 25000.00, 2500.00, 0.10, 24750.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (18, 9, '8992222056700', 'GATSBY Powder Clay Unbrekable smooth 20g', 'Hair Styling', 1, 45000.00, 49000.00, 0.00, 0.10, 53900.00);

-- Transaction 19 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (19, 1, '8991001101234', 'Biskuit Roma Kelapa 300g', 'Makanan', 2, 8500.00, 12000.00, 1200.00, 0.10, 26400.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (19, 2, '8998866201234', 'Chitato BBQ 68g', 'Makanan', 1, 7000.00, 9500.00, 0.00, 0.10, 10450.00);

-- Transaction 20 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (20, 3, '8998765432101', 'Aqua Botol 600ml', 'Minuman', 3, 2500.00, 4000.00, 400.00, 0.10, 12760.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (20, 4, '8992711234567', 'Teh Botol Sosro 450ml', 'Minuman', 1, 3200.00, 5000.00, 500.00, 0.10, 4950.00);

-- Transaction 21 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (21, 5, '8999999998888', 'Sabun Cuci Piring Sunlight 755ml', 'Perlengkapan Rumah', 1, 11000.00, 14500.00, 0.00, 0.10, 15950.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (21, 6, '8998765987654', 'Lampu LED Philips 10W', 'Elektronik', 2, 22000.00, 29000.00, 2900.00, 0.10, 57200.00);

-- Transaction 22 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (22, 7, '8999991122334', 'Shampoo Pantene 180ml', 'Perawatan Pribadi', 1, 17000.00, 23000.00, 2300.00, 0.10, 22770.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (22, 8, '8999777888350', 'NIVEA MEN Extra Bright 50ml', 'Perawatan Pribadi', 1, 15000.00, 25000.00, 0.00, 0.10, 27500.00);

-- Transaction 23 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (23, 9, '8992222056700', 'GATSBY Powder Clay Unbrekable smooth 20g', 'Hair Styling', 1, 45000.00, 49000.00, 4900.00, 0.10, 53350.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (23, 1, '8991001101234', 'Biskuit Roma Kelapa 300g', 'Makanan', 2, 8500.00, 12000.00, 0.00, 0.10, 26400.00);

-- Transaction 24 items
INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (24, 2, '8998866201234', 'Chitato BBQ 68g', 'Makanan', 1, 7000.00, 9500.00, 950.00, 0.10, 9930.00);

INSERT INTO
    transaction_items (transaction_id, product_id, barcode, name, category, quantity, cost_price, sell_price, discount, tax_rate, final_price)
VALUES
    (24, 3, '8998765432101', 'Aqua Botol 600ml', 'Minuman', 1, 2500.00, 4000.00, 0.00, 0.10, 4400.00);