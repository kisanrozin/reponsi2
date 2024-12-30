import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> login(String email, String password) async {
  final url = Uri.parse("http://127.0.0.1:4040/api/auth/login");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Login berhasil: ${data['message']}");
      // Simpan token jika diperlukan
    } else {
      final error = json.decode(response.body);
      throw Exception("Login gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    throw Exception("Login gagal: $e");
  }
}

Future<void> register(String name, String email, String password, String confirmPassword) async {
  final url = Uri.parse("http://127.0.0.1:4040/api/auth/register");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword, // Ubah nama field
      }),
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 201) {
      print("Registrasi berhasil.");
    } else {
      final error = json.decode(response.body);
      throw Exception("Registrasi gagal: ${error['message'] ?? 'Kesalahan server'}");
    }
  } catch (e) {
    print("Error during registration: $e");
    throw Exception("Registrasi gagal: $e");
  }
}
