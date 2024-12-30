import 'package:flutter/material.dart';
import 'package:responsi_uts/screens/login_page.dart';
import 'package:responsi_uts/service/auth.dart';
import 'package:responsi_uts/widgets/custom_button.dart';
import 'package:responsi_uts/widgets/text_input_custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  void handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        await register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmpasswordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registrasi berhasil!")),
        );

        // Navigasi ke halaman login setelah berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const loginPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registrasi gagal: $e")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

// name validator disini
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Nama tidak boleh kosong";
    }
    if (value.length < 2) {
      return "Masukkan nama lengkap anda";
    }
    return null;
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

// Confirm Password validator disini
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 6) {
      return "Password tidak sesuai";
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
                        "Daftar",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Isilah form dengan benar",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 28.0),
                      CustomTextInput(
                        controller: _nameController,
                        label: "nama",
                        hint: "Masukkan nama lengkap",
                        icon: Icons.person_rounded,
                        validator: nameValidator,
                      ),
                      const SizedBox(height: 12),
                      CustomTextInput(
                        controller: _emailController,
                        label: "email",
                        hint: "Masukkan email yang sesuai",
                        icon: Icons.email_rounded,
                        validator: emailValidator,
                      ),
                      const SizedBox(height: 12),
                      CustomTextInput(
                        controller: _passwordController,
                        label: "password",
                        hint: "Masukkan password",
                        icon: Icons.key_rounded,
                        validator: passwordValidator,
                      ),
                      const SizedBox(height: 12),
                      CustomTextInput(
                        controller: _confirmpasswordController,
                        label: "confirm password",
                        hint: "Masukkan password",
                        icon: Icons.key_rounded,
                        validator: confirmPasswordValidator,
                      ),
                      const SizedBox(height: 48.0),
                      CustomButton(
                        label: _isLoading ? "Sedang Memproses..." : "Daftar",
                        onPressed: _isLoading ? null : handleRegister,
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
                                  builder: (context) => const loginPage()),
                            );
                          },
                          child: const Text(
                            "Masuk",
                            style: TextStyle(
                              color: Colors.green,
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
