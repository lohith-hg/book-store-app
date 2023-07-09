import 'package:book_store_app/app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function()? onTap;
  String? name;
  double? width;
  CustomButton(
      {super.key, required this.onTap, required this.name, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: Container(
          height: 40,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: secondaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                name!,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
