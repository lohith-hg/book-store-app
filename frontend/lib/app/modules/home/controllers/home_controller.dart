import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/auth_service.dart';
import '../../books/controllers/books_controller.dart';

class HomeController extends GetxController {
  AuthService authService = Get.find();
  BooksController booksController = Get.find();
  late SharedPreferences prefs;
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userId = ''.obs;

  final count = 0.obs;
  @override
  void onInit() async {
    await getUserDetails();
    super.onInit();
  }

  getUserDetails() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    print(decodedToken);
    userEmail.value = decodedToken['userId']['email'];
    userName.value = decodedToken['userId']['name'];
    userId.value=decodedToken['userId']['_id'];
  }
}
