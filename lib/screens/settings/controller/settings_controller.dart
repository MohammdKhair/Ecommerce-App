import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SettingsController extends GetxController {
  logout();
  switchnotify(val);
  contactUs();
}

class SettingsControllerImp extends SettingsController {
  MyServices myServices = Get.find();
  bool notify = false;
  String contactus = "";

  @override
  logout() {
    String userid = myServices.sharedPreferences.getString("id")!;
    FirebaseMessaging.instance.subscribeToTopic("users");
    FirebaseMessaging.instance.subscribeToTopic("users$userid");
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.login);
  }

  @override
  switchnotify(val) {
    notify = val;
    update();
  }

  @override
  contactUs() async {
    await launchUrl(Uri.parse("tel:$contactus"));
  }

  @override
  void onInit() {
    contactus = myServices.sharedPreferences.getString("contactus")!;
    super.onInit();
  }
}
