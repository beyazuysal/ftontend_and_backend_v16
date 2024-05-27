import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_1/ana_page/info_page.dart';
import 'package:yeni_kayan_ekran/isaretci_1/ana_page/main_page.dart';
import 'package:yeni_kayan_ekran/isaretci_1/ana_page/profile_page.dart';

class NavigationBarControlPage extends StatefulWidget {
  const NavigationBarControlPage({super.key});

  @override
  State<NavigationBarControlPage> createState() =>
      _NavigationBarControlPageState();
}

class _NavigationBarControlPageState extends State<NavigationBarControlPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade200,
        color: Colors.grey.shade100,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Icon(
                  Icons.home_rounded,
                  size: 25,
                  color: Colors.grey.shade900,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Icon(
                  Icons.person_rounded,
                  size: 25,
                  color: Colors.grey.shade900,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 9.0,
                ),
                Icon(
                  Icons.feed_rounded,
                  size: 25,
                  color: Colors.grey.shade900,
                ),
              ],
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }

  // Define your pages or sections here
  final List<Widget> _pages = [
    // Replace these with your actual pages or widgets
    Container(color: Colors.green, child: Center(child: MainPage())),
    Container(color: Colors.green, child: Center(child: ProfilePage())),
    Container(color: Colors.green, child: Center(child: InfoPage())),
  ];
}
