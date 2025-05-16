

<h1 align="center">🧾 PROJECT-POINT-OF-SALES</h1>
<p align="center"><em>Empower Sales, Elevate Experiences, Drive Success.</em></p>

<p align="center">
  <img alt="last commit" src="https://img.shields.io/github/last-commit/abyalax/Project-Point-Of-Sales?style=flat-square">
  <img alt="smarty usage" src="https://img.shields.io/badge/smarty-yellow?style=flat-square">
  <img alt="nodejs" src="https://img.shields.io/npm/v/npm.svg?logo=nodedotjs">
  <img alt="languages" src="https://img.shields.io/github/languages/count/abyalax/Project-Point-Of-Sales?style=flat-square">
</p>

<p align="center"><em>Built with language:</em></p>

<p align="center">
  <img src="https://img.shields.io/badge/PHP-777bb4?style=flat-square&logo=php&logoColor=white">
  <img src="https://img.shields.io/badge/💡Smarty-Template Engine-yellow?style=flat-square&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAV1BMVEUAAAD///////////////////////////////////////////////////////////////+hoaH///+ZmZn///+xsbH///+vr6////+1tbX////////c3Nz///////+jo6P///+ioqL///+kpKSYmJjMzMyjo6PU1NSWlpa7u7vjDEmsAAAAR0lEQVR42mNggAMYYDgwMDAwYGBgMDEwAAggZGBkZGZgYmBgYkRgABaARiSEyMmZkxMWBiZmFlZWFiYWJjZ2D4pQMALZ4RryHCA6UAAAAASUVORK5CYII=">
  <img src="https://img.shields.io/badge/TypeScript-007acc?style=flat-square&logo=typescript&logoColor=white">
</p>

<p align="center"><em>Tools and technologies:</em></p>

<p align="center">
  <img src="https://img.shields.io/badge/Composer-885630?style=flat-square&logo=composer&logoColor=white">
  <img src="https://img.shields.io/badge/npm-red?style=flat-square&logo=npm">
  <img src="https://img.shields.io/badge/TypeScript-007acc?style=flat-square&logo=typescript&logoColor=white">
  <img src="https://img.shields.io/badge/PHP-777bb4?style=flat-square&logo=php&logoColor=white">
  <img src="https://img.shields.io/badge/Vite-646CFF?style=flat-square&logo=vite&logoColor=white">
    <img src="https://img.shields.io/badge/Bootstrap-7952B3?style=flat-square&logo=bootstrap&logoColor=white">
  <img src="https://img.shields.io/badge/Chart.js-f5788d?style=flat-square&logo=chartdotjs&logoColor=white">
  <img src="https://img.shields.io/badge/JSON-black?style=flat-square&logo=json">
</p>

<p align="center"><em>Architecture :</em></p>

<p align="center">
  <img src="https://img.shields.io/badge/REST-API-42a5f5?style=flat-square" alt="REST">
  <img src="https://img.shields.io/badge/MVC-Model_View_Controller-4caf50?style=flat-square" alt="MVC">
</p>

---

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


Generate Class Diagram
```bash
vendor/bin/phuml phuml:diagram -r -t -m -p dot app example.png
```