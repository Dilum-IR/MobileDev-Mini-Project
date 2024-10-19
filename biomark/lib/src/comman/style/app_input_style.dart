import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/colors/colors.dart';

class AppInputStyle {
  //obsecure character
  static String obscuringCharacter = '●';
  static String hintObsureCharacter = '●●●●●●●●●';

  // user input success with field filled color
  static Color validFillColor = KColors.primaryColor.withOpacity(0.1);

  // border
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black));

  static OutlineInputBorder outlineDropDownInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black12));

  static OutlineInputBorder InputErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red));

  // text style
  static TextStyle hintTextStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 14.0,
  );
  static TextStyle labelTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
  static TextStyle floatingLabelStyle = const TextStyle(
    color: Colors.black,
    fontSize: 18.0,
  );

  static TextStyle errorTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );

  // Icons
  static Icon profileIcon = const Icon(
    Iconsax.user,
    color: KColors.primaryColor,
    size: 18,
  );

  static Icon emailIcon = const Icon(
    Icons.email_outlined,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon petIcon = const Icon(
    Iconsax.pet,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon quaIcon = const Icon(
    Iconsax.message,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon dateIcon = const Icon(
    Iconsax.calendar,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon timeIcon = const Icon(
    Iconsax.timer_1,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon locationIcon = const Icon(
    Iconsax.location,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon bloodIcon = const Icon(
    Iconsax.health,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon heightIcon = const Icon(
    Iconsax.level,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon sexIcon = const Icon(
    Iconsax.status,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon ethnicityIcon = const Icon(
    Iconsax.icon,
    color: KColors.primaryColor,
    size: 18,
  );

  static Icon eyeIcon = const Icon(
    Iconsax.eye,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon cameraIcon = const Icon(
    Iconsax.camera,
    color: KColors.white,
    size: 18,
  );

  static Icon passwordIcon = const Icon(
    Iconsax.key,
    color: KColors.primaryColor,
    size: 18,
  );
  static Icon visibleIcon = const Icon(
    Icons.visibility,
    color: Colors.black,
  );
  static Icon visibilityOffIcon = const Icon(
    Icons.visibility_off,
    color: Colors.grey,
  );
  // padding
  static EdgeInsets contentPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
}
