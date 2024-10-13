import 'dart:async';

import 'package:biomark/src/app/screens/user/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../comman/widget/popular_widget.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../../utils/show_confirm.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';
import '../../controllers/user/user_signup_controller.dart';
import '../auth/signin_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'add_personal_information.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => UserHomeScreenState();
}

class UserHomeScreenState extends State<UserHomeScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    var data = SharedAuthUser.getAuthUser();

    UserHandler.id = data[0];
    UserHandler.userType = data[1];
    UserHandler.email = data[2];
    UserHandler.name = UserHandler.capitalizeFirstLetter(data[3]);

    animation();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        activeIndex++;
        if (activeIndex == 4) activeIndex = 0;
      });
    });

    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    slideController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  final userController = Get.put(UserFeatureController());

  int selectIndex = 0;
  int _current = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void animation() {
    slideController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward().then((value) => null);

    fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeInQuad,
      ),
    );
  }

  int activeIndex = 0;
  Timer? _timer;

  late AnimationController fadeController;
  late AnimationController slideController;

  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;

  final authController = Get.put(UserSignUpController());
  final controller = Get.put(UserFeatureController());

  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // centerTitle: true,
        title: SvgPicture.asset(
          tSvgLogo,
          width: 28,
          height: 28,
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: KColors.primaryColor,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: SharedAuthUser.getOnMoreData() == true
                ? const SizedBox()
                : IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      Get.to(
                        () => const AddPersonalInformation(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                      );
                    },
                    icon: const Icon(
                      Iconsax.add_circle,
                      color: KColors.primaryColor,
                      size: 30,
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            // height: ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: fadeAnimation,
                  child: SizedBox(
                    height: height / 5.0,
                    width: width,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 0 ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset(
                              SliderImages[0],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 1 ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset(
                              SliderImages[1],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 2 ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset(
                              SliderImages[2],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: activeIndex == 3 ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.asset(
                              SliderImages[3],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Text(
                        "A New",
                        style: TextStyle(
                          color: KColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Look",
                        style: TextStyle(
                          color: KColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 18),
                  child: Text(
                    "BioMark continues to pioneer the future of health tech. New and exciting features are coming your way through our platforms. Stay tuned!",
                    style: TextStyle(
                      color: KColors.gray,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Text(
                        "What",
                        style: TextStyle(
                          color: KColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "We",
                        style: TextStyle(
                          color: KColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Do",
                        style: TextStyle(
                          color: KColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: width,
                  height: height / 3.6,
                  child: CarouselSlider(
                      // carouselController: _carouselController,
                      options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                          padEnds: true,
                          animateToClosest: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          height: height / 3.9,
                          // aspectRatio: 9 / 16,
                          viewportFraction: 0.67,
                          enlargeFactor: 0.427,
                          pageSnapping: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                      items: banners.map((element) {
                        return Builder(
                          builder: (BuildContext context) {
                            return PopularWidget(
                              element: element,
                            );
                          },
                        );
                      }).toList()),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.0),
                      child: Text(
                        "Visit Our",
                        style: TextStyle(
                          color: KColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Website",
                        style: TextStyle(
                          color: KColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: MaterialButton(
                    animationDuration: const Duration(milliseconds: 10000),
                    height: 50,
                    minWidth: double.infinity,
                    disabledColor: KColors.primaryColor.withOpacity(0.5),
                    onPressed: () async {
                      var url = Uri.https("www.biomarking.com");
                      await launchUrl(url);
                    },
                    color: KColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: KColors.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Learn More...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: KColors.secondaryColor,
              ),
              child: Center(
                child: Text(
                  'Hi, ${UserHandler.name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Iconsax.home_2,
                color: KColors.primaryColor,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  color: KColors.secondaryColor,
                ),
              ),
              onTap: () {
                // Handle navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Iconsax.user,
                color: KColors.primaryColor,
              ),
              title: const Text(
                'User Profile',
                style: TextStyle(
                  color: KColors.secondaryColor,
                ),
              ),
              onTap: () {
                Get.to(
                  () => const UserProfile(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                );
              },
            ),
            SharedAuthUser.getOnMoreData() == true
                ? const SizedBox()
                : ListTile(
                    leading: const Icon(
                      Iconsax.info_circle,
                      color: KColors.primaryColor,
                    ),
                    title: const Text(
                      'Add More Information',
                      style: TextStyle(
                        color: KColors.secondaryColor,
                      ),
                    ),
                    onTap: () {
                      Get.to(
                        () => const AddPersonalInformation(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                      );
                    },
                  ),
            ListTile(
              leading: const Icon(
                Iconsax.logout,
                color: KColors.primaryColor,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: KColors.secondaryColor,
                ),
              ),
              onTap: () {
                ShowConfirm.dialog(context, "Do you want to logout ?", () {
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
                  setState(() {});
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
