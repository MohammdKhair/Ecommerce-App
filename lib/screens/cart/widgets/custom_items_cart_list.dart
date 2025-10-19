import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/constant/app_links.dart';
import 'package:flutter/material.dart';

class CustomItemsCartList extends StatelessWidget {
  final String name;
  final String price;
  final String count;
  final String image;
  final void Function() onAdd;
  final void Function() onRemove;
  const CustomItemsCartList(
      {super.key,
      required this.name,
      required this.price,
      required this.count,
      required this.image,
      required this.onAdd,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            // const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: "${AppLinks.imageItems}/$image",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 4,
                child: ListTile(
                  title: Text(name, style: const TextStyle(fontSize: 17)),
                  subtitle: Text("$price \$",
                      style: const TextStyle(
                          color: AppColor.primaryColor, fontSize: 17)),
                )),
            Expanded(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: IconButton(
                      padding: const EdgeInsets.only(bottom: 0),
                      onPressed: onAdd,
                      icon: const Icon(Icons.add)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    count,
                    style: const TextStyle(fontFamily: "sans"),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: IconButton(
                      padding: const EdgeInsets.only(bottom: 0),
                      onPressed: onRemove,
                      icon: const Icon(Icons.remove)),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
