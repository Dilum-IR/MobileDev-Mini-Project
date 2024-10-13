import 'dart:async';

import 'package:biomark/src/app/screens/auth/signup_step_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../comman/style/app_input_style.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper/device.dart';
import '../../controllers/user/user_signup_controller.dart';
import '../user/security_information/recovery_account.dart';

class UserSignin extends StatefulWidget {
  const UserSignin({super.key});

  @override
  State<UserSignin> createState() => UserSigninState();
}

class UserSigninState extends State<UserSignin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // password visibility
  bool _isVisible = false;

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SizedBox(
          // height: height,
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
                height: 20,
              ),
              const Text(
                "Welcome Back!",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height / 30),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
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
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      onChanged: (email) => onPasswordChanged(email),
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
                        filled: validpassword ? true : false,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          onPressed: (() {
                            Get.to(
                                  () => const RecoveryAccount(),
                              transition: Transition.fade,
                              duration: const Duration(milliseconds: 500),
                            );
                          }),
                          child: const Text(
                            "Reset Password",
                            style: TextStyle(
                              color: KColors.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    MaterialButton(
                      animationDuration: const Duration(milliseconds: 10000),
                      height: 40,
                      minWidth: double.infinity,
                      disabledColor: KColors.primaryColor.withOpacity(0.5),
                      onPressed: (validEmail && validpassword) && !istap
                          ? () {
                              loginUser();
                              if (mounted) {
                                setState(() {
                                  istap = !istap;
                                });
                              }
                              Future.delayed(const Duration(seconds: 5), () {
                                if (mounted) {
                                  setState(() {
                                    istap = !istap;
                                  });
                                }
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
                                  "Sign In",
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: (() {
                      // print(UserHandler.currentUser);
                      Get.off(
                        () => const UserSignup(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 500),
                      );
                    }),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: KColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool istap = false;

  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool validInput = false;

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

  bool validpassword = false;
  String _passwordError = '';

  onPasswordChanged(String repassword) {
    setState(() {
      _passwordError = '';
      validpassword = false;

      if (repassword.isEmpty) {
        _passwordError = "* Password is required.";
        return;
      } else {
        _passwordError = "";
        validpassword = true;
      }
    });
  }

  final controller = Get.put(UserSignUpController());

  void loginUser() {
    final email = emailController.text.trim().toString();
    final password = passwordController.text.trim().toString();

    controller.loginAsUsers(email, password);
  }
}
