import 'package:biomark/src/app/screens/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/constants.dart';
import '../../controllers/user/shared_auth_user.dart';
import 'on_board_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    animation();
    super.initState();
  }

  void animation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  final pages = [
    const OnBoardPage(
      color: KColors.kOnboardColor,
      image: tOnBoardImage1,
      title: "Welcome to Biomark",
      sub_title: "Contribute to research while keeping your identity protected.",
    ),
    const OnBoardPage(
      color: KColors.kOnboardColor,
      image: tOnBoardImage2,
      title: "Your Data, Secured",
      sub_title: "Your information is anonymous and safely stored for research.",
    ),
    const OnBoardPage(
      color: KColors.kOnboardColor,
      image: tOnBoardImage3,
      title: "Track Your Contributions",
      sub_title: "Get insights and manage your participation with your PAC.",
    ),
  ];

  final controller = LiquidController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            slideIconWidget: currentPage != 2
                ? const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: KColors.primaryColor,
                    size: 28,
                  )
                : Container(),
            enableSideReveal: true,
            liquidController: controller,
            enableLoop: false,
            pages: pages,
            onPageChangeCallback: onPageChangeCallBack,
          ),
          Positioned(
            bottom: 20,
            child: AnimatedSmoothIndicator(
              effect: const WormEffect(
                  dotHeight: 5,
                  dotColor: Colors.black45,
                  activeDotColor: KColors.primaryColor),
              activeIndex: controller.currentPage,
              count: 3,
            ),
          ),
          Positioned(
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FadeTransition(
                  opacity: fadeAnimation,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 2;
                      });
                      controller.jumpToPage(page: 2);
                    },
                    child: currentPage != 2
                        ? const Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          )
                        : Container(),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.7,
                ),
                TextButton(
                  onPressed: currentPage == 2
                      ? () {
                          SharedAuthUser.saveOnBoard(true);
                          Get.offAll(
                            const UserSignin(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 500),
                          );
                        }
                      : () {
                          setState(() {
                            currentPage++;
                          });
                          controller.animateToPage(
                            page: currentPage,
                            duration: 500,
                          );
                        },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      color:  KColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onPageChangeCallBack(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
