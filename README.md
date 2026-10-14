# EcoVolt – Smart Energy Monitor

**EcoVolt** adalah aplikasi berbasis Flutter yang dirancang sebagai simulasi pemantauan penggunaan energi listrik. Aplikasi ini memiliki tampilan interaktif dan menerapkan berbagai widget layout serta gesture untuk memberikan pengalaman pengguna yang dinamis.

Proyek ini dibuat untuk memenuhi tugas praktikum Flutter mengenai penggunaan **Complex Layout Widgets** dan **Gesture Interaction**.

## Tentang Aplikasi

EcoVolt mengusung konsep pemantauan energi pintar yang mendukung tujuan **Sustainable Development Goal (SDG) 7: Affordable and Clean Energy**, yaitu energi bersih dan terjangkau.

Melalui aplikasi ini, pengguna dapat melihat informasi energi, mencoba interaksi pada kartu energi, dan menggerakkan ikon petir melalui area interaktif.

## Fitur Utama

-  **Energy Monitor** — menampilkan status energi dan informasi penggunaan listrik.
-  **Tap Gesture** — mengetuk kartu energi untuk mengubah status energi.
-  **Long Press Gesture** — menekan lama kartu untuk menampilkan atau menyembunyikan detail perangkat.
-  **Drag / Pan Gesture** — menggerakkan ikon petir pada area interaktif.
-  **Ringkasan Penggunaan** — menampilkan informasi konsumsi energi dan biaya.
-  **Animated UI** — menggunakan animasi untuk perubahan tampilan kartu energi.
-  **Reset Demo** — mengembalikan status interaksi ke kondisi awal.

> Catatan: Informasi konsumsi, daya, dan biaya pada proyek ini merupakan simulasi, bukan hasil pengukuran perangkat listrik secara langsung.

##  Teknologi dan Widget

**Teknologi:**
- Flutter
- Dart

**Widget utama yang digunakan:**

| Widget | Fungsi |
|---|---|
| `MaterialApp` | Mengatur aplikasi dan tema |
| `Scaffold` | Struktur dasar halaman |
| `SafeArea` | Menjaga konten dari area sistem |
| `SingleChildScrollView` | Memungkinkan halaman digulir |
| `Column` | Menyusun widget secara vertikal |
| `Row` | Menyusun widget secara horizontal |
| `Card` | Menampilkan informasi dalam kartu |
| `Stack` | Menumpuk beberapa widget |
| `GestureDetector` | Menangani interaksi gesture |
| `AnimatedContainer` | Memberikan animasi perubahan tampilan |
| `CustomPaint` | Menggambar grid pada area interaktif |
| `Positioned` | Mengatur posisi ikon dalam `Stack` |

##  Implementasi Gesture

### 1. Tap
Pengguna mengetuk kartu energi utama untuk mengubah status energi. Tampilan dan informasi pada kartu menyesuaikan status tersebut.

### 2. Long Press
Pengguna menekan lama kartu energi untuk menampilkan atau menyembunyikan detail perangkat.

### 3. Drag / Pan
Pengguna menggeser ikon petir pada area interaktif. Posisi ikon diperbarui mengikuti gerakan pengguna.

##  Struktur Proyek

```text
ecovolt/
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
├── web/
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

*Struktur di atas merupakan gambaran umum proyek Flutter; isi folder dapat berbeda sesuai platform yang dibuat.*

##  Cara Menjalankan Aplikasi

### Prasyarat
- Flutter SDK sudah terpasang.
- Dart SDK tersedia melalui instalasi Flutter.
- Visual Studio Code atau IDE lain yang mendukung Flutter.
- Browser Chrome atau emulator untuk menjalankan aplikasi.

### Langkah instalasi

1. Clone repository:

   ```bash
   git clone https://github.com/USERNAME/ecovolt.git
   ```

2. Masuk ke direktori proyek:

   ```bash
   cd ecovolt
   ```

3. Unduh dependensi:

   ```bash
   flutter pub get
   ```

4. Jalankan aplikasi di Chrome:

   ```bash
   flutter run -d chrome
   ```

   Atau jalankan melalui emulator/perangkat yang tersedia:

   ```bash
   flutter run
   ```

**Penting:** Ganti
