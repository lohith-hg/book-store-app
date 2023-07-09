import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/auth_service.dart';

class HomeController extends GetxController {
  AuthService authService = Get.find();
  late SharedPreferences prefs;
  final userName = ''.obs;
  final userEmail = ''.obs;

  final count = 0.obs;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    userEmail.value = decodedToken['email'];
    userName.value = decodedToken['name'];
    print(userEmail.value);
    print(userName.value);
    super.onInit();
  }
}
