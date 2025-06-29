# Local Event Finder

Aplikasi Flutter untuk mencari dan menambahkan event lokal berdasarkan lokasi pengguna.

## Fitur Utama

- Autentikasi pengguna (Login & Register)
- Tambah dan edit event
- Pemilihan lokasi event menggunakan peta (Google Maps)
- Penyimpanan data lokal dengan SQLite
- State management menggunakan Provider

## Struktur Folder

lib/
├── models/ # Struktur data (model Event, User)
├── providers/ # Provider untuk User dan Event
├── screens/ # Semua tampilan layar (login, home, register, dsb)
├── widgets/ # Komponen UI terpisah (opsional)
├── main.dart # Entry point aplikasi
