import 'package:aplikasimanajemenkeuangan/bloc/catatan_transaksi_bloc.dart';
import 'package:aplikasimanajemenkeuangan/model/catatan_transaksi.dart';
import 'package:aplikasimanajemenkeuangan/ui/catatan_transaksi_form.dart';
import 'package:aplikasimanajemenkeuangan/ui/catatan_transaksi_page.dart';
import 'package:aplikasimanajemenkeuangan/widget/success_dialog.dart';
import 'package:aplikasimanajemenkeuangan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';

class CatatanTransaksiDetail extends StatefulWidget {
  final CatatanTransaksi? transaksi; // Field marked as final

  CatatanTransaksiDetail({Key? key, this.transaksi}) : super(key: key);

  @override
  _CatatanTransaksiDetailState createState() => _CatatanTransaksiDetailState();
}

class _CatatanTransaksiDetailState extends State<CatatanTransaksiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi Keuangan'),
        backgroundColor: const Color(0xFF1B4332), // Warna hijau tua
        foregroundColor: Colors.white, // Warna teks putih
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDetailCard(), // Menggunakan fungsi untuk membuat Card
              const SizedBox(height: 16.0),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF191A19), // Background warna dark green
    );
  }

  Widget _buildDetailCard() {
    return Card(
      color: const Color(0xFF2D6A4F), // Warna card
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Sudut card yang halus
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailTextWidget("Detail: ${widget.transaksi?.detail ?? 'N/A'}"),
            const SizedBox(height: 8.0),
            _detailTextWidget(
                "Jumlah: Rp. ${widget.transaksi?.amount.toString() ?? '0'}"),
            const SizedBox(height: 8.0),
            _detailTextWidget(
                "Kategori: ${widget.transaksi?.category ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }

  Widget _detailTextWidget(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 20.0, color: Color(0xFFD8E9A8)), // Warna teks
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF4E9F3D), // Warna tombol
            side: const BorderSide(color: Color(0xFF4E9F3D)), // Warna garis
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatatanTransaksiForm(
                  transaksi: widget.transaksi!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 16.0),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF4E9F3D), // Warna tombol
            side: const BorderSide(color: Color(0xFF4E9F3D)), // Warna garis
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor:
          const Color(0xFF2D6A4F), // Background color of the dialog
      content: Column(
        mainAxisSize:
            MainAxisSize.min, // Make the dialog's content size adaptive
        children: [
          const Text(
            "Yakin ingin menghapus data ini?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center, // Center the text
          ),
          const SizedBox(height: 16.0), // Add some space
        ],
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text(
            "Ya",
            style: TextStyle(color: Colors.white), // Change text color
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor:
                const Color(0xFF4E9F3D), // Background color of the button
            side: const BorderSide(color: Color(0xFF4E9F3D)), // Border color
          ),
          onPressed: () {
            CatatanTransaksiBloc.deleteCatatanTransaksi(
                    id: widget.transaksi!.id!)
                .then(
              (value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const CatatanTransaksiPage()),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const SuccessDialog(
                    description: "Hapus berhasil",
                  ),
                );
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text(
            "Batal",
            style: TextStyle(color: Colors.white), // Change text color
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor:
                const Color(0xFF4E9F3D), // Background color of the button
            side: const BorderSide(color: Color(0xFF4E9F3D)), // Border color
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
