import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';

class AuthService extends g.GetxService {
  late SharedPreferences prefs;
  static const String apiUrl = 'https://book-store-app-kkpj.onrender.com';
  final Dio dio = Dio();
  var _isAuthenticated = false;

  @override
  void onInit() {
    setAuthenticated();
    super.onInit();
  }

  bool get isAuthenticated => _isAuthenticated;

  void setAuthenticated() async {
    prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool("isLoggedIn") ?? false;
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
        print(token);
        prefs.setString("token", token);
        g.Get.rootDelegate.offNamed(AppPages.HOME);
        prefs.setBool("isLoggedIn", true);
      }
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      print("Step 1");

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
      print("Step 2");
      prefs = await SharedPreferences.getInstance();
      print("Step 3");
      if (response.statusCode == 201) {
        final token = response.data['token'];
        print(token);
        prefs.setString("token", token);
        g.Get.rootDelegate.offNamed(AppPages.HOME);
        prefs.setBool("isLoggedIn", true);
      }
      print("Step 4");
    } catch (e) {
      print(e.toString());
      throw Exception('Signup failed');
    }
  }
}
