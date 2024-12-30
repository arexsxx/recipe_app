import 'package:flutter/material.dart';
import 'package:responsi_uts/screens/home_page.dart';
import 'package:responsi_uts/screens/lupa_password.dart';
import 'package:responsi_uts/screens/register_page.dart';
import 'package:responsi_uts/service/auth.dart';
import 'package:responsi_uts/widgets/custom_button.dart';
import 'package:responsi_uts/widgets/text_input_custom.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await login(_emailController.text, _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login berhasil!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login gagal: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

// Email validator disini
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    final emailRex = RegExp(r'\S+@\S+\.\S+');
    if (!emailRex.hasMatch(value)) {
      return "Masukkan email yang valid";
    }
    return null;
  }

// Password validator disini
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 6) {
      return "Password harus memiliki setidaknya 6 karakter";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          spreadRadius: 2,
                          offset: Offset(0.0, 4.0)),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "silahkan login menggunakan akun email dan password",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28.0),
                      CustomTextInput(
                        controller: _emailController,
                        label: "email",
                        hint: "Masukkan email anda",
                        icon: Icons.email_rounded,
                        validator: emailValidator,
                      ),
                      const SizedBox(height: 12),
                      CustomTextInput(
                        controller: _passwordController,
                        label: "password",
                        hint: "Masukkan password dengan benar",
                        icon: Icons.key_rounded,
                        validator: passwordValidator,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LupaPassword()),
                            );
                          },
                          child: const Text(
                            "Lupa Password?",
                            style: TextStyle(
                              color: Color(0xff1D3D1D),
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      CustomButton(
                        label: _isLoading ? "Sedang Memproses..." : "Login",
                        onPressed: _isLoading ? null : handleLogin,
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        "Atau",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            "Daftar sekarang",
                            style: TextStyle(
                              color: Color(0xff1D3D1D),
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
