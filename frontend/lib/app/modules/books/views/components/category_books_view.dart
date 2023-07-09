import 'package:book_store_app/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/books_controller.dart';

class CategoryBooksView extends GetView<BooksController> {
  const CategoryBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width - 80,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: primaryColor),
        child: Row(
          children: [
            ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.list),
              trailing: const Text(
                "GFG",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              title: Text("List item $index"),
            );
          },
        ),
          ],
        )
       
        );
  }
}
