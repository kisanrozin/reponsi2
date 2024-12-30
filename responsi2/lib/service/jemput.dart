import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> jemputSampah({
  required String nama,
  required String kategori,
  required String lokasi,
  required String tanggal,
  required String alamat,
  required String catatan,
  required int berat,
}) async {
  final url = Uri.parse("http://127.0.0.1:4040/api/jemputsampah");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "nama": nama,
        "kategori": kategori,
        "lokasi": lokasi,
        "tanggal": tanggal,
        "alamat": alamat,
        "catatan": catatan,
        "berat": berat,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      print("Permintaan jemput sampah berhasil: ${data['message']}");
    } else {
      final error = json.decode(response.body);
      throw Exception("Permintaan gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Gagal mengirim permintaan: $e");
  }
}
