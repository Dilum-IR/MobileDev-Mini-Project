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
                      DropdownButtonFormField<String>(
                        value: controller.yourQuestionController.text,
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          filled: validAnswer ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText:
                              "Select your recover question", // Adjust hint if needed
                          labelText: "Select your recover question",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.quaIcon,
                          errorBorder: AppInputStyle.InputErrorBorder,
                        ),
                        menuMaxHeight: 222,
                        items: questions
                            .map<DropdownMenuItem<String>>((String queValue) {
                          return DropdownMenuItem<String>(
                            value: queValue,
                            child: SizedBox(
                              width: 258,
                              child: Text(
                                queValue,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                        dropdownColor: KColors.thirdPartyColor,
                        onChanged: (String? newValue) {
                          controller.yourQuestionController.text = newValue!;
                          if (mounted) {
                            setState(() {
                              validAnswer = true;
                            });
                          }
                        },
                        hint: const Text("Select your recover question"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: controller.quesAnswerController,
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
                          hintText: "Select recover question answer",
                          labelText: "Your recover Answer",
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
                                if (mounted) {
                                  setState(() {
                                    istap = !istap;
                                  });
                                }
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
  // final RegExp quesRegex = RegExp(r"^[a-zA-Z\s]+[\w\s,':-]*\?$");

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

  bool validAnswer = false;

  bool validDate = false;

  @override
  void initState() {
    controller.yourQuestionController.text = 'What was your primary school?';
    isValidInputs();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

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
      return "* Answer is required.";
    } else if (!nameRegex.hasMatch(name) || name.length < 5) {
      return "* Answer is invalid.";
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

  void isValidInputs() {
    if (controller.dateOfBirthController.text.isNotEmpty) {
      validDate = true;
    }
    if (onNameChanged(controller.motherMedianController.text) == "") {
      validName = true;
    }
    if (onNameChanged(controller.friendNameController.text) == "") {
      validFriendName = true;
    }
    if (onNameChanged(controller.petNameController.text) == "") {
      validPetName = true;
    }
    if (onQuestionChanged(controller.quesAnswerController.text) == "") {
      validQuestion = true;
    }
    if (mounted) {
      setState(() {});
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

      if (mounted) {
        setState(() {});
      }
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
    if (mounted) {
      setState(() {});
    }
  }
}
