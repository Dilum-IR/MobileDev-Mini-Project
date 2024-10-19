import 'package:cloud_firestore/cloud_firestore.dart';

import '../app/dao/user_model.dart';
import '../utils/popup_warning.dart';
import 'exceptions/crud_failure.dart';

class CrudServices {
  final FirebaseFirestore service = FirebaseFirestore.instance;

  Future<void> insert(
      {required String collection, required dynamic data}) async {
    try {
      await service.collection(collection).doc(data.id).set(data.toJson());
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    }
  }

  Future<UserModel> findOne(
      {required String collection, required String filed}) async {
    late UserModel data;

    try {
      await service.collection(collection).doc(filed).get().then((value) {
        // login user data collect
        if (collection == "Users") {
          data = UserModel.fromSnapshot(value);
        }
      });
      return data;
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message + ".",
        type: 1,
      );
      throw ex;
    }
  }

  Future<List<UserModel>> recoverUserOne(
      {required String name,
      required String dob,
      required String petName}) async {
    try {
      final sanpshot = await service
          .collection("Users")
          .where("name", isEqualTo: name)
          .where("dob", isEqualTo: dob)
          .where("petName", isEqualTo: petName)
          .get();

      return sanpshot.docs.map((obj) => UserModel.fromSnapshot(obj)).toList();
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message + ".",
        type: 1,
      );
      throw ex;
    }
  }

  Future<dynamic> update(
      {required String collection,
      required dynamic data,
      required String id}) async {
    try {
      await service.collection(collection).doc(id).update(data);
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      throw ex;
    }
  }

  Future<dynamic> delete(
      {required String collection, required String filed}) async {
    try {
      await service.collection(collection).doc(filed).delete();
    } on FirebaseException catch (e) {
      final ex = CrudFailure.code(e.code);
      PopupWarning.Warning(
        title: "Try again later",
        message: ex.message,
        type: 1,
      );
      throw ex;
    } catch (_) {
      final ex = CrudFailure();
      throw ex;
    }
  }
}
