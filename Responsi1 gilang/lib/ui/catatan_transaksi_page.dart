import 'package:aplikasimanajemenkeuangan/bloc/catatan_transaksi_bloc.dart';
import 'package:aplikasimanajemenkeuangan/bloc/logout_bloc.dart';
import 'package:aplikasimanajemenkeuangan/model/catatan_transaksi.dart';
import 'package:aplikasimanajemenkeuangan/ui/catatan_transaksi_detail.dart';
import 'package:aplikasimanajemenkeuangan/ui/catatan_transaksi_form.dart';
import 'package:aplikasimanajemenkeuangan/ui/login_page.dart';
import 'package:aplikasimanajemenkeuangan/widget/success_dialog.dart';
import 'package:flutter/material.dart';

class CatatanTransaksiPage extends StatefulWidget {
  const CatatanTransaksiPage({Key? key}) : super(key: key);

  @override
  _CatatanTransaksiPageState createState() => _CatatanTransaksiPageState();
}

class _CatatanTransaksiPageState extends State<CatatanTransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Catatan Transaksi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B4332), // Warna hijau gelap
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.white),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CatatanTransaksiForm()),
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1B4332), // Warna hijau gelap
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF2D6A4F), // Warna hijau lebih cerah
              ),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => const SuccessDialog(
                      description: "Logout berhasil",
                    ),
                  );
                });
              },
            )
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFF081C15), // Background warna hijau gelap
        child: FutureBuilder<List<CatatanTransaksi>>(
          future: CatatanTransaksiBloc.getCatatanTransaksi(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListCatatanTransaksi(list: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ListCatatanTransaksi extends StatelessWidget {
  final List<CatatanTransaksi>? list;

  const ListCatatanTransaksi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0), // Padding untuk memberikan jarak
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemCatatanTransaksi(transaksi: list![i]);
      },
    );
  }
}

class ItemCatatanTransaksi extends StatelessWidget {
  final CatatanTransaksi transaksi;

  const ItemCatatanTransaksi({Key? key, required this.transaksi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CatatanTransaksiDetail(transaksi: transaksi),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF2D6A4F), // Warna hijau lebih cerah untuk card
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Membuat card lebih halus
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          title: Text(
            transaksi.detail ?? 'N/A',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Rp. ${transaksi.amount.toString()}',
            style: const TextStyle(color: Color(0xFFF1FAEE)), // Warna subtitle
          ),
        ),
      ),
    );
  }
}
