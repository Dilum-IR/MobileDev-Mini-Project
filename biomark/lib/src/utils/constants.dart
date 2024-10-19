import 'package:flutter/material.dart';

import '../app/dao/slider_model.dart';

// on boarding files
const tOnBoardImage1 = "assets/images/slider_images/img1.png";
const tOnBoardImage2 = "assets/images/slider_images/img4.png";
const tOnBoardImage3 = "assets/images/slider_images/img3.png";

// no internet
const tNoInternet = "assets/animations/connect_error_1.json";

// images
const tLogo = "assets/images/brands_logo/1024.png";
const tSvgLogo = "assets/images/brands_logo/logo.svg";

const tProfile = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";

// home screen slider images
const SliderImages = [
  "assets/images/slider_images/img1.png",
  "assets/images/slider_images/img2.png",
  "assets/images/slider_images/img3.png",
  "assets/images/slider_images/img4.png",
  "assets/images/slider_images/img5.png",
];

class AppConstants {
  static TextStyle largeText = const TextStyle(
    fontSize: 29,
    fontWeight: FontWeight.w500,
  );
  static TextStyle smallerText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}

// userType constants
const kUserType = "User";
const kEmpType = "Employee";

List<SliderModel> banners = [
  SliderModel(
      description:
          "We enable seamless logging of all your health data and connect your smart devices to our App, so you can manage all your health data in one place.",
      icon: Icons.ssid_chart,
      name: "Tracking"),
  SliderModel(
      description: "We help you make sense of your data and highlight any abnormal biomarkers, so that you can work towards living a better and healthier life.",
      icon: Icons.health_and_safety,
      name: "Health"),
  SliderModel(
      description: "Travelling or need to take a PCR test? You can now book a test appointment on the patient app.",
      icon: Icons.heart_broken_sharp,
      name: "COVID-19"),

];

List <String> questions = [
  "What was your primary school?",
  "What is your favorite book?",
  "What was the model of your car?",
  "Where did you go on your vacation?",
  "In what city were you born?",
  "What was your first job?"
];