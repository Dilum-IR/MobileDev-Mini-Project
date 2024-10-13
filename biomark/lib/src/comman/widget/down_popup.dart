import 'package:biomark/src/app/dao/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/controllers/user/user_feature_controller.dart';
import '../../utils/colors/colors.dart';
import '../style/app_input_style.dart';

class DownPopup {
  static final _resetPasswordformKey = GlobalKey<FormState>();
  static final controller = Get.put(UserFeatureController());

  static bool isTapChangeEmail = false;
  static bool isTapChangePassword = false;
  static bool isPopupEye = false;
  static const bool _isVisibleNew = false;

  static String? onPasswordChanged(String? password) {
    if (password!.isEmpty) {
      return "* Password is required.";
    } else {
      return null;
    }
  }

  static final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? onEmailChanged(String? email) {
    if (email!.isEmpty) {
      return "* Email is required.";
    } else if (!emailRegExp.hasMatch(email)) {
      return "* Email is invalid.";
    } else {
      return null;
    }
  }
  static void showPopupContainer(BuildContext context, UserModel user) {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 460,
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter New Email & Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Form(
                      key: _resetPasswordformKey,
                      child: SizedBox(
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffeeeeee),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                validator: onEmailChanged,
                                cursorColor: Colors.black,
                                cursorHeight: 15,
                                controller:
                                controller.recoveryEmailController,
                                decoration: InputDecoration(
                                  border: AppInputStyle.outlineInputBorder,
                                  focusedBorder: AppInputStyle.outlineInputBorder,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 17,
                                    vertical: 15,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "brandonloise@gmail.com",
                                  labelText: "Your New Email Address",
                                  hintStyle: AppInputStyle.hintTextStyle,
                                  labelStyle: AppInputStyle.labelTextStyle,
                                  floatingLabelStyle:
                                  AppInputStyle.floatingLabelStyle,
                                  prefixIcon: AppInputStyle.emailIcon,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffeeeeee),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller:
                                controller.recoveryPasswordController,
                                validator: onPasswordChanged,
                                obscureText: !_isVisibleNew,
                                obscuringCharacter: AppInputStyle.obscuringCharacter,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    splashRadius: 5,
                                    onPressed: () {
                                      // setState(() {
                                      //   _isVisibleNew = !_isVisibleNew;
                                      // });
                                    },
                                    icon: _isVisibleNew
                                        ? AppInputStyle.visibleIcon
                                        : AppInputStyle.visibilityOffIcon,
                                  ),
                                  border: AppInputStyle.outlineInputBorder,
                                  focusedBorder: AppInputStyle.outlineInputBorder,
                                  contentPadding: AppInputStyle.contentPadding,
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: AppInputStyle.hintObsureCharacter,
                                  labelText: "Your New Password",
                                  hintStyle: AppInputStyle.hintTextStyle,
                                  labelStyle: AppInputStyle.labelTextStyle,
                                  floatingLabelStyle:
                                  AppInputStyle.floatingLabelStyle,
                                  prefixIcon: AppInputStyle.passwordIcon,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            MaterialButton(
                              animationDuration: const Duration(milliseconds: 10000),
                              height: 50,
                              minWidth: double.infinity,
                              disabledColor: KColors.primaryColor.withOpacity(0.4),
                              onPressed:  () async {

                                if (_resetPasswordformKey.currentState!
                                    .validate()) {
                                  controller.finalRecoveryAccount(user);
                                }
                              },
                              color: KColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: KColors.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: isTapChangePassword
                                    ? const SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : const Text(
                                  "Recover Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}