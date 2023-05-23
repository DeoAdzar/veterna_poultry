import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/my_colors.dart';

class ShowSnackbar {
  static snackBarError(String message) {
    Get.rawSnackbar(
        messageText: Text(
          message,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        isDismissible: true);
    // duration: const Duration(seconds: 2),
    // forwardAnimationCurve: Curves.fastOutSlowIn);
  }

  static snackBarSuccess(String message) {
    Get.rawSnackbar(
        messageText: Text(
          message,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        isDismissible: true);
    // duration: const Duration(seconds: 2),
    // forwardAnimationCurve: Curves.fastOutSlowIn);
  }

  static snackBarNormal(String message) {
    Get.rawSnackbar(
        messageText: Text(
          message,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        backgroundColor: MyColors.mainColor,
        snackPosition: SnackPosition.TOP,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        isDismissible: true);
    // duration: const Duration(seconds: 2),
    // forwardAnimationCurve: Curves.fastOutSlowIn);
  }
}
