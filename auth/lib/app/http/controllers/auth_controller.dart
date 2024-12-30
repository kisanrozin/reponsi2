import 'dart:io';
import 'package:auth/app/models/user.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    try {
      print("Register request received");

      // Validasi input
      request.validate({
        'name': 'required',
        'email': 'required|email',
        'password': 'required|min_length:6|confirmed',
      }, {
        'name.required': 'nama tidak boleh kosong',
        'email.required': 'email tidak boleh kosong',
        'email.email': 'email tidak valid',
        'password.required': 'password tidak boleh kosong',
        'password.min_length': 'password harus terdiri dari minimal 6 karakter',
        'password.confirmed': 'konfirmasi password tidak sesuai',
      });

      // Mendapatkan input dari request
      final name = request.input('name');
      final email = request.input('email');
      var password = request.input('password');
      print("Input received: name=$name, email=$email");

      // Periksa apakah user sudah ada
      var user = await User().query().where('email', '=', email).first();
      if (user != null) {
        return Response.json({
          "message": "user sudah ada",
        }, 409);
      }

      // Hash password dan simpan user baru
      password = Hash().make(password);
      await User().query().insert({
        "name": name,
        "email": email,
        "password": password,
        "created_at": DateTime.now().toIso8601String(),
      });

      return Response.json({"message": "berhasil mendaftarkan user"}, 201);
    } catch (e) {
      print("Error in register: $e");
      return Response.json({"message": "Kesalahan server: $e"}, 500);
    }
  }

  Future<Response> login(Request request) async {
    // Validasi input
    request.validate({
      'email': 'required|email',
      'password': 'required|min_length:6',
    }, {
      'email.required': 'email tidak boleh kosong',
      'email.email': 'email tidak valid',
      'password.required': 'password tidak boleh kosong',
    });

    // Mendapatkan input dari request
    final email = request.input('email');
    var password = request.input('password').toString();

    // Periksa apakah user terdaftar
    var user = await User().query().where('email', '=', email).first();
    if (user == null) {
      return Response.json({
        "message": "user belum terdaftar",
      }, HttpStatus.unauthorized);
    }

    // Verifikasi password
    if (!Hash().verify(password, user['password'])) {
      return Response.json({
        "message": "kata sandi yang anda masukan salah",
      }, 401);
    }

    // Buat token untuk user
    final token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(days: 30), withRefreshToken: true);

    return Response.json({
      "message": "berhasil login",
      "token": token,
    });
  }
}

final AuthController authController = AuthController();
