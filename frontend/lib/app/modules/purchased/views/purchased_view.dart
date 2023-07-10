import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../books/views/components/book_detail_screen.dart';
import '../../books/views/components/book_viewer.dart';
import '../controllers/purchased_controller.dart';

class PurchasedView extends GetView<PurchasedController> {
  const PurchasedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Purchased',
            style: TextStyle(color: secondaryColor),
          ),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          backgroundColor: primaryColor,
        ),
        body: (controller.booksController.isPurchaseLoading.value)
            ? const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      controller.booksController.purchasedBooks.length,
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
                                        .purchasedBooks[index].coverImageUrl!,
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
                                              .purchasedBooks[index].title!,
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
                                              .purchasedBooks[index]
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
                                          "Category : ${controller.booksController.purchasedBooks[index].category!}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Price : ₹${controller.booksController.purchasedBooks[index].price!}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      CustomButton(
                                        name: "View",
                                        onTap: () async {
                                          await controller.booksController
                                              .createFileOfPdfUrl()
                                              .then((f) {
                                            controller.booksController
                                                .currectPdfPath.value = f.path;
                                          });
                                          Get.to(PDFScreen(
                                              path: controller.booksController
                                                  .currectPdfPath.value));
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
