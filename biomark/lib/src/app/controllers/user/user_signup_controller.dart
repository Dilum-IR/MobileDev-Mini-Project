import 'package:bcrypt/bcrypt.dart';
import 'package:biomark/src/app/controllers/user/shared_auth_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/authentication_services.dart';
import '../../../services/user_services.dart';
import '../../../utils/constants.dart';
import '../../../utils/popup_warning.dart';
import '../../dao/user_model.dart';
import '../../screens/auth/signin_screen.dart';
import '../../screens/user/user_home_screen.dart';

class UserSignUpController extends GetxController {
  final authController = Get.put(AuthenticationService());
  final crudController = Get.put(CrudServices());
  static UserSignUpController get instance => Get.find();

  // sign up information step 1
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController re_passwordController = TextEditingController();

  // sign up information step 2
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController motherMedianController = TextEditingController();
  TextEditingController friendNameController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  TextEditingController yourQuestionController = TextEditingController();
  TextEditingController quesAnswerController = TextEditingController();

  // for change email
  TextEditingController newEmailController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  // for change password
  TextEditingController currentChangePasswordController =
      TextEditingController();
  TextEditingController currentChangeNewPassController = TextEditingController();


  void removeData() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    re_passwordController.clear();
    dateOfBirthController.clear();
    motherMedianController.clear();
    friendNameController.clear();
    petNameController.clear();

    newEmailController.clear();
    currentPasswordController.clear();

    currentChangePasswordController.clear();
    currentChangeNewPassController.clear();
    quesAnswerController.clear();
  }

  Future<bool> registerAsUser() async {
    try {
      final userCredential = await authController.registerUser(
          emailController.text.trim().toString(),
          passwordController.text.trim().toString());

      const userType = kUserType;

      String hashQuestion = BCrypt.hashpw(
          yourQuestionController.text.trim().toString(), BCrypt.gensalt());

      String hashAnswer = BCrypt.hashpw(
          quesAnswerController.text.trim().toString(), BCrypt.gensalt());

      final newUser = UserModel.register(
        email: emailController.text.trim().toString(),
        id: userCredential.user!.uid,
        name: nameController.text.trim().toString(),
        userType: userType,
        dob: dateOfBirthController.text.trim().toString(),
        motherName: motherMedianController.text.trim().toString(),
        friendName: friendNameController.text.trim().toString(),
        petName: petNameController.text.trim().toString(),
        ownQuestion: hashQuestion,
        ownAnswer:hashAnswer,
      );

      await authController
          .insertUser(collection: "Users", user: newUser)
          .whenComplete(() {
        PopupWarning.Warning(
          title: "Congratulations! 🎉",
          message: "Your account has been created!",
          type: 0,
        );
      });

      removeData();
      Get.offAll(
            () => const UserSignin(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // USER AUTHENTICATION AND GET USE DETAILS
  void loginAsUsers(String email, String password) async {
    String userId = "";
    try {
      await authController.loginUser(email, password).then((value) {
        userId = value.user!.uid;
      });

      // get user all information for saved to local storage
      final userData =
          await crudController.findOne(collection: "Users", filed: userId);

      if (userData.id.isNotEmpty) {
        PopupWarning.Warning(
          title: "Congratulations! 🎉",
          message: "Login Successful!",
          type: 0,
        );

        if (userData.userType == kUserType) {
          Get.offAll(
            () => const UserHomeScreen(),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 1000),
          );
        }
      }

      // save the users data in to the memory
      if (userData.email.isNotEmpty) {
        final authUser = [
          userData.id.toString(),
          userData.userType.toString(),
          userData.email.toString(),
          userData.name.toString(),
        ];
        SharedAuthUser.saveAuthUser(authUser);

        final aboutme = [
          userData.dob.toString(),
          userData.phone.toString(),
          userData.motherName.toString(),
          userData.friendName.toString(),
          userData.petName.toString(),
          userData.ownQuestion.toString(),
        ];

        SharedAuthUser.saveAuthInfoUser(aboutme);
      }

      SharedAuthUser.saveOnMoreData(userData.addMore);

      if (userData.addMore) {
        final addMore = [
          userData.tob.toString(),
          userData.lob.toString(),
          userData.bloodGroup.toString(),
          userData.sex.toString(),
          userData.height.toString(),
          userData.ethnicity.toString(),
          userData.eyeColour.toString(),
        ];
        SharedAuthUser.saveOtherInfoUser(addMore);
      }

      if (userData.image_url.isNotEmpty) {
        SharedAuthUser.saveimageUrl(userData.image_url.toString());
      }
    } catch (e) {}
  }

  // update user email
  Future<bool> changeEmail() async {
    try {
      bool res = await authController.updateEmail(
          newEmailController.text.trim(),
          currentPasswordController.text.trim());

      if (res) {
        PopupWarning.Warning(
          title: "Verify New Email",
          message: "Verification Email has been sent to your new email",
          type: 0,
        );
        logoutUser();
        removeData();
        Get.offAll(
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
              () => const UserSignin(),
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void logoutUser() {
    AuthenticationService.instance.logoutUser();
  }

  Future<bool> resetPassword() async {
    try {
      bool res = await authController.sendPasswordResetEmail(
          currentChangeNewPassController.text.trim(),
          currentChangePasswordController.text.trim());

      if (res) {
        PopupWarning.Warning(
          title: "Password Reset",
          message: "Password has been reset successfully",
          type: 0,
        );
        logoutUser();
        removeData();
        Get.offAll(
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
              () => const UserSignin(),
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    re_passwordController.dispose();
    newEmailController.dispose();
    currentPasswordController.dispose();
    quesAnswerController.dispose();
    super.dispose();
  }
}
