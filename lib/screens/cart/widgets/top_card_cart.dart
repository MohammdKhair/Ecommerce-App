import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class TopCardCart extends StatelessWidget {
  final String title;
  const TopCardCart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: AppColor.thirdColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColor.primaryColor),
      ),
    );
  }
}
