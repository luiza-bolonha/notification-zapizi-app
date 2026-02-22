

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBar(String msg, {String title = 'Atenção'}){
  Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.white
  );
}