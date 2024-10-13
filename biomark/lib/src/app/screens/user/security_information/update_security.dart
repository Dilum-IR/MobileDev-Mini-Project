import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../comman/style/app_input_style.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/helper/user_handler.dart';
import '../../../../utils/popup_warning.dart';
import '../../../../utils/show_confirm.dart';
import '../../../controllers/user/shared_auth_user.dart';
import '../../../controllers/user/user_feature_controller.dart';
import '../../../controllers/user/user_signup_controller.dart';

class UpdateSecurity extends StatefulWidget {
  const UpdateSecurity({super.key});

  @override
  State<UpdateSecurity> createState() => _UpdateSecurityState();
}

class _UpdateSecurityState extends State<UpdateSecurity> {
  final _resetEmailformKey = GlobalKey<FormState>();
  final _resetPasswordformKey = GlobalKey<FormState>();
  // password visibility
  bool _isVisible = false;
  bool _isVisibleNew = false;
  bool _isVisiblecurrent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: const Text(
          "Advanced Settings",
          style: TextStyle(
            color: KColors.secondaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Iconsax.setting_2,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 17,
          right: 17,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Change Your Email address",
              style: TextStyle(
                color: KColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _resetEmailformKey,
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
                          controller: authController.newEmailController,
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 15,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: UserHandler.email,
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
                          cursorColor: Colors.black,
                          controller: authController.currentPasswordController,
                          validator: onPasswordChanged,
                          obscureText: !_isVisible,
                          obscuringCharacter: AppInputStyle.obscuringCharacter,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashRadius: 5,
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: _isVisible
                                  ? AppInputStyle.visibleIcon
                                  : AppInputStyle.visibilityOffIcon,
                            ),
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: AppInputStyle.hintObsureCharacter,
                            labelText: "Current Password",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                                AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.passwordIcon,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        animationDuration: const Duration(milliseconds: 10000),
                        height: 48,
                        minWidth: double.infinity,
                        disabledColor: KColors.primaryColor.withOpacity(0.4),
                        onPressed: isTapChangeEmail
                            ? null
                            : () async {
                                if (mounted) {
                                  setState(() {
                                    isTapChangeEmail = true;
                                  });
                                }

                                if (_resetEmailformKey.currentState!
                                    .validate()) {
                                  bool res = await authController.changeEmail();

                                  if (mounted) {
                                    setState(() {
                                      isTapChangeEmail = res;
                                    });
                                  }
                                } else {
                                  if (mounted) {
                                    setState(() {
                                      isTapChangeEmail = false;
                                    });
                                  }
                                }
                              },
                        color: KColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: KColors.secondaryColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: isTapChangeEmail
                              ? const SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Update Email",
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
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Reset Your Password",
              style: TextStyle(
                color: KColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                          cursorColor: Colors.black,
                          controller:
                          authController.currentChangeNewPassController,
                          validator: onPasswordChanged,
                          obscureText: !_isVisibleNew,
                          obscuringCharacter: AppInputStyle.obscuringCharacter,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashRadius: 5,
                              onPressed: () {
                                setState(() {
                                  _isVisibleNew = !_isVisibleNew;
                                });
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
                          cursorColor: Colors.black,
                          controller:
                              authController.currentChangePasswordController,
                          validator: onPasswordChanged,
                          obscureText: !_isVisiblecurrent,
                          obscuringCharacter: AppInputStyle.obscuringCharacter,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashRadius: 5,
                              onPressed: () {
                                setState(() {
                                  _isVisiblecurrent = !_isVisiblecurrent;
                                });
                              },
                              icon: _isVisiblecurrent
                                  ? AppInputStyle.visibleIcon
                                  : AppInputStyle.visibilityOffIcon,
                            ),
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: AppInputStyle.hintObsureCharacter,
                            labelText: "Your Current Password",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                                AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.passwordIcon,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        animationDuration: const Duration(milliseconds: 10000),
                        height: 50,
                        minWidth: double.infinity,
                        disabledColor: KColors.primaryColor.withOpacity(0.4),
                        onPressed: isTapUnsub
                            ? null
                            : () async {
                                if (mounted) {
                                  setState(() {
                                    isTapUnsub = true;
                                  });
                                }

                                if (_resetPasswordformKey.currentState!
                                    .validate()) {
                                  bool res =
                                      await authController.resetPassword();
                                  isTapUnsub = res;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                } else {
                                  if (mounted) {
                                    setState(() {
                                      isTapUnsub = false;
                                    });
                                  }
                                }
                              },
                        color: KColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: KColors.primaryColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: isTapUnsub
                              ? const SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Change Password",
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
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Delete My Account",
              style: TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              animationDuration: const Duration(milliseconds: 10000),
              height: 50,
              minWidth: double.infinity,
              disabledColor: Colors.red.withOpacity(0.4),
              onPressed: () async {
                dialog(context,
                    "Do you want to Account with all information are permanently deleted form BioMark ?",
                    () {
                  controller.unSubscribe();
                  controller.onPopupWithPasswordController.clear();
                }, isPopupEye);
              },
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.red),
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
                        "Unsubscribe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final controller = Get.put(UserFeatureController());
  final authController = Get.put(UserSignUpController());

  bool isTapChangeEmail = false;
  bool isTapChangePassword = false;
  bool isPopupEye = false;
  bool isTapUnsub = false;

  @override
  void initState() {
    authController.removeData();
    super.initState();
  }

  String? onPasswordChanged(String? password) {
    if (password!.isEmpty) {
      return "* Password is required.";
    } else {
      return null;
    }
  }

  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  String? onEmailChanged(String? email) {
    if (email!.isEmpty) {
      return "* Email is required.";
    } else if (!emailRegExp.hasMatch(email)) {
      return "* Email is invalid.";
    } else {
      return null;
    }
  }

  void dialog(BuildContext context, String desc, Function onConfirm, bool eye) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: KColors.white,
          title: const Text(
            "Confirmation",
            style: TextStyle(color: KColors.primaryColor),
          ),
          content: SizedBox(
            height: 140,
            child: Column(
              children: [
                Text(desc),
                const SizedBox(
                  height: 20,
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
                    controller: controller.onPopupWithPasswordController,
                    validator: onPasswordChanged,
                    obscureText: !eye,
                    obscuringCharacter: AppInputStyle.obscuringCharacter,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        splashRadius: 5,
                        onPressed: () {
                          setState(() {
                            eye = !eye;
                          });
                        },
                        icon: eye
                            ? AppInputStyle.visibleIcon
                            : AppInputStyle.visibilityOffIcon,
                      ),
                      border: AppInputStyle.outlineInputBorder,
                      focusedBorder: AppInputStyle.outlineInputBorder,
                      contentPadding: AppInputStyle.contentPadding,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: AppInputStyle.hintObsureCharacter,
                      labelText: "Current Password",
                      hintStyle: AppInputStyle.hintTextStyle,
                      labelStyle: AppInputStyle.labelTextStyle,
                      floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                      prefixIcon: AppInputStyle.passwordIcon,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                if (controller.onPopupWithPasswordController.text.isEmpty) {
                  PopupWarning.Warning(
                    title: "Password is required",
                    message: "Please enter your current password",
                    type: 1,
                  );
                  return;
                }
                Navigator.pop(context);
                onConfirm();
              },
              style:
                  TextButton.styleFrom(foregroundColor: KColors.primaryColor),
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
