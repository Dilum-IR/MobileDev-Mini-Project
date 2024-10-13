import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors/colors.dart';
import 'constants.dart';

class PopupWarning {
  static void Warning({
    required String title,
    required String message,
    int type = 0,
  }) {
    late IconData _icon;

    switch (type) {
      case 0:
        _icon = Icons.check_circle;
        break;
      case 1:
        _icon = Icons.error;
        break;
      case 2:
        _icon = Icons.warning;
        break;
      default:
        _icon = Icons.change_circle_rounded;
        break;
    }
    Get.snackbar(
      title,
      message,
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: type == 0
          ? KColors.success
          : type == 1
              ? KColors.error
              : type == 2
                  ? KColors.warning
                  : KColors.info,
      colorText: Colors.white,
      icon: Icon(
        _icon,
        color: Colors.white,
        size: 30,
        shadows: const [
          Shadow(
            color: Colors.black54,
            offset: Offset(0, 0),
            blurRadius: 50,
          ),
        ],
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      padding: const EdgeInsets.only(
        // right: 50,
        left: 20,
        top: 10,
        bottom: 10,
      ),
      maxWidth: 350,
      barBlur: 6,
    );
  }
}
