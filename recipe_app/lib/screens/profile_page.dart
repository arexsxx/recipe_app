import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:responsi_uts/screens/edit_profil.dart';
import 'package:responsi_uts/screens/home_page.dart';
import 'package:responsi_uts/screens/splash_screen.dart';
import 'package:responsi_uts/widgets/bottom_navigation.dart';

final secureStorage = FlutterSecureStorage();

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;
  String _name = '';
  String _email = '';

  // Fungsi untuk mengambil data profil pengguna
  Future<void> fetchUserProfile() async {
    final accessToken = await secureStorage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception("Tidak ada token akses, silakan login terlebih dahulu.");
    }

    final url = Uri.parse("http://192.168.43.212:8000/api/user/me");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken", 
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _name = data['name'] ?? 'Nama tidak tersedia';
          _email = data['email'] ?? 'Email tidak tersedia';
        });
      } else {
        final error = json.decode(response.body);
        throw Exception(
            "Gagal mengambil data profil: ${error['message'] ?? 'Kesalahan server'}");
      }
    } catch (e) {
      throw Exception("Gagal mengambil data profil: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile(); // Memanggil fungsi untuk mengambil profil saat halaman dimuat
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xff1D3D1D),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Informasi Akun",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                SizedBox(width: 6),
                Icon(
                  Icons.notifications_rounded,
                  size: 26,
                  color: Colors.white,
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("assets/images/spalsh.png"),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Text(
                  _name.isNotEmpty ? _name : 'Nama tidak tersedia',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _email.isNotEmpty ? _email : 'Email tidak tersedia',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // mengedit akun
          ListTile(
            leading: const Icon(Icons.person_rounded, color: Color(0xff1D3D1D)),
            title: const Text(
              "Kelola Akun",
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfil()),
              );
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.lock_rounded, color: Color(0xff1D3D1D)),
            title: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ),
          const Divider(),
          const ListTile(
            leading:
                Icon(Icons.notifications_rounded, color: Color(0xff1D3D1D)),
            title: Text(
              "Notifikasi",
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.help_rounded, color: Color(0xff1D3D1D)),
            title: Text(
              "Terms of service",
              style: TextStyle(fontSize: 18),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Color(0xff1D3D1D)),
            title: const Text(
              "Keluar",
              style: TextStyle(fontSize: 18),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
              );
            },
          ),
          const Divider(),
        ],
      ),
      bottomNavigationBar: ButtomNavigationWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
