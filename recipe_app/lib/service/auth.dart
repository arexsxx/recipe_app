import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = FlutterSecureStorage();

// Fungsi untuk registrasi
Future<void> register(
    String name, String email, String password, String confirmPassword) async {
  final url = Uri.parse("http://192.168.43.212:8000/api/auth/register");

  if (password != confirmPassword) {
    throw Exception("Password dan Konfirmasi Password tidak sama.");
  }

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
      }),
    );

    if (response.statusCode == 201) {
      print("Registrasi berhasil");
    } else {
      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      final error = json.decode(response.body);
      throw Exception(
          "Registrasi gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Registrasi gagal: $e");
  }
}

// Fungsi untuk login
Future<void> login(String email, String password) async {
  final url = Uri.parse("http://192.168.43.212:8000/api/auth/login");

  // Cek email valid
  if (!_isValidEmail(email)) {
    throw Exception("Format email tidak valid.");
  }

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['token']['access_token'];

      // Simpan data ke secure storage
      await secureStorage.write(key: 'access_token', value: accessToken);
      print('Access token berhasil disimpan!');
    } else {
      final error = json.decode(response.body);
      throw Exception("Login gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Login gagal: $e");
  }
}

// Fungsi untuk mendapatkan data profil pengguna yang login
Future<Map<String, dynamic>?> fetchUserProfile() async {
  final url = Uri.parse("http://192.168.43.212:8000/api/user/me");
  final accessToken = await secureStorage.read(key: 'access_token');

  if (accessToken == null) {
    throw Exception("Tidak ada token akses, silakan login terlebih dahulu.");
  }

  try {
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken", // Menggunakan token akses
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Mengembalikan data profil pengguna
    } else {
      final error = json.decode(response.body);
      throw Exception(
          "Gagal mengambil data profil: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Gagal mengambil data profil: $e");
  }
}

// Fungsi untuk cek apakah email valid
bool _isValidEmail(String email) {
  final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return emailRegex.hasMatch(email);
}
