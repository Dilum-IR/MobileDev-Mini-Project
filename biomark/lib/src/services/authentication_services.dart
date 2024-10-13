import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../app/dao/user_model.dart';
import '../utils/popup_warning.dart';
import 'exceptions/crud_failure.dart';
import 'exceptions/signin_failure.dart';
import 'exceptions/signup_failure.dart';

class AuthenticationService extends GetxController {
  static AuthenticationService get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore service = FirebaseFirestore.instance;

  Future<dynamic> registerUser(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {

      final ex = SignUpFailure.code(e.code);
      PopupWarning.Warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex.message;
    } catch (_) {
      final ex = SignUpFailure();

      PopupWarning.Warning(
        title: "Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  Future<void> insertUser(
      {required String collection, required UserModel user}) async {
    try {
      await service.collection(collection).doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      PopupWarning.Warning(
        title: "User Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      PopupWarning.Warning(
        title: "User Signup Failure",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      final user = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return value;
      });

      return user;
    } on FirebaseAuthException catch (e) {
      final ex = SignInFailure.code(e.code);
      PopupWarning.Warning(
        title: "User SignIn Failure",
        message: ex.message,
        type: 1,
      );
      throw ex.message;
    } catch (_) {
      throw _;
    }
  }

  Future<User?> checkUserLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<bool> updateEmail(String email, String currentPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final credential = EmailAuthProvider.credential(
          email: user?.email ?? "", password: currentPassword);

      final UserCredential? userAuth =
          await user?.reauthenticateWithCredential(credential);

      if (userAuth == null) {
        return false;
      } else {

        await userAuth.user?.verifyBeforeUpdateEmail(email);

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user?.uid)
            .update(
          {
            "email": email,
          },
        );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      PopupWarning.Warning(
        title: "Email Update Failure",
        message: ex.message,
        type: 1,
      );
      throw ex.message;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      final ex = SignUpFailure.code(e.code);
      throw ex;
    } catch (_) {
      final ex = SignUpFailure();
      throw ex;
    }
  }

  Future<bool> sendPasswordResetEmail(
      String newPassword, String currentPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final credential =
          EmailAuthProvider.credential(email: user?.email ?? "", password: currentPassword);
      final UserCredential? userAuth =
          await user?.reauthenticateWithCredential(credential);

      if (userAuth == null) {
        return false;
      } else {

        await user?.updatePassword(newPassword);

        // another method for password reset using email link
        // await _auth.sendPasswordResetEmail(email: email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      PopupWarning.Warning(
        title: "Password Reset Failure",
        message: ex.message,
        type: 1,
      );
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteUserData(String currentPassword) async {
    try {

      final user = FirebaseAuth.instance.currentUser;

      final credential =
      EmailAuthProvider.credential(email: user?.email ?? "", password: currentPassword);
      final UserCredential? userAuth =
      await user?.reauthenticateWithCredential(credential);

      await userAuth?.user?.delete();
      await FirebaseFirestore.instance.collection('Users').doc(user?.uid).delete();
      return true;

    }
    on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      PopupWarning.Warning(
        title: "Password Reset Failure",
        message: ex.message,
        type: 1,
      );
      return false;
    }
    catch (e) {
      return false;
    }
  }
}
