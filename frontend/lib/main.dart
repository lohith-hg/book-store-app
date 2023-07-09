import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/constants/colors.dart';
import 'app/control_binding.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    const BookStoreApp(),
  );
}

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.titilliumWeb().fontFamily,
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: GoogleFonts.titilliumWeb().fontFamily,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
        title: "BookStoreApp",
        routerDelegate: GetDelegate(
          backButtonPopMode: PopMode.Page,
          preventDuplicateHandlingMode:
              PreventDuplicateHandlingMode.PopUntilOriginalRoute,
        ),
        popGesture: Get.isPopGestureEnable,
        //initialRoute: AppPages.HOME,
        getPages: AppPages.routes,
        initialBinding: ControlBinding()
        );
  }
}
