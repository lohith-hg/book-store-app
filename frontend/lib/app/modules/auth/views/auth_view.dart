import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/auth_richtext.dart';
import '../../../widgets/text_field.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSignUp = controller.isSignUpScreen.value;
      return Scaffold(
        backgroundColor: tertiaryColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            (isSignUp) ? "Create Account" : "Log In",
            style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.titilliumWeb().fontFamily),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          color: tertiaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: (isSignUp)
                            ? controller.signUpFormKey
                            : controller.loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (isSignUp) ? "Sign Up" : "Log In",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            if (isSignUp)
                              formField(
                                title: 'Name',
                                hintText: "Enter name",
                                controller: controller.nameEditingController,
                                validator: (value) {
                                  if (value.toString().trim().isEmpty) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                              ),
                            const SizedBox(
                              height: 12,
                            ),
                            formField(
                              title: 'Email',
                              hintText: "Enter email",
                              controller: controller.emailEditingController,
                              validator: (value) {
                                bool emailValid = false;
                                if (value != null) {
                                  emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value);
                                }
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!emailValid) {
                                  return 'Please enter valid email';
                                } else if (controller.emailErrorText.value !=
                                    '') {
                                  return controller.emailErrorText.value;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            InputText(
                              w: Get.width,
                              label: "Enter password",
                              hintText: "Enter password",
                              fillColor: tertiaryColor,
                              textColor: Colors.black,
                              controller: controller.passwordEditingController,
                              ontapPasswordView: () {
                                controller.showPassword.value =
                                    !controller.showPassword.value;
                              },
                              isIcon: true,
                              obscureText: !controller.showPassword.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (controller.passwordErrorText.value !=
                                    '') {
                                  return controller.passwordErrorText.value;
                                }
                                return null;
                              },
                              textInputType: TextInputType.visiblePassword,
                            ),
                            if (!isSignUp)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                    onPressed: () async {
                                      bool emailValid = false;
                                      if (controller.emailEditingController.text
                                          .trim()
                                          .isNotEmpty) {
                                        emailValid = RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(controller
                                                .emailEditingController.text
                                                .trim());
                                      }
                                      if (emailValid) {
                                        // await controller.authService
                                        //     .resetPassword(
                                        //         email: controller
                                        //             .emailEditingController
                                        //             .text);
                                      } else {
                                        Utils().showSnackBar(
                                            "Please enter valid email");
                                      }
                                    },
                                    child: Text(
                                      "Forgot password?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: GoogleFonts.titilliumWeb()
                                              .fontFamily),
                                    )),
                              ),
                            if (isSignUp)
                              const SizedBox(
                                height: 18,
                              ),
                            InkWell(
                              onTap: () async {
                                controller.emailErrorText.value = '';
                                controller.passwordErrorText.value = '';
                                if (!isSignUp) {
                                  if (controller.loginFormKey.currentState!
                                      .validate()) {
                                    await controller.signInWithEmailAndPassword(
                                      email: controller
                                          .emailEditingController.text
                                          .trim(),
                                      password: controller
                                          .passwordEditingController.text
                                          .trim(),
                                    );
                                  }
                                } else {
                                  if (controller.signUpFormKey.currentState!
                                      .validate()) {
                                    await controller
                                        .createUserWithEmailAndPassword(
                                      email: controller
                                          .emailEditingController.text
                                          .trim(),
                                      password: controller
                                          .passwordEditingController.text
                                          .trim(),
                                      name: controller
                                          .nameEditingController.text
                                          .trim(),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: (controller.isLoading.value)
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          (isSignUp) ? "Sign Up" : "Log In",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 16),
                              child: Row(
                                children: const <Widget>[
                                  Expanded(
                                      child: Divider(
                                    color: Colors.black,
                                    thickness: 1.4,
                                  )),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 9),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 22, bottom: 2),
                              child: AuthRichText(
                                normalText: (isSignUp)
                                    ? 'I already have an account '
                                    : 'I don\'t have an account ',
                                richText: (!isSignUp) ? "Sign Up" : "Log In",
                                ontap: () {
                                  controller.clearControllers();
                                  controller.isSignUpScreen.value =
                                      !controller.isSignUpScreen.value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  formField(
      {required String title,
      required String hintText,
      required TextEditingController controller,
      required dynamic validator,
      TextInputType textInputType = TextInputType.emailAddress}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputText(
          w: Get.width,
          controller: controller,
          label: title,
          hintText: hintText,
          validator: validator,
          textInputType: textInputType,
          fillColor: tertiaryColor,
          textColor: Colors.black,
        ),
      ],
    );
  }
}
