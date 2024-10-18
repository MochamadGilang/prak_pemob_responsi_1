import 'package:aplikasimanajemenkeuangan/bloc/login_bloc.dart';
import 'package:aplikasimanajemenkeuangan/helpers/user_info.dart';
import 'package:aplikasimanajemenkeuangan/ui/catatan_transaksi_page.dart';
import 'package:aplikasimanajemenkeuangan/ui/registrasi_page.dart';
import 'package:aplikasimanajemenkeuangan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  bool _isButtonVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B4332), // Warna hijau gelap
        centerTitle: true, // Memposisikan judul di tengah
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Mengatur padding agar lebih rapi
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _emailTextField(),
                const SizedBox(height: 20),
                _passwordTextField(),
                const SizedBox(height: 30),
                Center(
                    child:
                        _buttonLogin()), // Menempatkan tombol login di tengah
                const SizedBox(height: 30),
                Center(
                    child:
                        _menuRegistrasi()), // Menempatkan menu registrasi di tengah
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF081C15), // Background warna hijau gelap
    );
  }

  // Membuat Textbox email dengan icon
  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.email,
            color: Colors.white), // Icon email dengan warna putih
        labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white), // Label teks berwarna putih
        filled: true,
        fillColor:
            const Color(0xFF2D6A4F), // Warna hijau lebih cerah untuk kontras
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      style:
          const TextStyle(color: Color(0xFFF1FAEE)), // Warna teks lebih terang
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  // Membuat Textbox password dengan icon
  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock,
            color: Colors.white), // Icon password dengan warna putih
        labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white), // Warna label putih
        filled: true,
        fillColor:
            const Color(0xFF2D6A4F), // Warna latar belakang hijau lebih terang
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      style:
          const TextStyle(color: Color(0xFFF1FAEE)), // Warna teks lebih terang
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Login dengan animasi dan icon
  Widget _buttonLogin() {
    return AnimatedOpacity(
      opacity: _isButtonVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.login), // Icon login
        label: const Text("Login"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF52B788), // Warna hijau terang
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
            fontSize: 16,
          ),
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        },
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
      _isButtonVisible = false;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CatatanTransaksiPage()));
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
      _isButtonVisible = true;
    });
  }

  // Membuat menu untuk membuka halaman registrasi dengan icon
  Widget _menuRegistrasi() {
    return InkWell(
      child: const Text(
        "Registrasi",
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()));
      },
    );
  }
}
