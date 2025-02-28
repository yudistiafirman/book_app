# Dokumentasi Aplikasi Book App

Selamat datang di dokumentasi aplikasi Book App, aplikasi berbasis Flutter yang mengintegrasikan data buku dari API publik https://gutendex.com/books. Dokumen ini memberikan panduan penggunaan dan deskripsi fungsionalitas

## Panduan Penggunaan Aplikasi

### Instalasi Dependensi

Untuk menjalankan aplikasi ini, pastikan lingkungan pengembangan Flutter dan Dart telah terinstal pada sistem Anda. Verifikasi versi Flutter dengan perintah berikut:
```bash 
flutter --version
```
Buka terminal di direktori proyek, kemudian jalankan perintah untuk mengunduh dependensi:
```bash 
flutter pub get
```

Perintah ini akan menginstal paket-paket yang diperlukan, seperti:

- provider (untuk manajemen state).
- http (untuk pengambilan data dari API).
- cached_network_image (untuk memuat gambar dari internet).
- fluttertoast (untuk menampilkan toast)

### Running Aplikasi

1. Hubungkan emulator (misalnya Android Emulator) atau perangkat fisik ke komputer Anda, dan pastikan perangkat terdeteksi oleh Flutter:
```bash 
flutter devices
```
2. Jalankan aplikasi dengan perintah:
```bash 
flutter run
```
3. Aplikasi akan dibangun dan dijalankan pada emulator atau perangkat yang dipilih.

## Deskripsi Fungsionalitas Aplikasi
Aplikasi ini menyediakan akses ke daftar buku digital melalui tiga layar utama:

### Halaman Daftar Buku (BookListScreen)
- Fungsi: Menampilkan daftar buku yang diperoleh dari API.
- Fitur:
- Pagination: Pengguna dapat menggulir ke bawah untuk memuat buku tambahan secara otomatis.
- Refresh: Pengguna dapat menyegarkan daftar dengan menarik layar ke bawah.
- Setiap item menampilkan:
  - Cover buku kecil.
  - Judul buku.
  - Nama penulis.
  - Jumlah unduhan.
- Visual: ![Screenshot_1740734844](https://github.com/user-attachments/assets/4736c3a9-ee53-4489-b916-85024b07153a)

### Halaman Pencarian (SearchScreen)

- Fungsi: Memungkinkan pengguna mencari buku berdasarkan kata kunci.
- Cara Penggunaan: Ketik kata kunci di bilah pencarian (misalnya "harry"), tap search icon dan hasil akan ditampilkan dalam daftar.
- Tampilan: Daftar yang mencakup cover, judul, penulis, dan jumlah unduhan.
- Visual: ![Screenshot_1740734884](https://github.com/user-attachments/assets/5752bc08-6c2a-42ac-8157-f06b05a7edee)

### Halaman Detail Buku (BookDetailScreen)

- Fungsi: Menampilkan informasi lengkap buku berdasarkan ID dari API https://gutendex.com/books/{id}.
- Elemen Tampilan:
  - Cover buku besar.
  - Judul buku.
  - Nama penulis.
  - Total unduhan.
  - Ringkasan (jika tersedia).
- Visual: ![Screenshot_1740735133](https://github.com/user-attachments/assets/71e53623-10cd-4cb2-9018-dea6d0b4ac27)

