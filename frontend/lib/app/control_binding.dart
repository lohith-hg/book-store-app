import 'package:book_store_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:book_store_app/app/modules/books/controllers/books_controller.dart';
import 'package:book_store_app/app/modules/home/controllers/home_controller.dart';
import 'package:book_store_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:book_store_app/app/modules/purchased/controllers/purchased_controller.dart';
import 'package:book_store_app/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:book_store_app/app/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(BooksController());
    Get.put(WishlistController());
     Get.put(PurchasedController());
  }
}
