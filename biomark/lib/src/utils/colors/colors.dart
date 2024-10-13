import 'package:flutter/material.dart';

class KColors {
  KColors._();

  // primary theme data app color
  static const MaterialColor appPrimary = MaterialColor(0xff1A96D8, {
    50: Color(0xff1A96D8),
    100: Color(0xff1A96D8),
    200: Color(0xff1A96D8),
    300: Color(0xff1A96D8),
    400: Color(0xff1A96D8),
    500: Color(0xff1A96D8),
    600: Color(0xff1A96D8),
    700: Color(0xff1A96D8),
    800: Color(0xff1A96D8),
    900: Color(0xff1A96D8),
  });

  static TimePickerThemeData timePicker = TimePickerThemeData(
    backgroundColor: Colors.white,
    hourMinuteTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
            ? KColors.secondaryColor
            : states.contains(MaterialState.disabled)
            ? KColors.primaryColor
            : KColors.primaryColor),
    dialBackgroundColor: KColors.primaryColor.withOpacity(0.5),
    dialHandColor: KColors.secondaryColor,
    dialTextColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected)
        ? Colors.white
        : Colors.black),
    entryModeIconColor: KColors.secondaryColor,
  );

  static const Color primaryColor = Color(0xff1A96D8);
  static const Color thirdPartyColor = Color(0xffe0eff6);
  static const Color secondaryColor = Color(0xff034E8B);

  static const Color white = Colors.white;
  static const Color gray = Color(0xff838383);
  static const Color black = Colors.black;
  static const Color lightGray = Color(0xff5A5A5A);


  // on board colors
  static const kOnboardColor = Colors.white;

  static const Color error = Color(0xCBD32F2F);
  static const Color success = Color(0xCC388E3C);
  static  const Color warning = Color(0x98F57C00);
  static const Color info = Color(0xA51976D2);
}
