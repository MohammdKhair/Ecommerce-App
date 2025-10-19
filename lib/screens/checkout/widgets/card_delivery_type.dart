import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CardDeliveryType extends StatelessWidget {
  final String image;
  final String title;
  final bool isAcvtive;
  final void Function()? onTap;
  const CardDeliveryType(
      {super.key,
      required this.image,
      required this.title,
      required this.isAcvtive, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: isAcvtive ? AppColor.secondColor : null,
          border: Border.all(color: AppColor.secondColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 60,
              color: isAcvtive ? Colors.white : null,
            ),
            Text(
              title,
              style: TextStyle(
                  color: isAcvtive ? Colors.white : AppColor.secondColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
