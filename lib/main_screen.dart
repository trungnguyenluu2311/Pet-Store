import 'package:flutter/material.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem = 0;
  final tabs = [
    const HomeScreen(),
    // Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[_selectedItem],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFFD9D0E3)))
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedItem,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 24,
            selectedItemColor: const Color(0xFF7203FF),
            unselectedItemColor: const Color(0xFF9586A8),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Icon(Icons.home_outlined),
                ),
                label: ''
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.medical_services_outlined),
              //   label: ''
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: ''
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: ''
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedItem = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
