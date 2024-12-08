import 'package:flutter/material.dart';
import 'package:quran_app/api/api.dart';

class SuratDetailPage extends StatefulWidget {
  final int suratNumber;
  final String suratName;

  const SuratDetailPage({
    Key? key,
    required this.suratNumber,
    required this.suratName,
  }) : super(key: key);

  @override
  _SuratDetailPageState createState() => _SuratDetailPageState();
}

class _SuratDetailPageState extends State<SuratDetailPage> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? suratDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSuratDetail();
  }

  Future<void> _fetchSuratDetail() async {
    try {
      final data = await _apiService.fetchSurahDetail(widget.suratNumber);
      setState(() {
        suratDetail = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat detail surat: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.suratName),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : suratDetail != null
              ? ListView.builder(
                  itemCount: suratDetail!['ayahs'].length,
                  itemBuilder: (context, index) {
                    var ayat = suratDetail!['ayahs'][index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ayat['text'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Ayat ${ayat['number']}',
                            style: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(child: Text('Tidak ada data')),
    );
  }
}
