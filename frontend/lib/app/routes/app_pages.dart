import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/books/bindings/books_binding.dart';
import '../modules/books/views/books_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/purchased/bindings/purchased_binding.dart';
import '../modules/purchased/views/purchased_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';
import '../service/auth_service.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const HOME = Routes.HOME;
  static const AUTH = Routes.AUTH;

  static final routes = [
    GetPage(
      participatesInRootNavigator: true,
      name: '/',
      page: () => GetRouterOutlet.builder(
        builder: (BuildContext context, GetDelegate delegate,
            GetNavConfig? current) {
          return GetRouterOutlet(
            initialRoute: _Paths.AUTH,
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
          page: () => ProfileView(),
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
        GetPage(
          name: _Paths.BOOKS,
          page: () => const BooksView(),
          binding: BooksBinding(),
        ),
        GetPage(
          name: _Paths.AUTH,
          page: () => AuthView(),
          binding: AuthBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PURCHASED,
      page: () => const PurchasedView(),
      binding: PurchasedBinding(),
    ),
  ];
}
