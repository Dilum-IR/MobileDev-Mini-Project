import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../comman/style/app_input_style.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/show_confirm.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';

class AddPersonalInformation extends StatefulWidget {
  const AddPersonalInformation({super.key});

  @override
  State<AddPersonalInformation> createState() => AddPersonalInformationState();
}

class AddPersonalInformationState extends State<AddPersonalInformation> {
  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
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
            height: height / 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width - 50,
                  child: const Text(
                    "Add Other Information",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.black,
                          cursorHeight: 15,
                          controller: controller.timeOfBirthController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Time of Birth is required.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 15,
                            ),
                            filled: true,
                            fillColor: KColors.white,
                            hintText: "00:00 AM",
                            labelText: "Time of Birth",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                                AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.timeIcon,
                            errorBorder: AppInputStyle.InputErrorBorder,
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectTime(context);
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: controller.locationOfBirthController,
                          validator: onLocationChanged,
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true,
                            fillColor: KColors.white,
                            hintText: "Colombo, Sri Lanka",
                            labelText: "Location of Birth",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                                AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.locationIcon,
                            errorBorder: AppInputStyle.InputErrorBorder,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          value: controller.bloodGroup.text,
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true,
                            fillColor: KColors.white,
                            hintText: "Brandon Loise", // Adjust hint if needed
                            labelText: "Blood Group",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                                AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.bloodIcon,
                            errorBorder: AppInputStyle.InputErrorBorder,
                          ),
                          items: <String>[
                            'A+',
                            'B+',
                            'O+',
                            'AB+',
                            'A-',
                            'B-',
                            'O-',
                            'AB-'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value
                                ,style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            );
                          }).toList(),
                          dropdownColor: KColors.thirdPartyColor,
                          onChanged: (String? newValue) {
                            controller.bloodGroup.text = newValue!;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          hint: const Text("Select Blood Group"),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          value: controller.sex.text,
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true,
                            fillColor: KColors.white,
                            hintText: "Male", // Adjust hint if needed
                            labelText: "Sex",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                            AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.sexIcon,
                            errorBorder: AppInputStyle.InputErrorBorder,
                          ),
                          items: <String>[
                            'Male',
                            'Female',
                            'Unknown'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value
                                ,style: const TextStyle(
                                fontWeight: FontWeight.w400
                              ),),
                            );
                          }).toList(),
                          dropdownColor: KColors.thirdPartyColor,
                          onChanged: (String? newValue) {
                            controller.sex.text = newValue!;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          hint: const Text("Select Blood Group"),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: controller.height,
                          validator: (value){
                            if (value!.isEmpty) {
                              return "* Height is required.";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true ,
                            fillColor: KColors.white,
                            hintText:
                                "10cm",
                            labelText: "Your Height (cm)",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                                AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.heightIcon,
                            errorBorder: AppInputStyle.InputErrorBorder,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          value: controller.ethnicity.text,
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true,
                            fillColor: KColors.white,
                            hintText: "Sinhalese", // Adjust hint if needed
                            labelText: "ethnicity",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                            AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.ethnicityIcon,
                            errorBorder: AppInputStyle.InputErrorBorder,
                          ),
                          items: <String>[
                            "Sinhalese",
                            "Tamils",
                            "Muslims",
                            "Burghers",
                            "Malays",
                            "Vedda"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value
                                ,style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),),
                            );
                          }).toList(),
                          dropdownColor: KColors.thirdPartyColor,
                          onChanged: (String? newValue) {
                            controller.ethnicity.text = newValue!;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          hint: const Text("Select Your Ethnicity"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          value: controller.eyeColour.text,
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            filled: true,
                            fillColor: KColors.white,
                            hintText: "Black",
                            labelText: "Eye Colour",
                            hintStyle: AppInputStyle.hintTextStyle,
                            labelStyle: AppInputStyle.labelTextStyle,
                            floatingLabelStyle:
                            AppInputStyle.floatingLabelStyle,
                            prefixIcon: AppInputStyle.eyeIcon,
                            errorBorder: AppInputStyle.InputErrorBorder,
                          ),
                          items: <String>[
                            "Black",
                            "Brown",
                            "Blue",
                            "Hazel",
                            "Gray"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value
                                ,style: const TextStyle(
                                    fontWeight: FontWeight.w400
                                ),),
                            );
                          }).toList(),
                          dropdownColor: KColors.thirdPartyColor,
                          onChanged: (String? newValue) {
                            controller.eyeColour.text = newValue!;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          hint: const Text("Select Your Eye Colour"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        MaterialButton(
                          animationDuration:
                              const Duration(milliseconds: 10000),
                          height: 45,
                          minWidth: double.infinity,
                          disabledColor: KColors.primaryColor.withOpacity(0.5),
                          onPressed: istap ? null : () {
                            if (_formKey.currentState!.validate()) {
                              ShowConfirm.dialog(context, "You can't update information later...\nAre you sure ?",() {
                                SharedAuthUser.saveOnMoreData(true);
                                controller.saveAboutMe();
                                setState(() {
                                  istap = true;
                                });
                              });

                            }else
                              {
                                setState(() {
                                  istap = false;
                                });
                              }
                          },
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
                                      width: 17,
                                      height: 17,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Update Profile",
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
                ),
              ],
            )),
      ),
    );
  }

  final RegExp nameRegex = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)*$');
  bool istap = false;
  final _formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();

  final controller = Get.put(UserFeatureController());


  @override
  void initState() {

    controller.removeData();
    controller.bloodGroup.text = 'A+';
    controller.sex.text = "Male";
    controller.ethnicity.text = "Sinhalese";
    controller.eyeColour.text = "Black";
    super.initState();
  }

  // Method to open the Time Picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        controller.timeOfBirthController.text = picked.format(context);
        selectedTime = picked;
      });
    }
  }

  String? onLocationChanged(String? userName) {
    final name = userName?.trim().toString();
    if (name!.isEmpty) {
      return "* Location is required.";
    } else if (!nameRegex.hasMatch(name) || name.length < 3) {
      return "* Location is invalid.";
    } else {
      return null;
    }
  }
}
