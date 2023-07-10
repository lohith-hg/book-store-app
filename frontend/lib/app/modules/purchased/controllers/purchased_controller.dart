import 'package:get/get.dart';

import '../../books/controllers/books_controller.dart';
import '../../home/controllers/home_controller.dart';

class PurchasedController extends GetxController {
  HomeController homeController = Get.find();
  BooksController booksController = Get.find();

  @override
  void onInit() async {
    await homeController.getUserDetails();
    await booksController.getPurchasedBooks();
    super.onInit();
  }
}
