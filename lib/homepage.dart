import 'package:chitran/camera.dart';
import 'package:chitran/map.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int CurrentIndex = 0;
  final pages = [
    const MapPage(),
    const Camera(),
  ]; // Initialize with the initial page index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCE9769),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          pages[CurrentIndex],
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xFFaede71),
        color: const Color(0xffd5f191),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          if (index >= 0 && index < pages.length) {
            setState(() {
              CurrentIndex = index;
            });
          }
        },
        items: const <Widget>[
          Icon(
            Icons.map_rounded,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.camera_alt_rounded,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
    );
  }
}
