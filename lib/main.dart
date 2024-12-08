import 'package:flutter/material.dart';
import 'package:quran_app/screens/home.dart';
import 'package:quran_app/screens/list_surat.dart';
import 'package:quran_app/screens/list_juz.dart';
import 'package:quran_app/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

void main() {
  runApp(AlQuranApp());
}

class AppColors {
  static const Color primary = Color(0xFF4CAF50); // Soft Green
  static const Color secondary = Color(0xFF81C784); // Light Green
  static const Color background = Color(0xFFF1F8E9); // Very Light Green
  static const Color text = Color(0xFF2E7D32); // Dark Green
  static const Color accent = Color(0xFFAED581); // Muted Green
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainNavigationPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/quran_logo.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 30),
            Text(
              'Al-Quran Digital',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 20),
            SpinKitWave(
              color: AppColors.primary,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

class AlQuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Quran App',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.text),
          bodyMedium: TextStyle(color: AppColors.text),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SuratListPage(),
    JuzListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.background,
        color: AppColors.primary,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.book, size: 30, color: Colors.white),
          Icon(Icons.layers, size: 30, color: Colors.white),
          Icon(Icons.person,
              size: 30, color: Colors.white), // Tambahkan ikon profil
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
