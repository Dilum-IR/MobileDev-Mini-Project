import 'package:biomark/src/app/controllers/user/shared_auth_user.dart';
import 'package:biomark/src/app/screens/check_connection/check_network.dart';
import 'package:biomark/src/utils/colors/colors.dart';
import 'package:biomark/src/utils/helper/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedAuthUser.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  // check connections
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: KColors.white,
      title: 'Biomark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: KColors.appPrimary,
        timePickerTheme: KColors.timePicker,
          datePickerTheme: DatePickerThemeData(
            backgroundColor: Colors.white,
            dayForegroundColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected) ? Colors.white : Colors.black),
            yearForegroundColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected) ? KColors.primaryColor : Colors.black),
            rangeSelectionBackgroundColor: KColors.secondaryColor,
          ),

      ),
      home: const CheckNetwork(),
    );
  }
}
