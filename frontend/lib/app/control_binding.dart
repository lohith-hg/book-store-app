import 'package:book_store_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:book_store_app/app/modules/books/controllers/books_controller.dart';
import 'package:book_store_app/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:book_store_app/app/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(AuthController());
    Get.put(BooksController());
    Get.put(WishlistController());
  }
}
