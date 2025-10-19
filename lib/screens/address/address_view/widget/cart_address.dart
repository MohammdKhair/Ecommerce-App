import 'package:ecommerce_app/data/model/address_model.dart';
import 'package:flutter/material.dart';

class CartAddress extends StatelessWidget {
  final AddressModel addressModel;
  final void Function() onDelete;
  const CartAddress(
      {super.key, required this.addressModel, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(addressModel.addressName!),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(addressModel.addressStreet!),
              Text(addressModel.addressCity!),
            ],
          ),
          trailing: IconButton(
              onPressed: onDelete, icon: const Icon(Icons.delete_outline)),
        ),
      ),
    );
  }
}
