import 'package:flutter/material.dart';
import 'package:quran_app/api/api.dart';
import 'detail_surat.dart';

class SuratListPage extends StatefulWidget {
  @override
  _SuratListPageState createState() => _SuratListPageState();
}

class _SuratListPageState extends State<SuratListPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> suratList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSuratList();
  }

  Future<void> _fetchSuratList() async {
    try {
      final data = await _apiService.fetchSurah();
      setState(() {
        suratList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data surat: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Surat'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: suratList.length,
              itemBuilder: (context, index) {
                var surat = suratList[index];
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
                        surat['number'].toString(),
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      surat['englishName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${surat['name']} - ${surat['numberOfAyahs']} ayat',
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuratDetailPage(
                            suratNumber: surat['number'],
                            suratName: surat['englishName'],
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
