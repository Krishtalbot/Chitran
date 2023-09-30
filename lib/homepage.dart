import 'package:chitran/camera.dart';
import 'package:chitran/custom_dialog.dart';
import 'package:chitran/map.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int CurrentIndex = 1;
  final pages = [
    MapPage(),
    HomePageContent(),
    CameraWidget(),
  ]; // Initialize with the initial page index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 151, 105, 1),
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
        index: CurrentIndex,
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
            Icons.home_filled,
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

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            //bottom: 90,
            left: 95,
            right: 50,
            child: GestureDetector(
              onTap: () {
                debugPrint('Image one has been tapped');
              },
              child: Image.asset(
                'assets/1.png',
              ),
            ),
          ),
          Positioned(
            top: 325,
            left: 90,
            child: GestureDetector(
              onTap: () {
                debugPrint('Image two has been tapped');
              },
              child: Image.asset(
                'assets/2.png',
              ),
            ),
          ),
          Positioned(
            top: 600,
            // bottom: 500,
            left: 200,
            right: 30,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog(
                      name: "KalBhairav",
                    );
                  },
                );
              },
              child: Image.asset('assets/3.png'),
            ),
          ),
        ],
      ),
    );
  }
}
