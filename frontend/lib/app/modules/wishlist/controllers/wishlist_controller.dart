import 'package:book_store_app/app/modules/books/controllers/books_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../models/book.dart';
import '../../home/controllers/home_controller.dart';

class WishlistController extends GetxController {
  HomeController homeController = Get.find();
  BooksController booksController = Get.find();
  final dio = Dio();

  @override
  void onInit() async {
    await homeController.getUserDetails();
    await booksController.getWishListBooks();
    super.onInit();
  }
}
