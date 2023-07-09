import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/books_controller.dart';
import 'components/book_detail_screen.dart';
import 'components/book_viewer.dart';

class BooksView extends GetView<BooksController> {
  const BooksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: tertiaryColor.withOpacity(0.3),
        appBar: AppBar(
          backgroundColor: tertiaryColor.withOpacity(0.3),
          title: const Text(
            'All Books',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: (controller.isLoading.value)
            ? const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, top: 22),
                          child: Text(
                            "Newly Added",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: Get.width,
                          height: Get.height / 1.9,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              disableCenter: false,
                              autoPlay: true,
                              viewportFraction: 0.6,
                              aspectRatio: 98 / 152,
                              enlargeCenterPage: true,
                            ),
                            items: [
                              ...List.generate(
                                controller.allBooks.length,
                                (index) {
                                  return InkWell(
                                    onTap: () async {
                                      controller.selectedBook.value =
                                          controller.allBooks[index];
                                      await controller
                                          .createFileOfPdfUrl()
                                          .then((f) {
                                        controller.currectPdfPath.value =
                                            f.path;
                                      });
                                      Get.to(PDFScreen(
                                          path:
                                              controller.currectPdfPath.value));
                                    },
                                    child: SizedBox(
                                      height: Get.height / 3.2,
                                      width: Get.width - 60,
                                      child: Image.network(
                                        controller
                                            .allBooks[index].coverImageUrl!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16, top: 22, bottom: 12),
                      child: Text(
                        "All Books",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    ...List.generate(
                      controller.allBooks.length,
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
                                    controller.allBooks[index].coverImageUrl!,
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
                                          controller.allBooks[index].title!,
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
                                              .allBooks[index].description!,
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
                                          "Category : ${controller.allBooks[index].category!}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          "Price : ₹${controller.allBooks[index].price!}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      CustomButton(
                                        name: "Buy",
                                        onTap: () {
                                          controller.selectedBook.value =
                                              controller.allBooks[index];
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
