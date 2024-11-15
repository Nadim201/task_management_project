
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    String? message,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Color backgroundColor = Colors.indigoAccent,
    Color colorText = Colors.white,
  }) {
    Get.snackbar(
      title,
      message ?? '', // Default to an empty string if message is null
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      colorText: colorText,
    );
  }

  static void showSuccess(String title, {String? message}) {
    show(
      title: title,
      message: message,
      backgroundColor: Colors.indigoAccent,
      colorText: Colors.white,
    );
  }

  // Helper method for error snackbar
  static void showError(String title, {String? message}) {
    show(
      title: title,
      message: message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
//