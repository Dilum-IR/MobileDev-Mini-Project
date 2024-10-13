import 'dart:io';

import 'package:biomark/src/app/screens/auth/signin_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../comman/style/app_input_style.dart';
import '../../../comman/widget/upload_progress.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../../utils/popup_warning.dart';
import '../../../utils/show_confirm.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';
import 'security_information/update_security.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var width = KDeviceUtils.getWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: KColors.secondaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
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
            size: 28,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              Iconsax.setting_2,
              color: KColors.primaryColor,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              splashRadius: 20,
              onPressed: () {
                ShowConfirm.dialog(context, "Do you want to logout ?", () {
                  SharedAuthUser.removeUser();
                  SharedAuthUser.removeInfoUser();
                  SharedAuthUser.removeimageUrl();

                  SharedAuthUser.removeOnMoreData();
                  SharedAuthUser.removeOtherInfoUser();

                  Get.offAll(
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 1200),
                    () => const UserSignin(),
                  );
                  setState(() {});
                });
              },
              icon: const Icon(
                Iconsax.logout,
                color: KColors.secondaryColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 63,
                            backgroundColor: Colors.black87,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 57,
                                backgroundColor:
                                    KColors.primaryColor.withOpacity(0.3),
                                child: pickerFile == null
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            SharedAuthUser.getimageUrl() ??
                                                tProfile,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 110,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: imageProvider,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          alignment: Alignment.center,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: KColors.primaryColor,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(pickerFile!.path!),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  uploadImage();
                                },
                                icon: AppInputStyle.cameraIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    UploadFileProgress(
                      uploadTask: uploadTask,
                      height: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            width: width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Get.to(
                                      () => const UpdateSecurity(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                );
                              },
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 15,
                                    ),
                                    child: const Row(
                                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                                      // textBaseline: TextBaseline.ideographic,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.security_outlined,
                                          color: KColors.primaryColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Advanced Security Settings",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 15,
                                    ),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: KColors.primaryColor,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: IconButton(
                                      padding: const EdgeInsets.only(left: 0),
                                      splashColor:
                                          KColors.primaryColor.withOpacity(0.5),
                                      splashRadius: 30,
                                      onPressed: () {
                                        Get.to(
                                          () => const UpdateSecurity(),
                                          transition: Transition.rightToLeft,
                                          duration: const Duration(
                                            milliseconds: 500,
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          // todo: About me
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
                            child: TextField(
                              cursorColor: Colors.black,
                              cursorHeight: 15,
                              controller: nameController,
                              decoration: InputDecoration(
                                border: AppInputStyle.outlineInputBorder,
                                focusedBorder: AppInputStyle.outlineInputBorder,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 15,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Brandone louise",
                                labelText: "Full Name",
                                hintStyle: AppInputStyle.hintTextStyle,
                                labelStyle: AppInputStyle.labelTextStyle,
                                floatingLabelStyle:
                                    AppInputStyle.floatingLabelStyle,
                                prefixIcon: AppInputStyle.profileIcon,
                              ),
                              readOnly: true,
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
                            child: TextField(
                              cursorColor: Colors.black,
                              cursorHeight: 15,
                              controller: emailController,
                              decoration: InputDecoration(
                                border: AppInputStyle.outlineInputBorder,
                                focusedBorder: AppInputStyle.outlineInputBorder,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 15,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "brandonelouise@gmail.com",
                                labelText: "Email",
                                hintStyle: AppInputStyle.hintTextStyle,
                                labelStyle: AppInputStyle.labelTextStyle,
                                floatingLabelStyle:
                                    AppInputStyle.floatingLabelStyle,
                                prefixIcon: AppInputStyle.emailIcon,
                              ),
                              readOnly: true,
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
                            child: TextField(
                              cursorColor: Colors.black,
                              cursorHeight: 15,
                              controller: motherNameController,
                              decoration: InputDecoration(
                                border: AppInputStyle.outlineInputBorder,
                                focusedBorder: AppInputStyle.outlineInputBorder,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 15,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Jane Doe",
                                labelText: "Mother's Maiden Name",
                                hintStyle: AppInputStyle.hintTextStyle,
                                labelStyle: AppInputStyle.labelTextStyle,
                                floatingLabelStyle:
                                    AppInputStyle.floatingLabelStyle,
                                prefixIcon: AppInputStyle.profileIcon,
                              ),
                              readOnly: true,
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
                            child: TextField(
                              cursorColor: Colors.black,
                              cursorHeight: 15,
                              controller: friendNameController,
                              decoration: InputDecoration(
                                border: AppInputStyle.outlineInputBorder,
                                focusedBorder: AppInputStyle.outlineInputBorder,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 15,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "John Doe",
                                labelText: "Best Friend's Name",
                                hintStyle: AppInputStyle.hintTextStyle,
                                labelStyle: AppInputStyle.labelTextStyle,
                                floatingLabelStyle:
                                    AppInputStyle.floatingLabelStyle,
                                prefixIcon: AppInputStyle.profileIcon,
                              ),
                              readOnly: true,
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
                            child: TextField(
                              cursorColor: Colors.black,
                              cursorHeight: 15,
                              controller: petNameController,
                              decoration: InputDecoration(
                                border: AppInputStyle.outlineInputBorder,
                                focusedBorder: AppInputStyle.outlineInputBorder,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 15,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Kitty",
                                labelText: "Pet's Name",
                                hintStyle: AppInputStyle.hintTextStyle,
                                labelStyle: AppInputStyle.labelTextStyle,
                                floatingLabelStyle:
                                    AppInputStyle.floatingLabelStyle,
                                prefixIcon: AppInputStyle.petIcon,
                              ),
                              readOnly: true,
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
                            child: TextField(
                              cursorColor: Colors.black,
                              cursorHeight: 15,
                              controller: dateController,
                              decoration: InputDecoration(
                                border: AppInputStyle.outlineInputBorder,
                                focusedBorder: AppInputStyle.outlineInputBorder,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 15,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "YYYY-MM-DD",
                                labelText: "Date Of Birth",
                                hintStyle: AppInputStyle.hintTextStyle,
                                labelStyle: AppInputStyle.labelTextStyle,
                                floatingLabelStyle:
                                    AppInputStyle.floatingLabelStyle,
                                prefixIcon: AppInputStyle.dateIcon,
                              ),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SharedAuthUser.getOnMoreData() == false
                              ? const SizedBox(
                                  height: 20,
                                )
                              : SizedBox(
                                  width: width,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: width,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: width / 2 - 25,
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffeeeeee),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                cursorHeight: 15,
                                                controller: tobController,
                                                decoration: InputDecoration(
                                                  border: AppInputStyle
                                                      .outlineInputBorder,
                                                  focusedBorder: AppInputStyle
                                                      .outlineInputBorder,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 17,
                                                    vertical: 15,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "00:00 AM",
                                                  labelText: "Time Of Birth",
                                                  hintStyle: AppInputStyle
                                                      .hintTextStyle,
                                                  labelStyle: AppInputStyle
                                                      .labelTextStyle,
                                                  floatingLabelStyle:
                                                      AppInputStyle
                                                          .floatingLabelStyle,
                                                  prefixIcon:
                                                      AppInputStyle.timeIcon,
                                                ),
                                                readOnly: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              width: width / 2 - 25,
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffeeeeee),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                cursorHeight: 15,
                                                controller: lobController,
                                                decoration: InputDecoration(
                                                  border: AppInputStyle
                                                      .outlineInputBorder,
                                                  focusedBorder: AppInputStyle
                                                      .outlineInputBorder,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 17,
                                                    vertical: 15,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText:
                                                      "Colombo, Sri Lanka",
                                                  labelText: "Place Of Birth",
                                                  hintStyle: AppInputStyle
                                                      .hintTextStyle,
                                                  labelStyle: AppInputStyle
                                                      .labelTextStyle,
                                                  floatingLabelStyle:
                                                      AppInputStyle
                                                          .floatingLabelStyle,
                                                  prefixIcon: AppInputStyle
                                                      .locationIcon,
                                                ),
                                                readOnly: true,
                                              ),
                                            ),
                                          ],
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
                                        child: TextField(
                                          cursorColor: Colors.black,
                                          cursorHeight: 15,
                                          controller: bloodGroupController,
                                          decoration: InputDecoration(
                                            border: AppInputStyle
                                                .outlineInputBorder,
                                            focusedBorder: AppInputStyle
                                                .outlineInputBorder,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 17,
                                              vertical: 15,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "O+",
                                            labelText: "Blood Group",
                                            hintStyle:
                                                AppInputStyle.hintTextStyle,
                                            labelStyle:
                                                AppInputStyle.labelTextStyle,
                                            floatingLabelStyle: AppInputStyle
                                                .floatingLabelStyle,
                                            prefixIcon: AppInputStyle.bloodIcon,
                                          ),
                                          readOnly: true,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: width,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: width / 2 - 25,
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffeeeeee),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                cursorHeight: 15,
                                                controller: sexController,
                                                decoration: InputDecoration(
                                                  border: AppInputStyle
                                                      .outlineInputBorder,
                                                  focusedBorder: AppInputStyle
                                                      .outlineInputBorder,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 17,
                                                    vertical: 15,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "Male",
                                                  labelText: "Sex",
                                                  hintStyle: AppInputStyle
                                                      .hintTextStyle,
                                                  labelStyle: AppInputStyle
                                                      .labelTextStyle,
                                                  floatingLabelStyle:
                                                      AppInputStyle
                                                          .floatingLabelStyle,
                                                  prefixIcon:
                                                      AppInputStyle.sexIcon,
                                                ),
                                                readOnly: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              width: width / 2 - 25,
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffeeeeee),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                cursorHeight: 15,
                                                controller: heightController,
                                                decoration: InputDecoration(
                                                  border: AppInputStyle
                                                      .outlineInputBorder,
                                                  focusedBorder: AppInputStyle
                                                      .outlineInputBorder,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 17,
                                                    vertical: 15,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "00cm",
                                                  labelText: "Your Height",
                                                  hintStyle: AppInputStyle
                                                      .hintTextStyle,
                                                  labelStyle: AppInputStyle
                                                      .labelTextStyle,
                                                  floatingLabelStyle:
                                                      AppInputStyle
                                                          .floatingLabelStyle,
                                                  prefixIcon:
                                                      AppInputStyle.heightIcon,
                                                ),
                                                readOnly: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: width,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: width / 2 - 25,
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffeeeeee),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                cursorHeight: 15,
                                                controller: ethnicityController,
                                                decoration: InputDecoration(
                                                  border: AppInputStyle
                                                      .outlineInputBorder,
                                                  focusedBorder: AppInputStyle
                                                      .outlineInputBorder,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 17,
                                                    vertical: 15,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "Sinhalase",
                                                  labelText: "Ethnicity",
                                                  hintStyle: AppInputStyle
                                                      .hintTextStyle,
                                                  labelStyle: AppInputStyle
                                                      .labelTextStyle,
                                                  floatingLabelStyle:
                                                      AppInputStyle
                                                          .floatingLabelStyle,
                                                  prefixIcon: AppInputStyle
                                                      .ethnicityIcon,
                                                ),
                                                readOnly: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              width: width / 2 - 25,
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffeeeeee),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                cursorHeight: 15,
                                                controller: eyeColourController,
                                                decoration: InputDecoration(
                                                  border: AppInputStyle
                                                      .outlineInputBorder,
                                                  focusedBorder: AppInputStyle
                                                      .outlineInputBorder,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 17,
                                                    vertical: 15,
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: "Black",
                                                  labelText: "Eye Colour",
                                                  hintStyle: AppInputStyle
                                                      .hintTextStyle,
                                                  labelStyle: AppInputStyle
                                                      .labelTextStyle,
                                                  floatingLabelStyle:
                                                      AppInputStyle
                                                          .floatingLabelStyle,
                                                  prefixIcon:
                                                      AppInputStyle.eyeIcon,
                                                ),
                                                readOnly: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  late var fileName;
  UploadTask? uploadTask;
  final ImagePicker _picker = ImagePicker();
  XFile? pickerFile;
  late var imageUrl;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController friendNameController = TextEditingController();

  final TextEditingController tobController = TextEditingController();
  final TextEditingController lobController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ethnicityController = TextEditingController();
  final TextEditingController eyeColourController = TextEditingController();

  bool isValid = false;

  final controller = Get.put(UserFeatureController());

  @override
  void initState() {
    final data = SharedAuthUser.getAuthInfoUser();
    final moreData = SharedAuthUser.getOtherInfoUser();

    print(SharedAuthUser.getOnMoreData());

    nameController.text = UserHandler.name;
    emailController.text = UserHandler.email;
    dateController.text = data[0];
    motherNameController.text = data[2];
    friendNameController.text = data[3];
    petNameController.text = data[4];

    if (SharedAuthUser.getOnMoreData()) {
      tobController.text = moreData[0];
      lobController.text = moreData[1];
      bloodGroupController.text = moreData[2];
      sexController.text = moreData[3];
      heightController.text = moreData[4] + " cm";
      ethnicityController.text = moreData[5];
      eyeColourController.text = moreData[6];
    }

    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  Future uploadImage() async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      } else if (status.isDenied) {
        requestMediaPermissions();
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      }

      final pickFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        pickerFile = pickFile;
      });
    } catch (_) {}

    uploadFile();
  }

  Future uploadFile() async {
    final path = "user_images/${UserHandler.email + "_" + pickerFile!.name}";
    final file = File(pickerFile!.path);

    final refe = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = refe.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {
      Future.delayed(const Duration(seconds: 1));
      PopupWarning.Warning(
        title: "Update Successful 🎉",
        message: "Your profile image added.",
      );
    });

    imageUrl = await snapshot.ref.getDownloadURL();
    SharedAuthUser.saveimageUrl(imageUrl);

    controller.saveImageUrl(imageUrl);

    if (mounted) {
      setState(() {
        uploadTask = null;
      });
    }
  }

  Future<void> requestMediaPermissions() async {
    if (await Permission.photos.isGranted &&
        await Permission.videos.isGranted &&
        await Permission.audio.isGranted) {
    } else {
      await [
        Permission.photos,
        Permission.videos,
        Permission.audio,
      ].request();
    }
  }
}
