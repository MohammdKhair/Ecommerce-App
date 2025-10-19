import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class CardShippingAddress extends StatelessWidget {
  final String title;
  final String body1;
  final String body2;
  final bool isActive;
  final void Function()? onTap;
  const CardShippingAddress({
    super.key,
    required this.title,
    required this.body1,
    required this.isActive,
    this.onTap,
    required this.body2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isActive ? AppColor.secondColor : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                color: isActive ? Colors.white : AppColor.secondColor,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(body1,
                  style: TextStyle(
                      color: isActive ? Colors.white : AppColor.secondColor,
                      fontWeight: FontWeight.bold)),
              Text(body2,
                  style: TextStyle(
                      color: isActive ? Colors.white : AppColor.secondColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
