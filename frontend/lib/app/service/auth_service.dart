import 'package:book_store_app/app/modules/books/controllers/books_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/home/controllers/home_controller.dart';
import '../routes/app_pages.dart';

class AuthService extends GetxService {
  late SharedPreferences prefs;
  static const String apiUrl = 'https://book-store-app-kkpj.onrender.com';
  final Dio dio = Dio();
  var _isAuthenticated = false;

  @override
  void onInit() async {
    print("AuthService started");
    await checkAuthStatus();
    await setAuthenticated();
    super.onInit();
  }

  bool get isAuthenticated => _isAuthenticated;

  setAuthenticated() async {
    prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool("isLoggedIn") ?? false;
    if (isAuthenticated == true) {
      Get.rootDelegate.offNamed(AppPages.HOME);
    }
  }

  checkAuthStatus() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token=='' ||JwtDecoder.isExpired(token!)) {
      logout();
      await setAuthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$apiUrl/users/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        final token = response.data['token'];
        prefs.setString("token", token);
        Get.rootDelegate.offNamed(AppPages.HOME);
        prefs.setBool("isLoggedIn", true);
      }
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
      };

      final response = await dio.post(
        '$apiUrl/users/register',
        data: Uri(queryParameters: data).query,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 201) {
        final token = response.data['token'];
        prefs.setString("token", token);
        Get.rootDelegate.offNamed(AppPages.HOME);
        prefs.setBool("isLoggedIn", true);
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Signup failed');
    }
  }

  logout() {
    prefs.setString("token", "");
    prefs.setBool("isLoggedIn", false);
    Get.rootDelegate.offNamed(AppPages.AUTH);
  }
}
