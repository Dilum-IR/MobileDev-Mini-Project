import 'dart:async';

import 'package:biomark/src/app/dao/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../comman/style/app_input_style.dart';
import '../../../../comman/widget/down_popup.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helper/device.dart';
import '../../../../utils/popup_warning.dart';
import '../../../controllers/user/user_feature_controller.dart';


class RecoveryAccount extends StatefulWidget {
  const RecoveryAccount({super.key});

  @override
  State<RecoveryAccount> createState() => RecoveryAccountState();
}

class RecoveryAccountState extends State<RecoveryAccount> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

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
                "Recover Account",
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
                      controller:  controller.recoveryNameController,
                      onChanged: (name) {
                        _nameError =  onNameChanged(name);
                        if (_QuesError == '') {
                          validName = true;
                        } else {
                          validName = false;
                        }
                        if (mounted) {
                          setState(() {});
                        }
                      } ,
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
                      height: 6,
                    ),
                    TextField(
                      cursorColor: Colors.black,
                      cursorHeight: 15,
                      controller: controller.recoveryDobController,
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
                    DropdownButtonFormField<String>(
                      value: controller.recoveryOwnQController.text,
                      decoration: InputDecoration(
                        border: AppInputStyle.outlineInputBorder,
                        focusedBorder: AppInputStyle.outlineInputBorder,
                        // contentPadding: AppInputStyle.contentPadding,
                        filled: true,
                        fillColor: KColors.white,
                        hintText: "Select your recover question", // Adjust hint if needed
                        labelText: "Select your recover question",
                        hintStyle: AppInputStyle.hintTextStyle,
                        labelStyle: AppInputStyle.labelTextStyle,
                        floatingLabelStyle:
                        AppInputStyle.floatingLabelStyle,
                        prefixIcon: AppInputStyle.quaIcon,
                        errorBorder: AppInputStyle.InputErrorBorder,
                      ),
                      menuMaxHeight: 222,
                      items: questions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: 258,
                            child: Text(value
                              ,style: const TextStyle(
                                  fontWeight: FontWeight.w400
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      dropdownColor: KColors.thirdPartyColor,
                      onChanged: (String? newValue) {
                        controller.recoveryOwnQController.text = newValue!;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      hint: const Text("Select your recover question"),
                    ),
                    const SizedBox(height: 15,),
                    TextField(
                      controller: controller.recoveryOwnAnswerController,
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
                        hintText: "Recover question answer",
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
                    TextField(
                      controller: controller.recoveryPetNameController,
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
                    MaterialButton(
                      animationDuration: const Duration(milliseconds: 10000),
                      height: 40,
                      minWidth: double.infinity,
                      disabledColor: KColors.primaryColor.withOpacity(0.5),
                      onPressed: validInputData() && !istap
                          ? () async {

                        if (mounted) {
                          setState(() {
                            istap = !istap;
                          });
                        }

                        // recovery logic
                        final UserModel? findUser = await controller.recoveryAccount();

                        if(findUser != null){
                          setState(() {
                            istap = !istap;
                          });
                          DownPopup.showPopupContainer(context, findUser);
                        }else{
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
                            "Next Step",
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
          ),
        ),
      ),
    );
  }

  final controller = Get.put(UserFeatureController());

  bool istap = false;

  final nameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$');

  bool validDate = false;

  bool validName = false;
  String _nameError = '';

  bool validPetName = false;
  String _petNameError = '';

  bool validQuestion = false;
  String _QuesError = '';

  @override
  void initState() {
    controller.recoveryOwnQController.text = 'What was your primary school?';
    super.initState();
  }
  @override
  void dispose() {
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
    } else if (name.length < 5) {
      return "* Answer is invalid.";
    } else {
      return "";
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
      controller.recoveryDobController.text =
      _pickDate.toString().split(" ")[0];
      if (_pickDate
          .isAfter(DateTime.now().subtract(const Duration(days: 365 * 12)))) {
        PopupWarning.Warning(
            title: "Try again later",
            message: "Your Choose date invalid",
            type: 2);
        controller.recoveryDobController.text = "";
        return;
      }
      validDate = true;

      setState(() {});
    }
  }

  bool validInputData() {
    if (controller.recoveryDobController.text.isNotEmpty &&
        validPetName &&
        validName && validQuestion) {
      return true;
    } else {
      return false;
    }
  }

}
