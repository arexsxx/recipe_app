import 'package:flutter/material.dart';

class ButtomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const ButtomNavigationWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1D3D1D),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      // margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BottomNavigationBar(
          backgroundColor: Color(0xff1D3D1D),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 32,
              ),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 32,
              ),
              label: "Like",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                size: 32,
              ),
              label: "Profil",
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Color(0xfff1f1f1),
          selectedFontSize: 18,
          unselectedFontSize: 16,
          type: BottomNavigationBarType.fixed,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
