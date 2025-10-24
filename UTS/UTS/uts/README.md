# Aplikasi Pengingat Obat (Medication Reminder)

Ini adalah proyek Ujian Tengah Semester (UTS) mata kuliah Mobile Programming. Aplikasi ini dibuat menggunakan Flutter dan bertujuan untuk membantu pengguna melacak dan mengingat jadwal minum obat harian mereka.

# Tema dan Tujuan Aplikasi

* **Tema:** Kesehatan & Kesejahteraan (Health & Wellness)
* **Tujuan:** Tujuan utama aplikasi ini adalah menyediakan antarmuka yang bersih dan intuitif bagi pengguna untuk melihat jadwal pengobatan mereka. Aplikasi ini membantu mengatasi masalah umum lupa minum obat dengan menyediakan kalender harian dan daftar obat yang harus dikonsumsi.

# Daftar Halaman dan Fungsinya

Aplikasi ini terdiri dari 3 halaman (routes) utama:

1.  **Halaman Home (`home_screen.dart`)**
    * **Fungsi:** Bertindak sebagai dasbor harian. Halaman ini menampilkan daftar obat yang harus diminum pengguna berdasarkan tanggal yang dipilih.
    * **Fitur:**
        * Menampilkan tombol filter cepat untuk "Today" dan "Tomorrow".
        * Menampilkan widget kalender interaktif (`table_calendar`) untuk memilih tanggal tertentu.
        * Menampilkan daftar obat yang dijadwalkan untuk tanggal yang dipilih.
        * Menampilkan status "kosong" jika tidak ada jadwal obat.

2.  **Halaman Medications (`medications_screen.dart`)**
    * **Fungsi:** Bertindak sebagai inventaris atau daftar lengkap semua obat yang terdaftar.
    * **Fitur:**
        * Menampilkan daftar obat yang dibagi menjadi "Active Medicines" dan "Inactive Medicines".
        * Memiliki *search bar* untuk mencari obat.
        * Setiap item obat dapat diketuk untuk melihat detailnya.

3.  **Halaman Detail Obat (`medication_detail_screen.dart`)**
    * **Fungsi:** Menampilkan informasi rinci tentang satu obat yang dipilih.
    * **Fitur:**
        * Menampilkan nama, status (aktif/inaktif), jadwal, dan dosis obat.
        * Menampilkan informasi tambahan (data *dummy*) seperti catatan dari dokter.
        * Memiliki tombol "Back" di `AppBar` untuk kembali ke Halaman Medications.
