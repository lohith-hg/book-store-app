import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../models/book.dart';

class BooksController extends GetxController {
  final dio = Dio();
  final allBooks = <Book>[].obs;
  final mysteryBooks = <Book>[].obs;
  final historyBooks = <Book>[].obs;
  final fictionBooks = <Book>[].obs;
  final selectedBook = Book().obs;
  final currectPdfPath = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
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
}
