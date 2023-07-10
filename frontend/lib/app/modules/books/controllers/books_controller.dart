import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../models/book.dart';
import '../../home/controllers/home_controller.dart';

class BooksController extends GetxController {
  HomeController homeController = Get.find();
  final dio = Dio();
  final searchController = TextEditingController();
  final allBooks = <Book>[].obs;
  final mysteryBooks = <Book>[].obs;
  final historyBooks = <Book>[].obs;
  final fictionBooks = <Book>[].obs;
  final wishlistBooks = <Book>[].obs;
  final purchasedBooks = <Book>[].obs;
  final selectedBook = Book().obs;
  Map<String, dynamic>? paymentIntent;
  final currectPdfPath = ''.obs;
  final isLoading = false.obs;
  final activeSearch = false.obs;
  final isSearching = false.obs;
  final addedToWishlist = false.obs;
  final isWishListLoading = false.obs;
  final isPurchaseLoading = false.obs;

  @override
  void onInit() async {
    await homeController.getUserDetails();
    await getAllBooks();
    await getBooksByCategory();
    super.onInit();
  }

  getAllBooks() async {
    isLoading.value = true;
    var books = await dio.get('https://book-store-app-kkpj.onrender.com/books');
    allBooks.value =
        books.data['books'].map<Book>((e) => Book.fromJson(e)).toList();
    isLoading.value = false;
  }

  getBooksByCategory() async {
    isLoading.value = true;
    var mystery = await dio
        .get('https://book-store-app-kkpj.onrender.com/books/category/Mystery');
    var history = await dio
        .get('https://book-store-app-kkpj.onrender.com/books/category/History');
    var fiction = await dio
        .get('https://book-store-app-kkpj.onrender.com/books/category/Fiction');
    mysteryBooks.value =
        mystery.data['books'].map<Book>((e) => Book.fromJson(e)).toList();
    historyBooks.value =
        history.data['books'].map<Book>((e) => Book.fromJson(e)).toList();
    fictionBooks.value =
        fiction.data['books'].map<Book>((e) => Book.fromJson(e)).toList();
    isLoading.value = false;
  }

  searchBooks({required String searchText}) async {
    isLoading.value = true;
    var books = await dio.get(
        'https://book-store-app-kkpj.onrender.com/books/search?title=$searchText');
    allBooks.value =
        books.data['books'].map<Book>((e) => Book.fromJson(e)).toList();
    isLoading.value = false;
  }

  addBookToWishList() async {
    try {
      var response = await dio.post(
          'https://book-store-app-kkpj.onrender.com/users/${homeController.userId}/wishlist/${selectedBook.value.uid}');
      print("add to wishlist response");
      print(response);
      addedToWishlist.value = true;
      await getWishListBooks();
    } catch (e) {
      rethrow;
    }
  }

  getWishListBooks() async {
    try {
      isWishListLoading.value = true;
      var books = await dio.get(
          'https://book-store-app-kkpj.onrender.com/users/${homeController.userId}/wishlist');
      wishlistBooks.value = books.data['wishlist']
          .map<Book>((e) => Book.fromJson(e['book']))
          .toList();
      isWishListLoading.value = false;
    } catch (e) {
      isWishListLoading.value = false;
      rethrow;
    }
  }

  addBookToPurchased() async {
    try {
      var response = await dio.post(
          'https://book-store-app-kkpj.onrender.com/users/${homeController.userId}/purchasedBooks/${selectedBook.value.uid}');
      print("add to wishlist response");
      print(response);
      await getPurchasedBooks();
    } catch (e) {
      rethrow;
    }
  }

  getPurchasedBooks() async {
    try {
      isPurchaseLoading.value = true;
      var books = await dio.get(
          'https://book-store-app-kkpj.onrender.com/users/${homeController.userId}/purchasedBooks');
      purchasedBooks.value = books.data['purchasedBooks']
          .map<Book>((e) => Book.fromJson(e['book']))
          .toList();
      isPurchaseLoading.value = false;
    } catch (e) {
      isPurchaseLoading.value = false;
      rethrow;
    }
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      const url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(selectedBook.value.price!.toInt().toString(), 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async{
        showDialog(
            context: Get.context!,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));
        await  addBookToPurchased();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  clearSelectedBook() {
    selectedBook.value = Book();
    addedToWishlist.value = false;
  }
}
