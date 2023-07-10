import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../service/auth_service.dart';

class AuthController extends GetxController {
  AuthService authService = Get.find();
  final isLoggedin = false.obs;
  final isLoading = false.obs;

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final accountFormKey = GlobalKey<FormState>();
  final isLogInScreen = false.obs;

  var isSignUpScreen = true.obs;
  final showPassword = false.obs;
  final signUpFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final emailErrorText = ''.obs;
  final passwordErrorText = ''.obs;

  @override
  void onInit() {
    isSignUpScreen.value = true;
    super.onInit();
  }

  createUserWithEmailAndPassword(
      {required String email, required String password,required String name}) async {
    try {
      isLoading.value = true;
      await authService.signup(name,email, password);
       isLoading.value = false;
    } catch (e) {
      emailErrorText.value = e.toString();
      signUpFormKey.currentState!.validate();
    }
  }

  signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      isLoading.value = true;
       await authService.login(email, password);
        isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      loginFormKey.currentState!.validate();
    }
  }

  clearControllers() {
    nameEditingController.clear();
    emailEditingController.clear();
    passwordEditingController.clear();
    showPassword.value = false;
    emailErrorText.value = '';
    passwordErrorText.value = '';
  }
}
