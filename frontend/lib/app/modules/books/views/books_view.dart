import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../controllers/books_controller.dart';
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
              'BooksView',
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
                      SizedBox(
                        width: Get.width,
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
                                    await controller
                                        .createFileOfPdfUrl()
                                        .then((f) {
                                      controller.currectPdfPath.value = f.path;
                                    });
                                    Get.to(PDFScreen(path: controller.currectPdfPath.value));
                                  },
                                  child: SizedBox(
                                    height: Get.height / 3.2,
                                    width: Get.width - 60,
                                    child: Image.network(
                                      controller.allBooks[index].coverImageUrl!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      ...List.generate(controller.allBooks.length, (index) {
                        return Column(
                          children: [
                            if (controller.allBooks[index].coverImageUrl !=
                                null)
                              SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(controller
                                      .allBooks[index].coverImageUrl!)),
                            Container(
                              child: Text(
                                controller.allBooks[index].title!,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ));
    });
  }
}
