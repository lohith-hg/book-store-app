import 'package:book_store_app/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/books_controller.dart';

class Search extends GetView<BooksController> {
  final String hintText;
  final TextEditingController textEditingController;
  final void Function() onTap;
  final void Function() onCancel;
  final bool isActive;
  final bool? isCancel;

  const Search({
    Key? key,
    required this.w,
    required this.hintText,
    required this.onCancel,
    required this.textEditingController,
    required this.onTap,
    required this.isActive,
    this.isCancel,
  }) : super(key: key);

  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: tertiaryColor),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              onEditingComplete: onTap,
              scrollPadding: EdgeInsets.zero,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 12, left: 16),
                alignLabelWithHint: false,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          if (isCancel ?? false)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: onCancel,
                child: const Icon(
                  Icons.close,
                  size: 24,
                  color: secondaryColor,
                ),
              ),
            ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 65,
              height: 45,
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  isActive ? Icons.close : Icons.search,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
