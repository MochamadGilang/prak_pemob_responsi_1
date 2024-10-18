import 'package:aplikasimanajemenkeuangan/bloc/catatan_transaksi_bloc.dart';
import 'package:aplikasimanajemenkeuangan/model/catatan_transaksi.dart';
import 'package:aplikasimanajemenkeuangan/ui/catatan_transaksi_page.dart';
import 'package:aplikasimanajemenkeuangan/widget/success_dialog.dart';
import 'package:aplikasimanajemenkeuangan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';

class CatatanTransaksiForm extends StatefulWidget {
  CatatanTransaksi? transaksi;
  CatatanTransaksiForm({Key? key, this.transaksi}) : super(key: key);

  @override
  _CatatanTransaksiFormState createState() => _CatatanTransaksiFormState();
}

class _CatatanTransaksiFormState extends State<CatatanTransaksiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Catatan Transaksi";
  String tombolSubmit = "Simpan Transaksi";
  final _detailTextboxController = TextEditingController();
  final _amountTextboxController = TextEditingController();
  final _categoryTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.transaksi != null) {
      setState(() {
        judul = "Ubah Catatan Transaksi";
        tombolSubmit = "Ubah Transaksi";
        _detailTextboxController.text = widget.transaksi!.detail!;
        _amountTextboxController.text = widget.transaksi!.amount.toString();
        _categoryTextboxController.text = widget.transaksi!.category!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1B4332), // Warna hijau tua
        foregroundColor: Colors.white, // Warna teks putih
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _detailTextField(),
                const SizedBox(height: 16),
                _amountTextField(),
                const SizedBox(height: 16),
                _categoryTextField(),
                const SizedBox(height: 24),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF191A19), // Background warna dark green
    );
  }

  // Membuat Textbox Detail Transaksi
  Widget _detailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Deskripsi Transaksi",
        prefixIcon: const Icon(Icons.description, color: Colors.white),
        filled: true,
        fillColor: const Color(0xFF1E5128), // Warna hijau tua background
        labelStyle: const TextStyle(
          color: Colors.white, // Warna label teks
          fontWeight: FontWeight.bold,
        ),
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(color: Color(0xFFD8E9A8)), // Warna teks
      controller: _detailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deskripsi transaksi harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Jumlah
  Widget _amountTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Jumlah Nominal",
        prefixIcon: const Icon(Icons.attach_money, color: Colors.white),
        filled: true,
        fillColor: const Color(0xFF1E5128),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(color: Color(0xFFD8E9A8)),
      keyboardType: TextInputType.number,
      controller: _amountTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah nominal harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Kategori
  Widget _categoryTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kategori Transaksi",
        prefixIcon: const Icon(Icons.category, color: Colors.white),
        filled: true,
        fillColor: const Color(0xFF1E5128),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(color: Color(0xFFD8E9A8)),
      controller: _categoryTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kategori transaksi harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.save_alt, color: Colors.white),
      label: Text(tombolSubmit,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white)), // Change font color to white
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4E9F3D), // Warna tombol
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: const TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 16,
            color: Colors.white), // Change font color to white
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            widget.transaksi != null ? ubah() : simpan();
          }
        }
      },
    );
  }

  // Fungsi untuk menyimpan data transaksi baru
  void simpan() {
    setState(() {
      _isLoading = true;
    });
    CatatanTransaksi createTransaksi = CatatanTransaksi(id: null);
    createTransaksi.detail = _detailTextboxController.text;
    createTransaksi.amount = int.parse(_amountTextboxController.text);
    createTransaksi.category = _categoryTextboxController.text;

    CatatanTransaksiBloc.addCatatanTransaksi(transaksi: createTransaksi).then(
        (value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const CatatanTransaksiPage()));
      showDialog(
          context: context,
          builder: (BuildContext context) => const SuccessDialog(
                description: "Data transaksi berhasil disimpan",
              ));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Gagal menyimpan data, silakan coba lagi",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }

  // Fungsi untuk mengubah data transaksi
  void ubah() {
    setState(() {
      _isLoading = true;
    });
    CatatanTransaksi updateTransaksi =
        CatatanTransaksi(id: widget.transaksi!.id!);
    updateTransaksi.detail = _detailTextboxController.text;
    updateTransaksi.amount = int.parse(_amountTextboxController.text);
    updateTransaksi.category = _categoryTextboxController.text;

    CatatanTransaksiBloc.updateCatatanTransaksi(transaksi: updateTransaksi)
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const CatatanTransaksiPage()));
      showDialog(
          context: context,
          builder: (BuildContext context) => const SuccessDialog(
                description: "Data transaksi berhasil diperbarui",
              ));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Gagal mengubah data, silakan coba lagi",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }
}
