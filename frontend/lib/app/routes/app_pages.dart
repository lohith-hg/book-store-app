import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../modules/books/bindings/books_binding.dart';
import '../modules/books/views/books_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      participatesInRootNavigator: true,
      name: '/',
      page: () => GetRouterOutlet.builder(
        builder: (BuildContext context, GetDelegate delegate,
            GetNavConfig? current) {
          return GetRouterOutlet(
            initialRoute: _Paths.HOME,
            // initialRoute: FirebaseAuth.instance.currentUser != null
            //     ? _Paths.HOME
            //     : _Paths.AUTH,
          );
        },
      ),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: _Paths.PROFILE,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.WISHLIST,
          page: () => const WishlistView(),
          binding: WishlistBinding(),
        ),
        GetPage(
          name: _Paths.CATEGORIES,
          page: () => const CategoriesView(),
          binding: CategoriesBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.BOOKS,
      page: () => const BooksView(),
      binding: BooksBinding(),
    ),
  ];
}
