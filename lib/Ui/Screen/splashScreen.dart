import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management_project/Ui/Utils/assets_path.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';

import 'sign_in.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future moveToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backgroundimage(
        child: SvgPicture.asset(
          imagePath.logoImage,
          width: 180,
        ),
      ),
    );
  }
}
