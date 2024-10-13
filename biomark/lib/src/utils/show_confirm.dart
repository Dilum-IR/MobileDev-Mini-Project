import 'package:flutter/material.dart';

import 'colors/colors.dart';

class ShowConfirm {
  static void dialog(BuildContext context, String desc, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: KColors.white,
          title: const Text(
            "Confirmation",
            style: TextStyle(color: KColors.primaryColor),
          ),
          content: Text(desc),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black45),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              style: TextButton.styleFrom(foregroundColor: KColors.primaryColor),
              child: const Text(
                "Yes",
                style: TextStyle(color: KColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
