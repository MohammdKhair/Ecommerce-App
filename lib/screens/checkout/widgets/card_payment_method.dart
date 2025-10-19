import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CardPaymentMethod extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function()? onTap;
  const CardPaymentMethod(
      {super.key, required this.title, required this.isActive, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColor.secondColor : AppColor.thirdColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: isActive ? Colors.white : AppColor.secondColor,
              height: 1,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
