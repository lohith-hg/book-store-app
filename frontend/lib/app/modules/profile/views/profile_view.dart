import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import '../../../widgets/text_field.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(color: secondaryColor),
          ),
          centerTitle: true,
          elevation:0,
          scrolledUnderElevation: 0.0,
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 18),
                    child: CircleAvatar(
                      backgroundColor: secondaryColor,
                      radius: 50,
                      child: Transform.scale(
                        scale: 3,
                        child: Text(
                          (controller.homeController.userName.value.isNotEmpty)?
                          controller.homeController.userName.value
                              .toString()
                              .substring(0, 1)
                              .toUpperCase():"U",
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    controller.homeController.userEmail.value,
                    style: testStyle().copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await controller.authService.logout();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: secondaryColor,
                    ),
                    label: Text(
                      "Sign Out",
                      style: TextStyle(
                        fontFamily: GoogleFonts.titilliumWeb().fontFamily,
                        color: secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  TextStyle testStyle() {
    return TextStyle(
      fontFamily: GoogleFonts.titilliumWeb().fontFamily,
      color: secondaryColor,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );
  }
}
