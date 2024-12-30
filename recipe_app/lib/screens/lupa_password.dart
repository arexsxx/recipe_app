import 'package:flutter/material.dart';
import 'package:responsi_uts/widgets/custom_button.dart';
import 'package:responsi_uts/widgets/text_input_custom.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
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
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   "assets/images/logo2_uty.png",
                      //   width: 250,
                      //   height: 100,
                      // ),
                      const Text(
                        "Lupa Password",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Masukkan email anda dan tunggu kode yang dikirimkan",
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
                      const SizedBox(height: 28.0),
                      CustomButton(
                        label: "kirim",
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Navigator.pushReplacementNamed(context, "/login");
                          } else {
                            debugPrint("Form validation failed");
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
