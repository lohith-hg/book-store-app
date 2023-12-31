import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../books/views/components/book_detail_screen.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wishlist',
            style: TextStyle(color: secondaryColor),
          ),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          backgroundColor: primaryColor,
        ),
        body: (controller.booksController.isWishListLoading.value)
            ? const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      controller.booksController.wishlistBooks.length,
                      (index) {
                        return Container(
                          width: Get.width - 32,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: primaryColor,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 8, bottom: 8, right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    controller.booksController
                                        .wishlistBooks[index].coverImageUrl!,
                                    width: 120,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width: 210,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, top: 8, bottom: 8),
                                        child: Text(
                                          controller.booksController
                                              .wishlistBooks[index].title!,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          controller
                                              .booksController
                                              .wishlistBooks[index]
                                              .description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Category : ${controller.booksController.wishlistBooks[index].category!}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Price : ₹${controller.booksController.wishlistBooks[index].price!}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      CustomButton(
                                        name: "Buy",
                                        onTap: () {
                                          controller.booksController
                                                  .selectedBook.value =
                                              controller.booksController
                                                  .wishlistBooks[index];
                                          Get.to(const BookDetailScreen());
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
