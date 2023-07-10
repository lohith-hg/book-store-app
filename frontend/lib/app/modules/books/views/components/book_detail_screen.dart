import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../controllers/books_controller.dart';
import 'book_viewer.dart';

class BookDetailScreen extends GetView<BooksController> {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: tertiaryColor.withOpacity(0.3),
          leading: IconButton(
            onPressed: () {
              Get.back();
              controller.clearSelectedBook();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            controller.selectedBook.value.title!,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: Get.height / 1.7,
                  width: Get.width - 60,
                  child: Image.network(
                    controller.selectedBook.value.coverImageUrl!,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 4, top: 8, bottom: 8),
                      child: Text(
                        controller.selectedBook.value.title!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        controller.selectedBook.value.description!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Category : ${controller.selectedBook.value.category!}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Price : ₹${controller.selectedBook.value.price!}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await controller.addBookToWishList();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: Container(
                          height: 50,
                          width: Get.width - 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: secondaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    (controller.addedToWishlist.value)
                                        ? "Added"
                                        : "Add to wishlist",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      name: "Buy",
                      width: Get.width - 16,
                      onTap: () async{
                        controller.selectedBook.value =
                            controller.selectedBook.value;
                        await controller.makePayment();
                      },
                    ),
                    CustomButton(
                      name: "View free Sample",
                      width: Get.width - 16,
                      onTap: () async {
                        await controller.createFileOfPdfUrl().then((f) {
                          controller.currectPdfPath.value = f.path;
                        });
                        Get.to(
                            PDFScreen(path: controller.currectPdfPath.value));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
