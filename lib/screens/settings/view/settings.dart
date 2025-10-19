import 'package:ecommerce_app/core/constant/app_color.dart';
import 'package:ecommerce_app/core/constant/app_image.dart';
import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/screens/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsControllerImp settingsControllerImp =
        Get.put(SettingsControllerImp());
    return ListView(children: [
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(height: Get.width / 2.5, color: AppColor.primaryColor),
          Positioned(
              top: Get.width / 3.5,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: const AssetImage(AppImage.avatar),
                ),
              ))
        ],
      ),
      const SizedBox(height: 100),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ListTile(
              //   title: const Text("Disable Notifications"),
              //   trailing:
              //       GetBuilder<SettingsControllerImp>(builder: (controller) {
              //     return Switch(
              //         activeTrackColor: AppColor.primaryColor,
              //         value: settingsControllerImp.notify,
              //         onChanged: (val) {
              //           settingsControllerImp.switchnotify(val);
              //         });
              //   }),
              // ),
              ListTile(
                title: const Text("Ordres"),
                trailing: const Icon(Icons.card_travel, size: 35),
                onTap: () {
                  Get.toNamed(AppRoute.ordersPending);
                },
              ),
              ListTile(
                title: const Text("Archive"),
                trailing: const Icon(Icons.card_travel_rounded, size: 35),
                onTap: () {
                  Get.toNamed(AppRoute.ordersArchive);
                },
              ),
              ListTile(
                title: const Text("Address"),
                trailing: const Icon(Icons.location_on_outlined, size: 35),
                onTap: () {
                  Get.toNamed(AppRoute.addressView);
                },
              ),
              ListTile(
                title: const Text("About us"),
                trailing: const Icon(Icons.help_outline_outlined, size: 35),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Contact us"),
                trailing: const Icon(Icons.phone, size: 35),
                onTap: () {
                  settingsControllerImp.contactUs();
                },
              ),
              ListTile(
                title: const Text("Logout"),
                trailing: const Icon(Icons.exit_to_app, size: 35),
                onTap: () {
                  settingsControllerImp.logout();
                },
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
