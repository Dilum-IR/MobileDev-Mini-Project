import 'package:biomark/src/app/screens/auth/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../comman/style/app_input_style.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/popup_warning.dart';
import '../../controllers/user/user_signup_controller.dart';

class UserSignupStep2 extends StatefulWidget {
  const UserSignupStep2({super.key});

  @override
  State<UserSignupStep2> createState() => UserSignupStep2State();
}

class UserSignupStep2State extends State<UserSignupStep2> {

  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // toolbarHeight: 50,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        dragStartBehavior: DragStartBehavior.start,
        child: SizedBox(
            height: height / 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  tSvgLogo,
                  height: height / 12,
                  width: width / 7,
                ),
                const SizedBox(
                  height: 30,
                ),
                // SizedBox(height: height / 8),
                SizedBox(
                  width: width - 50,
                  child: const Text(
                    "Personal Information",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        cursorColor: Colors.black,
                        cursorHeight: 15,
                        controller: controller.dateOfBirthController,
                        decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 15,
                            ),
                            filled: validDate ? true : false,
                            fillColor: AppInputStyle.validFillColor,
                            hintText: "YYYY-MM-DD",
                            labelText: "Date of Birth",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                                AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.dateIcon),
                        readOnly: true,
                        onTap: () {
                          validDate = false;
                          _selectDate();
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                        controller: controller.motherMedianController,
                        onChanged: (name) {
                          _nameError = onNameChanged(name);

                          if (_nameError == '') {
                            validName = true;
                          } else {
                            validName = false;
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validName ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: "Brandon Loise",
                          labelText: "Mother's Maiden Name",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.profileIcon,
                          errorBorder: _nameError == ''
                              ? AppInputStyle.InputErrorBorder
                              : AppInputStyle.outlineInputBorder,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _nameError,
                          style: AppInputStyle.errorTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.friendNameController,
                        onChanged: (name) {
                          _friendNameError = onNameChanged(name);

                          if (_friendNameError == '') {
                            validFriendName = true;
                          } else {
                            validFriendName = false;
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validFriendName ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: "Brandon Loise",
                          labelText: "Childhood Best Friend's Name",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.profileIcon,
                          errorBorder: _friendNameError == ''
                              ? AppInputStyle.InputErrorBorder
                              : AppInputStyle.outlineInputBorder,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _friendNameError,
                          style: AppInputStyle.errorTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.petNameController,
                        onChanged: (name) {
                          _petNameError = onNameChanged(name);

                          if (_petNameError == '') {
                            validPetName = true;
                          } else {
                            validPetName = false;
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validPetName ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: "Kitty",
                          labelText: "Childhood Pet's Name",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.petIcon,
                          errorBorder: _petNameError == ''
                              ? AppInputStyle.InputErrorBorder
                              : AppInputStyle.outlineInputBorder,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _petNameError,
                          style: AppInputStyle.errorTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: controller.yourQuestionController,
                        onChanged: (name) {
                          _QuesError = onQuestionChanged(name);

                          if (_QuesError == '') {
                            validQuestion = true;
                          } else {
                            validQuestion = false;
                          }
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validQuestion ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: "What is your name? (Use a question mark)",
                          labelText: "Your recover question",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.quaIcon,
                          errorBorder: _QuesError == ''
                              ? AppInputStyle.InputErrorBorder
                              : AppInputStyle.outlineInputBorder,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _QuesError,
                          style: AppInputStyle.errorTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MaterialButton(
                        animationDuration: const Duration(milliseconds: 10000),
                        height: 40,
                        minWidth: double.infinity,
                        disabledColor: KColors.primaryColor.withOpacity(0.5),
                        onPressed: validInputData() && !istap
                            ? () {
                                registerUser();
                                setState(() {
                                  istap = !istap;
                                });
                                // Future.delayed(const Duration(seconds: 5), () {
                                //   setState(() {
                                //     istap = !istap;
                                //   });
                                // });
                              }
                            : null,
                        color: KColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: istap
                                ? const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  final RegExp nameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$');
  final RegExp quesRegex = RegExp(r"^[a-zA-Z\s]+[\w\s,':-]*\?$");

  bool validInput = false;
  bool istap = false;

  bool validName = false;
  String _nameError = '';

  bool validPetName = false;
  String _petNameError = '';

  bool validFriendName = false;
  String _friendNameError = '';

  bool validQuestion = false;
  String _QuesError = '';

  bool validDate = false;

  String onNameChanged(String userName) {
    final name = userName.trim().toString();
    if (name.isEmpty) {
      return "* Name is required.";
    } else if (!nameRegex.hasMatch(name) || name.length < 3) {
      return "* Name is invalid.";
    } else {
      return "";
    }
  }
  String onQuestionChanged(String userName) {
    final name = userName.trim().toString();
    if (name.isEmpty) {
      return "* Question is required.";
    } else if (!quesRegex.hasMatch(name) || name.length < 5) {
      return "* Question is invalid.";
    } else {
      return "";
    }
  }

  bool validInputData() {
    if (controller.dateOfBirthController.text.isNotEmpty &&
        validPetName &&
        validFriendName &&
        validName) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _selectDate() async {
    DateTime? _pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (_pickDate != null) {
      controller.dateOfBirthController.text =
          _pickDate.toString().split(" ")[0];
      if (_pickDate
          .isAfter(DateTime.now().subtract(const Duration(days: 365 * 12)))) {
        PopupWarning.Warning(
            title: "Try again later",
            message: "Your Choose date invalid",
            type: 2);
        controller.dateOfBirthController.text = "";
        return;
      }
      validDate = true;

      setState(() {});
    }
  }

  final controller = Get.put(UserSignUpController());

  Future<void> registerUser() async {
    final password = controller.passwordController.text.trim().toString();
    final repassword = controller.re_passwordController.text.trim().toString();

    if (password != repassword) {
      PopupWarning.Warning(
        title: "Password Wrong",
        message: "Password does not match.",
        type: 1,
      );
      return;
    }
    final bool res = await controller.registerAsUser();

    istap = res;
    if(mounted){
      setState(() {
      });
    }

  }
}
