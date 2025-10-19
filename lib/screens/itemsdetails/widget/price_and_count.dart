import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class PriceAndCount extends StatelessWidget {
  final void Function() onAdd;
  final void Function() onRemove;
  final String? count;
  final String? price;
  const PriceAndCount(
      {super.key,
      required this.onAdd,
      required this.onRemove,
      this.count,
      this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
            const SizedBox(width: 7),
            Text(
              count!,
              style: const TextStyle(fontSize: 25, fontFamily: "sans"),
            ),
            const SizedBox(width: 7),
            IconButton(onPressed: onRemove, icon: const Icon(Icons.remove))
          ],
        ),
        const Spacer(),
        Text(
          price!,
          style: const TextStyle(
              color: AppColor.primaryColor, fontSize: 30, fontFamily: "sans"),
        ),
      ],
    );
  }
}
