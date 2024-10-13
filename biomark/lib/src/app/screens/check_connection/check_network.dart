import 'package:biomark/src/app/screens/user/user_home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/authentication_services.dart';
import '../../../utils/constants.dart';
import '../../../utils/no_connection.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../auth/signin_screen.dart';
import '../on_boarding/on_boarding_screen.dart';

class CheckNetwork extends StatefulWidget {
  const CheckNetwork({super.key});

  @override
  State<CheckNetwork> createState() => _CheckNetworkState();
}

class _CheckNetworkState extends State<CheckNetwork> {
  final authController = Get.put(AuthenticationService());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ConnectivityResult result = snapshot.data!;

              // If connected to the internet
              if (result == ConnectivityResult.mobile ||
                  result == ConnectivityResult.wifi ||
                  result == ConnectivityResult.ethernet) {

                // Check user login status
                return FutureBuilder<User?>(
                  future: authController.checkUserLoginStatus(),
                  builder: (context, loginSnapshot) {
                    // if (loginSnapshot.connectionState == ConnectionState.waiting) {
                    //   // While waiting for the login check, show a loader
                    //   return const Center(child: CircularProgressIndicator());
                    // }
                    if (loginSnapshot.hasData && SharedAuthUser.getAuthUser() != null) {
                      // User is logged in
                      var authUser = SharedAuthUser.getAuthUser();
                      if (authUser != null && authUser[1] == kUserType) {
                        return const UserHomeScreen();
                      } else if (SharedAuthUser.getOnBoard() == null) {
                        return const OnBoardingScreen();
                      } else {
                        return const UserSignin();
                      }
                    } else if (SharedAuthUser.getOnBoard() == null) {
                      return const OnBoardingScreen();
                    } else {
                      return const UserSignin();
                    }
                  },
                );
              } else {
                // No internet connection
                return const NoConnection();
              }
            } else {
              // In case of an error or loading
              return const NoConnection();
            }
          },
        ),
      ),
    );
  }
}
