Berikut adalah dokumentasi setup proyek yang dapat kamu gunakan untuk GitHub. Ini akan membantu orang lain menjalankan proyek kamu dengan mudah.

---

## 📂 Point of Sales - PHP Native

### **Deskripsi Proyek**
Proyek ini adalah sistem Point of Sales (POS) berbasis PHP Native dengan implementasi PSR-4 autoload dan menggunakan database MySQL untuk penyimpanan data. Proyek ini dirancang untuk fleksibilitas, skalabilitas, dan kemudahan pengelolaan.

---

### **Langkah-Langkah Setup**

#### **1. Clone Proyek**
Clone repository ini ke direktori lokal kamu:
```bash
git clone https://github.com/abyalax/Project-Point-Of-Sales.git
cd point-of-sales
```

#### **2. Konfigurasi Environment**
Salin file `.env.example` (jika tersedia) menjadi `.env` dan sesuaikan konfigurasi database:
```dotenv
DB_HOST=localhost
DB_NAME=nama_database
DB_USER=root
DB_PASSWORD=password_kamu
```

#### **3. Install Dependencies**
Jalankan perintah berikut untuk menginstall dependencies yang diperlukan:
```bash
composer install
```

#### **4. Import Struktur Database**
Gunakan file migrasi terbaru (`init-3.sql`) untuk menginisialisasi struktur database. Jalankan perintah ini di MySQL:
```bash
mysql -u username -p database_name < database/migrations/init-3.sql
```

#### **5. Import Data Awal**
Jika diperlukan, import data awal menggunakan file seed terbaru (`init-3.sql`):
```bash
mysql -u username -p database_name < database/seeds/init-3.sql
```

#### **6. Jalankan Proyek**
Pastikan Apache dan MySQL berjalan, lalu akses aplikasi melalui browser dengan URL:
```
http://localhost/point-of-sales
```

---

### **Struktur Direktori**
Penjelasan singkat tentang beberapa folder utama:
- **app/**: Berisi kode utama aplikasi (PSR-4 autoload).
- **database/**: Berisi file migrasi dan seed untuk setup database.
- **public/**: Root akses aplikasi melalui server web.
- **resources/**: Berisi komponen, template, dan script frontend.
- **docs/**: Dokumentasi tambahan dan diagram alur sistem.

---
