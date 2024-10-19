import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/constants.dart';

class UserModel {
  final String id;
  late String name;
  late String email;
  late String userType;

  late String dob; // date of birth
  late String phone;
  late String image_url;

  late String motherName;
  late String friendName;
  late String petName;
  late String ownQuestion;
  late String ownAnswer;

  late String tob; // time of birth
  late String lob; // location of birth
  late String bloodGroup;
  late String sex;
  late String height;
  late String ethnicity;
  late String eyeColour;

  late bool addMore;

  UserModel.register({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.dob,
    required this.motherName,
    required this.friendName,
    required this.petName,
    required this.ownQuestion,
    required this.ownAnswer,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userType": userType,
      "name": name,
      "email": email,
      "dob": dob,
      "motherName": motherName,
      "friendName": friendName,
      "petName": petName,
      "ownQuestion": ownQuestion,
      "ownAnswer":ownAnswer,
      "addMore": false
    };
  }

  // about me model
  UserModel.aboutMe({
    required this.id,
    required this.tob,
    required this.lob,
    required this.bloodGroup,
    required this.sex,
    required this.height,
    required this.ethnicity,
    required this.eyeColour,
  });

  Map<String, dynamic> toJsonAboutMe() {
    return {
      "id": id,
      "tob": tob,
      "lob": lob,
      "bloodGroup": bloodGroup,
      "sex": sex,
      "height": height,
      "ethnicity": ethnicity,
      "eyeColour": eyeColour,
      "addMore": true
    };
  }

  //All information include DAO
  UserModel.myInfo(
      {required this.id,
        required this.name,
        required this.email,
        required this.userType,
        required this.dob,
        required this.motherName,
        required this.friendName,
        required this.petName,
        required this.ownQuestion,
        required this.ownAnswer,
        required this.tob,
        required this.lob,
        required this.bloodGroup,
        required this.sex,
        required this.height,
        required this.ethnicity,
        required this.eyeColour,
        required this.phone,
        required this.image_url,
        required this.addMore});

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.myInfo(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      userType: data['userType'] ?? '',
      phone: data['phone'] ?? '',
      dob: data['dob'] ?? '',
      image_url: data['image_url'] ?? tProfile,
      motherName: data['motherName'] ?? '',
      friendName: data['friendName'] ?? '',
      petName: data['petName'] ?? '',
      ownQuestion: data['ownQuestion'] ?? '',
      ownAnswer: data['ownAnswer'] ?? '',
      tob: data['tob'] ?? '',
      lob: data['lob'] ?? '',
      bloodGroup: data['bloodGroup'] ?? '',
      sex: data['sex'] ?? '',
      height: data['height'] ?? '',
      ethnicity: data['ethnicity'] ?? '',
      eyeColour: data['eyeColour'] ?? '',
      addMore: data['addMore'] ?? false,
    );
  }

  UserModel.addImage({required this.id, required this.image_url});

  Map<String, dynamic> toJsonAddImage() {
    return {
      "id": id,
      "image_url": image_url,
    };
  }
}
