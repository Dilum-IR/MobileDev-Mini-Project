import 'package:bcrypt/bcrypt.dart';
import 'package:biomark/src/app/controllers/user/shared_auth_user.dart';
import 'package:biomark/src/app/controllers/user/user_signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/authentication_services.dart';
import '../../../services/user_services.dart';
import '../../../utils/helper/user_handler.dart';
import '../../../utils/popup_warning.dart';
import '../../dao/user_model.dart';
import '../../screens/auth/signin_screen.dart';

class UserFeatureController extends GetxController {
  final authController = Get.put(AuthenticationService());
  final crudController = Get.put(CrudServices());
  final signupController = Get.put(UserSignUpController());

  // other information
  TextEditingController timeOfBirthController = TextEditingController();
  TextEditingController locationOfBirthController = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController ethnicity = TextEditingController();
  TextEditingController eyeColour = TextEditingController();

  // recovery account
  TextEditingController recoveryNameController = TextEditingController();
  TextEditingController recoveryDobController = TextEditingController();
  TextEditingController recoveryPetNameController = TextEditingController();
  TextEditingController recoveryOwnQController = TextEditingController();

  TextEditingController recoveryEmailController = TextEditingController();
  TextEditingController recoveryPasswordController = TextEditingController();

  // delete account
  TextEditingController onPopupWithPasswordController = TextEditingController();

  void saveAboutMe() async {
    try {
      final aboutMeData = UserModel.aboutMe(
          id: UserHandler.id,
          tob: timeOfBirthController.text.trim(),
          lob: locationOfBirthController.text.trim(),
          bloodGroup: bloodGroup.text.trim(),
          sex: sex.text.trim(),
          height: height.text.trim(),
          ethnicity: ethnicity.text.trim(),
          eyeColour: eyeColour.text.trim());

      await crudController
          .update(
            collection: "Users",
            data: aboutMeData.toJsonAboutMe(),
            id: UserHandler.id,
          )
          .then((value) => Get.back());

      PopupWarning.Warning(
        title: "Update Successful 🎉",
        message: "Your Profile updated",
      );

      // todo: success with add to the shared preferences

      final addMore = [
        timeOfBirthController.text.trim(),
        locationOfBirthController.text.trim(),
        bloodGroup.text.trim(),
        sex.text.trim(),
        height.text.trim(),
        ethnicity.text.trim(),
        eyeColour.text.trim()
      ];
      SharedAuthUser.saveOtherInfoUser(addMore);
    } catch (e) {}
  }

  void saveImageUrl(String url) {
    final saveImage = UserModel.addImage(id: UserHandler.id, image_url: url);
    crudController.update(
        collection: "Users",
        data: saveImage.toJsonAddImage(),
        id: UserHandler.id);
  }

  Future<void> unSubscribe() async {
    try {
      bool res = await authController
          .deleteUserData(onPopupWithPasswordController.text.trim());

      if (!res) {
        return;
      }

      SharedAuthUser.removeUser();
      SharedAuthUser.removeInfoUser();
      SharedAuthUser.removeimageUrl();

      SharedAuthUser.removeOnMoreData();
      SharedAuthUser.removeOtherInfoUser();
      authController.logoutUser();

      Get.offAll(
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
        () => const UserSignin(),
      );
    } catch (e) {}
  }

  Future<UserModel?> recoveryAccount() async {
    try {
      final List<UserModel> findUser = await crudController.recoverUserOne(
          name: recoveryNameController.text.trim(),
          dob: recoveryDobController.text.trim(),
          petName: recoveryPetNameController.text.trim(),
          ownQue: recoveryOwnQController.text.trim());

      if (findUser.isEmpty) {
        PopupWarning.Warning(
            title: "Account not found",
            message: "Please check your information",
            type: 1);
        return null;
      }

      bool isQueCorrect = BCrypt.checkpw(
          recoveryOwnQController.text.trim(), findUser[0].ownQuestion);
      if (isQueCorrect) {
        return findUser[0];
      } else {
        PopupWarning.Warning(
            title: "Account not found",
            message: "Please check your information",
            type: 1);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> finalRecoveryAccount(UserModel user) async {
    try {
      // delete a current account data from the database
      await crudController.delete(collection: "Users", filed: user.id);

      // create a new account
      final userCredential = await authController.registerUser(
          recoveryEmailController.text.trim(),
          recoveryPasswordController.text.trim());

      final newUser = UserModel.register(
        email: recoveryEmailController.text.trim(),
        id: userCredential.user!.uid,
        name: user.name,
        userType: user.userType,
        dob: user.dob,
        motherName: user.motherName,
        friendName: user.friendName,
        petName: user.petName,
        ownQuestion: user.ownQuestion,
      );

      // add data to the database
      await authController
          .insertUser(collection: "Users", user: newUser)
          .whenComplete(() {
        PopupWarning.Warning(
          title: "Congratulations! 🎉",
          message: "Your account has been created!",
          type: 0,
        );
      });

      // if add more is true then add more data to the database
      if (user.addMore) {
        final aboutMeData = UserModel.aboutMe(
            id: userCredential.user!.uid,
            tob: user.tob,
            lob: user.lob,
            bloodGroup: user.bloodGroup,
            sex: user.sex,
            height: user.height,
            ethnicity: user.ethnicity,
            eyeColour: user.eyeColour);

        await crudController.update(
          collection: "Users",
          data: aboutMeData.toJsonAboutMe(),
          id: userCredential.user!.uid,
        );
      }

      // if user image is not empty then add image to the database
      if (user.image_url != "") {
        final saveImage = UserModel.addImage(
            id: userCredential.user!.uid, image_url: user.image_url);

        crudController.update(
            collection: "Users",
            data: saveImage.toJsonAddImage(),
            id: userCredential.user!.uid);
      }

      // login as a user after recovery automatically
      signupController.loginAsUsers(recoveryEmailController.text.trim(),
          recoveryPasswordController.text.trim());
    } catch (e) {
      Get.back();
    }
  }

  void removeData() {
    timeOfBirthController.clear();
    locationOfBirthController.clear();
    bloodGroup.clear();
    sex.clear();
    height.clear();
    ethnicity.clear();
    eyeColour.clear();
  }

  @override
  void dispose() {
    timeOfBirthController.dispose();
    locationOfBirthController.dispose();
    bloodGroup.dispose();
    sex.dispose();
    height.dispose();
    ethnicity.dispose();
    eyeColour.dispose();
    super.dispose();
  }
}
