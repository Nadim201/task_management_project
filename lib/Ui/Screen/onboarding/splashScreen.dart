import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_in.dart';
import 'package:task_management_project/Ui/Utils/assets_path.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';

import '../../../data/controller/auth_controller.dart';
import '../../Utils/color.dart';
import '../task/MainBottomNavBar.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    await AuthController.getAccessToken();

    if (await AuthController.isSignedIn()) {
      await AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavBar(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backgroundimage(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(
                imagePath.splashImage,
                width: 450,
              ),
              const Positioned(
                bottom: 10,
                child: Text(
                  'Organize Your Tasks',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColor.themeColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
