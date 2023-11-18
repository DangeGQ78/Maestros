import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alerts {
  List<Icon> iconos = [
    Icon(Icons.dangerous),
    Icon(
      Icons.verified,
      color: Colors.red,
    )
  ];

  void showAlerts(
      {required String title, required String message, required bool isError}) {
    Get.snackbar(title, message,
        duration: Duration(seconds: 3), icon: isError ? iconos[0] : iconos[1]);
  }
}
