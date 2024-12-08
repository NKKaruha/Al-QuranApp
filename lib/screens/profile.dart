import 'package:flutter/material.dart';
import 'package:quran_app/main.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.secondary.withOpacity(0.3),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                  'lib/assets/profile.png'), // Ganti dengan foto profil Anda
            ),
            SizedBox(height: 20),
            Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pecinta Al-Quran',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.text.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 30),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildProfileItem(
                        Icons.email, 'Email', 'example@gmail.com'),
                    Divider(),
                    _buildProfileItem(Icons.person, 'Username', 'example'),
                    Divider(),
                    _buildProfileItem(Icons.language, 'Bahasa', 'example'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.text.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
