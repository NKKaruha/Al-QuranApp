import 'package:flutter/material.dart';
import 'package:quran_app/api/api.dart';
import 'detail_juz.dart';

class JuzListPage extends StatefulWidget {
  @override
  _JuzListPageState createState() => _JuzListPageState();
}

class _JuzListPageState extends State<JuzListPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> juzList = [];
  bool isLoading = true;
  String selectedEdition = 'quran-uthmani'; // Default edition

  @override
  void initState() {
    super.initState();
    _fetchJuzList();
  }

  Future<void> _fetchJuzList() async {
    try {
      final data = await _apiService.fetchJuz();
      setState(() {
        juzList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data juz: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Juz'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.language),
            onSelected: (String result) {
              setState(() {
                selectedEdition = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'quran-uthmani',
                child: Text('Quran Uthmani'),
              ),
              PopupMenuItem<String>(
                value: 'en.asad',
                child: Text('English Asad'),
              ),
              PopupMenuItem<String>(
                value: 'id.indonesian',
                child: Text('Indonesian'),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: 30, // Hardcoded to 30 juz
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green[100],
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      'Juz ${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JuzDetailPage(
                            juzNumber: index + 1,
                            edition: selectedEdition,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
