import 'package:flutter/material.dart';
import 'package:responsi_uts/screens/home_page.dart';
import 'package:responsi_uts/screens/profile_page.dart';
import 'package:responsi_uts/widgets/card_data.dart';
import 'package:responsi_uts/widgets/bottom_navigation.dart';

class FavoritesPage extends StatefulWidget {
  final List<CardInfo> cardData;

  const FavoritesPage({Key? key, required this.cardData}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil item favorit (yang memiliki status isLoved = true)
    final favoriteItems =
        widget.cardData.where((item) => item.isLoved).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1D3D1D),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Favorit anda",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
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
      body: favoriteItems.isEmpty
          ? const Center(
              child: Text(
                "Tidak ada item yang disukai.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final data = favoriteItems[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8.0),
                        ),
                        child: Image.asset(
                          data.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.title,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Mengubah status isLoved menjadi false untuk menghapus dari favorit
                                        data.isLoved = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                data.description,
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        data.rating.toString(),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    data.harga,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: ButtomNavigationWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
