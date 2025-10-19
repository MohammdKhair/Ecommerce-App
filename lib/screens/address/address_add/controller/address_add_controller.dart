// ignore_for_file: avoid_print

import 'dart:async';

import 'package:ecommerce_app/core/constant/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

abstract class AddressAddController extends GetxController {
  determinePosition();
  goToAddressDetales();
}

class AddressAddControllerImp extends AddressAddController {
  bool isLoading = true;
  LatLng? currentLocation;
  LatLng? destination;
  List<Marker> markers = [];
  LatLng? tappedPoint;
  String errorMessage = '';

  // إضافة متغيرات للتحكم في مركز وتكبير الخريطة
  LatLng mapCenter = const LatLng(33.5138, 36.2765); // مركز افتراضي (دمشق)
  double zoomLevel = 15.0;

  @override
  Future<void> determinePosition() async {
    try {
      isLoading = true;
      errorMessage = '';
      update();

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        errorMessage = 'خدمة الموقع غير مفعلة. يرجى تفعيلها';
        isLoading = false;
        update();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorMessage = 'تم رفض صلاحيات الموقع';
          isLoading = false;
          update();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        errorMessage =
            'صلاحيات الموقع مرفوضة بشكل دائم. يرجى التفعيل من الإعدادات';
        isLoading = false;
        update();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 10));

      currentLocation = LatLng(position.latitude, position.longitude);

      // تحديث مركز الخريطة إلى الموقع الحالي
      if (currentLocation != null) {
        mapCenter = currentLocation!;
        zoomLevel = 15.0;
      }
    } on TimeoutException {
      errorMessage = 'انتهت مهلة انتظار الحصول على الموقع';
    } on Exception catch (e) {
      errorMessage = 'حدث خطأ: ${e.toString()}';
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    determinePosition();
    super.onInit();
  }

  void retryGetLocation() {
    determinePosition();
  }

  void addMarker(LatLng point) {
    tappedPoint = point;
    markers = [
      Marker(
        point: point,
        child: const Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 40,
        ),
      )
    ];
    update();
  }

  void clearMarkers() {
    markers.clear();
    tappedPoint = null;
    update();
  }

  // دالة للعودة إلى الموقع الحالي
  void moveToCurrentLocation() {
    if (currentLocation != null) {
      mapCenter = currentLocation!;
      zoomLevel = 15.0;
      update();
    }
  }

  // دالة لتكبير الخريطة
  void zoomIn() {
    if (zoomLevel < 18.0) {
      zoomLevel += 1.0;
      update();
    }
  }

  // دالة لتصغير الخريطة
  void zoomOut() {
    if (zoomLevel > 4.0) {
      zoomLevel -= 1.0;
      update();
    }
  }

  @override
  goToAddressDetales() {
    Get.toNamed(AppRoute.addressAddDetails, arguments: {
      "lat": tappedPoint?.latitude.toString(),
      "long": tappedPoint?.longitude.toString()
    });
  }
}
