import 'package:flutter/material.dart';
import 'package:quran_app/api/api.dart';

class JuzDetailPage extends StatefulWidget {
  final int juzNumber;

  const JuzDetailPage({
    Key? key,
    required this.juzNumber,
    required String edition,
  }) : super(key: key);

  @override
  _JuzDetailPageState createState() => _JuzDetailPageState();
}

class _JuzDetailPageState extends State<JuzDetailPage> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? juzDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchJuzDetail();
  }

  Future<void> _fetchJuzDetail() async {
    try {
      final data =
          await _apiService.fetchJuzDetail(widget.juzNumber, 'quran-uthmani');
      setState(() {
        juzDetail = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat detail juz: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${widget.juzNumber}'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : juzDetail != null
              ? ListView.builder(
                  itemCount: juzDetail!['ayahs'].length,
                  itemBuilder: (context, index) {
                    var ayat = juzDetail!['ayahs'][index];
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
                            'Surat ${ayat['surah']['name']} - Ayat ${ayat['number']}',
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
