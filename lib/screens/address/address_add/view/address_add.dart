// ignore_for_file: avoid_print

import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/screens/address/address_add/controller/address_add_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class AddressAdd extends StatelessWidget {
  const AddressAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressAddControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("add address"),
      ),
      body: GetBuilder<AddressAddControllerImp>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(height: 20),
                  Text('جاري تحديد موقعك الحالي...'),
                ],
              ),
            );
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off, size: 50, color: Colors.red),
                  const SizedBox(height: 20),
                  Text(
                    controller.errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.retryGetLocation,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: controller.mapCenter,
                    initialZoom: controller.zoomLevel,
                    minZoom: 4,
                    maxZoom: 18,
                    onTap: (tapPosition, point) {
                      controller.addMarker(point);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.yourapp.yourappname',
                    ),
                    MarkerLayer(
                      markers: [
                        if (controller.currentLocation != null)
                          Marker(
                            point: controller.currentLocation!,
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ...controller.markers,
                      ],
                    ),
                  ],
                ),
              ),
              if (controller.markers.isNotEmpty)
                Positioned(
                    bottom: 10,
                    child: MaterialButton(
                      minWidth: 200,
                      color: AppColor.primaryColor,
                      onPressed: () {
                        controller.goToAddressDetales();
                      },
                      child: const Text(
                        "continue",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
            ],
          );
        },
      ),
    );
  }
}
