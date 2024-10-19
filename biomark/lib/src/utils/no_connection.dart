import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'colors/colors.dart';
import 'constants.dart';
import 'popup_warning.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection>
    with TickerProviderStateMixin {
  // fade animation for use controllers & Animation
  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> fadeOutAnimation1;
  late Animation<double> fadeOutAnimation2;

  // slide animation for use controller & Animation
  late AnimationController slideController;
  late Animation<double> slideAnimation;
  late Animation<double> fadeSlideAnimation;

  bool istap = false;

  void animation() {
    // bottom to top slide animation
    slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: slideController,
        curve: Curves.easeInOut,
      ),
    );
    // slider animation for use fade animation
    fadeSlideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: slideController,
        curve: Curves.easeInOut,
      ),
    );

    controller1 = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..forward();
    fadeOutAnimation1 =
        CurvedAnimation(parent: controller1, curve: Curves.easeInOut);

    controller2 = AnimationController(
        duration: const Duration(milliseconds: 2200), vsync: this)
      ..forward();
    fadeOutAnimation2 =
        CurvedAnimation(parent: controller2, curve: Curves.easeInOutCubic);
  }

  @override
  void initState() {
    animation();
    super.initState();
  }

  @override
  void dispose() {
    slideController.dispose();
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          FadeTransition(
            opacity: fadeOutAnimation1,
            child: Lottie.asset(
              tNoInternet,
              alignment: Alignment.center,
              height: size.height / 2.5,
              width: size.width,
              repeat: true,
              reverse: true,
            ),
          ),
          AnimatedBuilder(
            animation: slideController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0.0, slideAnimation.value * size.height / 2.5),
                child: Opacity(
                  opacity: fadeSlideAnimation.value,
                  child: child,
                ),
              );
            },
            child: Container(
                width: size.width / 1.05,
                height: size.height / 2.5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: FadeTransition(
                  opacity: fadeOutAnimation2,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Ooops!",
                        style: AppConstants.largeText,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "No internet connection found. Check your\n connection or try again.",
                        style: AppConstants.smallerText,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: Colors.redAccent,
                        focusColor: Colors.redAccent,
                        onTap: !istap
                            ? () async {
                                ConnectivityResult result =
                                    await Connectivity().checkConnectivity();

                                if (kDebugMode) {
                                  print(result.toString());
                                }

                                if (result == ConnectivityResult.none) {
                                  PopupWarning.Warning(
                                      title: "Network Connection Unstable",
                                      message:
                                          "Please check your connection and try again.",
                                      type: 1);

                                  setState(() {
                                    istap = !istap;
                                  });
                                } else {
                                  PopupWarning.Warning(
                                      title: "Successful...",
                                      message: "Network Connection Stable",
                                      type: 3);
                                  setState(() {
                                    istap = !istap;
                                  });
                                }
                                Future.delayed(const Duration(seconds: 4), () {
                                  setState(() {
                                    istap = !istap;
                                  });
                                });
                              }
                            : null,
                        child: Container(
                          width: size.width / 2.8,
                          height: 45,
                          decoration: BoxDecoration(
                            color: KColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: istap
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Try Again",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
