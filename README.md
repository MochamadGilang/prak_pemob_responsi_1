Nama : Mochamad Gilang Fadil Hakim

NIM  : H1D022082

Shift : B

# TAMPILAN APLIKASI 

# REGISTRASI 
![WhatsApp Image 2024-10-18 at 6 10 58 PM](https://github.com/user-attachments/assets/3378b30d-9a4e-4ddb-bfac-0171f5d40f28)
![WhatsApp Image 2024-10-18 at 6 10 58 PM(1)](https://github.com/user-attachments/assets/708f60b6-4aff-4bc9-9e34-84e9a24b35d0)

# LOGIN
![WhatsApp Image 2024-10-18 at 6 10 59 PM](https://github.com/user-attachments/assets/0372bf78-ce42-4dc2-bd78-71a191ace2a5)
![WhatsApp Image 2024-10-18 at 6 10 58 PM(2)](https://github.com/user-attachments/assets/d34f01b7-57a8-47aa-afd5-ba83c2511ced)

# HALAMAN UTAMA
![WhatsApp Image 2024-10-18 at 6 11 27 PM](https://github.com/user-attachments/assets/73e426fc-3adf-4afe-b2e9-b462993c4d51)

# CREATE
![WhatsApp Image 2024-10-18 at 6 11 45 PM](https://github.com/user-attachments/assets/628485f9-1999-4ce6-8146-5b5ba3a37256)
![WhatsApp Image 2024-10-18 at 6 11 45 PM(1)](https://github.com/user-attachments/assets/c87ab549-235f-4bf0-855b-6d4bc2c3657d)

# UPDATE
![WhatsApp Image 2024-10-18 at 6 12 54 PM](https://github.com/user-attachments/assets/522e4528-df53-4049-ba67-4e784bff29a4)
![WhatsApp Image 2024-10-18 at 6 12 55 PM](https://github.com/user-attachments/assets/ef6e2e41-a09a-4627-a2d5-584cc15e1508)
![WhatsApp Image 2024-10-18 at 6 12 55 PM(1)](https://github.com/user-attachments/assets/04e1bd7b-3508-4727-92a9-c4a5de9b217e)

# DELETE
![WhatsApp Image 2024-10-18 at 6 15 56 PM](https://github.com/user-attachments/assets/e6ecff3b-44f7-4163-9bf8-90599a350359)
![WhatsApp Image 2024-10-18 at 6 15 56 PM(1)](https://github.com/user-attachments/assets/b0ac10f0-72de-41d0-9991-05238a869895)

# LOGOUT BERHASIL 
![WhatsApp Image 2024-10-18 at 6 16 11 PM](https://github.com/user-attachments/assets/e85d8366-89dc-4551-a844-9b8b430f08e5)


# PENJELASAN SINGKAT

# REGISTRASI

1. RegistrasiPage Class:
Ini adalah halaman utama untuk registrasi, yang berupa StatefulWidget karena memiliki state yang bisa berubah selama aplikasi berjalan. Kelas ini memiliki dua bagian utama:
•	RegistrasiPage: Kelas utama halaman yang mewarisi dari StatefulWidget.
•	_RegistrasiPageState: State dari halaman yang menyimpan data dan logika yang dibutuhkan. Di sini terdapat form registrasi dengan beberapa text field (nama, email, password, konfirmasi password), serta tombol registrasi.
2. State Management:
•	Controller untuk Input Field: Ada tiga TextEditingController yang digunakan untuk menangani input data pengguna:
o	_namaTextboxController: untuk input nama.
o	_emailTextboxController: untuk input email.
o	_passwordTextboxController: untuk input password.
•	GlobalKey: GlobalKey<FormState> digunakan untuk mengelola state dari form dan memvalidasi input pengguna.
•	Loading State: _isLoading digunakan untuk mengontrol apakah proses registrasi sedang berjalan atau tidak, sehingga tombol registrasi bisa dinonaktifkan saat loading.
3. Form Input (Text Fields):
Beberapa TextFormField digunakan untuk mendapatkan input dari pengguna:
•	Nama: Validasi memastikan nama minimal memiliki 3 karakter.
•	Email: Menggunakan regex untuk memvalidasi apakah email valid.
•	Password: Validasi memastikan password minimal 6 karakter.
•	Konfirmasi Password: Memastikan password yang dimasukkan di sini sesuai dengan password yang diinput sebelumnya.
Setiap TextFormField menggunakan desain warna yang sesuai dengan tema aplikasi (nuansa hijau gelap dan terang).
4. Tombol Registrasi:
•	Tombol ini memanggil fungsi _submit() ketika ditekan, setelah memastikan semua input valid.
5. Proses Registrasi (Submit):
Fungsi _submit() akan:
•	Memvalidasi input form.
•	Jika valid, mengirim data (nama, email, password) ke server dengan menggunakan fungsi dari RegistrasiBloc.
•	Jika berhasil, menampilkan dialog SuccessDialog yang menginformasikan bahwa registrasi berhasil.
•	Jika gagal, menampilkan dialog WarningDialog yang menginformasikan kegagalan registrasi.
6. API Integration:
Pada bagian ini, kelas RegistrasiBloc digunakan untuk berkomunikasi dengan backend:
•	API URL: ApiUrl.registrasi mengarah ke endpoint registrasi pada server.
•	registrasi Function: Mengirimkan data registrasi ke server melalui HTTP POST request. Data dikirim sebagai JSON (nama, email, password).
•	Response Handling: Mengubah response JSON yang diterima dari server menjadi objek Registrasi yang berisi kode status, status (berhasil atau gagal), dan pesan dari server.
7. Helper Classes:
•	ApiUrl: Kelas ini menyimpan URL yang digunakan dalam API. Ada beberapa URL untuk registrasi, login, dan transaksi keuangan.
•	Registrasi: Model data untuk menampung hasil dari registrasi, yang diambil dari JSON response server.
8. Dialog Box:
•	SuccessDialog: Menampilkan dialog bahwa registrasi berhasil dan meminta pengguna untuk login.
•	WarningDialog: Menampilkan dialog peringatan jika terjadi kesalahan dalam proses registrasi.
Alur Proses:
1.	Pengguna memasukkan data di form.
2.	Tombol registrasi diklik, data validasi, dan request dikirim ke server.
3.	Jika berhasil, pengguna diberi notifikasi bahwa registrasi berhasil; jika gagal, pengguna diberi peringatan.

# LOGIN

LoginPage: Halaman login yang terdiri dari form email, password, dan tombol login.
LoginPageState: Mengelola state dan logika login, termasuk validasi form dan tombol animasi.
submit(): Fungsi yang mengirim data login ke API melalui LoginBloc. Jika sukses, token disimpan dan pengguna diarahkan ke halaman transaksi. Jika gagal, ditampilkan dialog peringatan.
Tampilan: Desain menggunakan warna hijau gelap, teks terang, dan tata letak yang responsif. Ada juga link ke halaman registrasi.


# CREATE

CatatanTransaksiForm: Form untuk input detail transaksi (deskripsi, jumlah, kategori) dengan validasi form dan tombol submit.
isUpdate(): Memeriksa apakah transaksi sedang diperbarui atau baru. Jika diperbarui, form diisi dengan data transaksi yang ada.
simpan() dan ubah(): Fungsi untuk menyimpan transaksi baru atau memperbarui transaksi yang ada menggunakan CatatanTransaksiBloc. Setelah operasi berhasil, pengguna diarahkan kembali ke halaman transaksi dan dialog sukses ditampilkan.
CatatanTransaksiBloc: Berisi fungsi untuk berkomunikasi dengan API, seperti mengambil, menambah, memperbarui, dan menghapus transaksi dari server

# UPDATE

PENJELASAN DI GABUNG SAMA CREATE

CatatanTransaksiForm: Form untuk input detail transaksi (deskripsi, jumlah, kategori) dengan validasi form dan tombol submit.
isUpdate(): Memeriksa apakah transaksi sedang diperbarui atau baru. Jika diperbarui, form diisi dengan data transaksi yang ada.
simpan() dan ubah(): Fungsi untuk menyimpan transaksi baru atau memperbarui transaksi yang ada menggunakan CatatanTransaksiBloc. Setelah operasi berhasil, pengguna diarahkan kembali ke halaman transaksi dan dialog sukses ditampilkan.
CatatanTransaksiBloc: Berisi fungsi untuk berkomunikasi dengan API, seperti mengambil, menambah, memperbarui, dan menghapus transaksi dari server.

# LOGOUT

CatatanTransaksiDetail: Sebuah widget yang menampilkan detail dari sebuah transaksi keuangan yang sudah disimpan dalam aplikasi. Transaksi ditampilkan di dalam sebuah Card.
buildDetailCard(): Fungsi yang membuat tampilan untuk menampilkan informasi detail transaksi, seperti deskripsi, jumlah, dan kategori.
tombolHapusEdit(): Menyediakan dua tombol, yaitu tombol "EDIT" untuk mengubah transaksi dengan membuka form edit, dan tombol "DELETE" untuk menghapus transaksi.
confirmHapus(): Sebuah fungsi yang menampilkan dialog konfirmasi sebelum transaksi dihapus. Jika pengguna mengonfirmasi, transaksi akan dihapus dengan menggunakan fungsi deleteCatatanTransaksi dari CatatanTransaksiBloc.
CatatanTransaksiBloc.deleteCatatanTransaksi(): Fungsi untuk menghapus transaksi dari database melalui API. Jika berhasil, pengguna diarahkan kembali ke halaman daftar transaksi dan ditampilkan dialog sukses.

