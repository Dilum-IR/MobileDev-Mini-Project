import 'package:biomark/src/app/screens/auth/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../comman/style/app_input_style.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/popup_warning.dart';
import '../../controllers/user/user_signup_controller.dart';
import 'signup_step_2.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => UserSignupState();
}

class UserSignupState extends State<UserSignup> {

  @override
  void initState() {
    // print("User " + UserHandler.currentUser);
    super.initState();
  }

  // password visibility
  bool _isVisible = false;

  // confirm password visibility
  bool _iscVisible = false;

  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        dragStartBehavior: DragStartBehavior.start,
        child: SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  tSvgLogo,
                  height: height / 12,
                  width: width/7,
                ),
                const SizedBox(
                  height: 10,
                ),
                // SizedBox(height: height / 8),
                SizedBox(
                  width: width - 50,
                  child: const Text(
                    "Create an Account",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller:  controller.nameController,
                        onChanged: (name) => onNameChanged(name),
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validName ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: "Brandon Loise",
                          labelText: "Full Name",
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
                        height: 8,
                      ),
                      TextField(
                        controller: controller.emailController,
                        onChanged: (email) => onEmailChanged(email),
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validEmail ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: "brandonloise@gmail.com",
                          labelText: "Email",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.emailIcon,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _emailError,
                          style: AppInputStyle.errorTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: controller.passwordController,
                        onChanged: (password) => onPasswordChanged(password),
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
                          filled: validPassword ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: AppInputStyle.hintObsureCharacter,
                          labelText: "Password",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.passwordIcon,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _passwordError,
                          style: AppInputStyle.errorTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: controller.re_passwordController,
                        onChanged: (re_password) =>
                            onRePasswordChanged(re_password),
                        obscureText: !_iscVisible,
                        obscuringCharacter: AppInputStyle.obscuringCharacter,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            splashRadius: 5,
                            onPressed: () {
                              setState(() {
                                _iscVisible = !_iscVisible;
                              });
                            },
                            icon: _iscVisible
                                ? AppInputStyle.visibleIcon
                                : AppInputStyle.visibilityOffIcon,
                          ),
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          contentPadding: AppInputStyle.contentPadding,
                          filled: validRepassword ? true : false,
                          fillColor: AppInputStyle.validFillColor,
                          hintText: AppInputStyle.hintObsureCharacter,
                          labelText: "Confirm Password",
                          hintStyle: AppInputStyle.hintTextStyle,
                          labelStyle: AppInputStyle.labelTextStyle,
                          floatingLabelStyle: AppInputStyle.floatingLabelStyle,
                          prefixIcon: AppInputStyle.passwordIcon,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: width - 65,
                        child: Text(
                          textAlign: TextAlign.start,
                          _repasswordError,
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
                                Future.delayed(const Duration(seconds: 5), () {
                                  setState(() {
                                    istap = !istap;
                                  });
                                });
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
                                    "Next",
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account ?"),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      onPressed: (() {
                        Get.offAll(
                          () => const UserSignin(),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 500),
                        );
                        controller.removeData();
                      }),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: KColors.primaryColor),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  final specialDigitRegex = RegExp(r'^(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-])');
  final numericRegex = RegExp(r'[0-9]');
  final nameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$');
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool validInput = false;
  bool istap = false;

  bool validName = false;
  String _nameError = '';

  onNameChanged(String userName) {
    final name = userName.trim().toString();

    setState(() {
      _nameError = '';
      validName = false;
      if (name.isEmpty) {
        _nameError = "* Name is required.";
      } else if (!nameRegex.hasMatch(name) || name.length < 3)
        _nameError = "* Name is invalid.";
      else {
        _nameError = "";
        validName = true;
      }
    });
  }

  bool validEmail = false;

  String _emailError = '';

  onEmailChanged(String email) {
    setState(() {
      _emailError = '';
      validEmail = false;

      if (email.isEmpty) {
        _emailError = "* Email is required.";
      } else if (!emailRegExp.hasMatch(email))
        _emailError = "* Email is invalid.";
      else {
        _emailError = '';
        validEmail = true;
      }
    });
  }

  bool validPassword = false;

  String _passwordError = '';

  onPasswordChanged(String password) {
    setState(() {
      _passwordError = '';
      validPassword = false;

      if (password.isEmpty) {
        _passwordError = "* Password is required.";
        return;
      }
      if (password.length <= 6) {
        _passwordError = "* Password must be 6 characters long.";
      } else if (!numericRegex.hasMatch(password))
        _passwordError = "* Password must contain at least one number.";
      else if (!specialDigitRegex.hasMatch(password))
        _passwordError = '* Password must contain at least one special digit.';
      else if (password.trim().toString() !=
          controller.re_passwordController.text.trim().toString() &&
          controller.re_passwordController.text.isNotEmpty) {
        _repasswordError = "* Password does not match.";
        validPassword = false;
        validRepassword = false;
      } else if (password.trim().toString() ==
          controller.re_passwordController.text.trim().toString()) {
        _repasswordError = "";
        validPassword = true;
        validRepassword = true;
      } else {
        _passwordError = "";
        validPassword = true;
      }
    });
  }

  bool validRepassword = false;
  String _repasswordError = '';

  onRePasswordChanged(String rePassword) {
    final repassword = rePassword.trim().toString();

    setState(() {
      _repasswordError = '';
      validRepassword = false;

      if (repassword.isEmpty) {
        _repasswordError = "*Confirm Password is required.";
        return;
      }
      if (repassword.length <= 6) {
        _repasswordError = "* Password must be 6 characters long.";
      } else if (!numericRegex.hasMatch(repassword))
        _repasswordError = "* Password must contain at least one number.";
      else if (!specialDigitRegex.hasMatch(repassword))
        _repasswordError =
            "* Password must contain at least one special digit.";
      else if (repassword.trim().toString() !=
          controller.passwordController.text.trim().toString())
        _repasswordError = "* Password does not match.";
      else {
        _repasswordError = "";
        validRepassword = true;
      }
    });
  }

  bool validInputData() {
    if (validPassword && validRepassword && validEmail && validName) {
      return true;
    } else {
      return false;
    }
  }

  final controller = Get.put(UserSignUpController());

  void registerUser() {
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
    Get.to(()=>const UserSignupStep2(),transition: Transition.cupertino,
      duration: const Duration(milliseconds: 1000),);
    // controller.registerAsUser();
  }
}
