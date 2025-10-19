import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final void Function() onPressed;
  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        color: AppColor.secondColor,
        child: const Text(
          "go To Cart",
          style: TextStyle(color: AppColor.wihte, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
