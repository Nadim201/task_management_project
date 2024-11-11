import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_project/Ui/Screen/onboarding/forgot_pass.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_in.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_up_screen.dart';
import 'package:task_management_project/Ui/Screen/onboarding/splashScreen.dart';
import 'package:task_management_project/Ui/Utils/color.dart';

import 'Ui/Screen/task/MainBottomNavBar.dart';
import 'Ui/Screen/task/add_task_screen.dart';
import 'controllerBinding.dart';

class Routes {
  static const String splash = Splashscreen.name;
  static const String signIn = SignInScreen.name;
  static const String forgotPassword = ForgotPass.name;
  static const String signUp = SignUpScreen.name;
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: Routes.splash,
      initialBinding: ControllerBinding(),
      routes: {
        Routes.splash: (context) => const Splashscreen(),
        Routes.signIn: (context) => const SignInScreen(),
        Routes.forgotPassword: (context) => const ForgotPass(),
        Routes.signUp: (context) => const SignUpScreen(),
        MainBottomNavBar.name: (context) => const MainBottomNavBar(),
        AddTaskScreen.name: (context) => const AddTaskScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorSchemeSeed: AppColor.themeColor,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonTheme(),
      ),
      home: const Splashscreen(),
    );
  }

  ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppColor.themeColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
      fillColor: Colors.white,
      filled: true,
      border: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      errorBorder: _outlineInputBorder(),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.indigoAccent.shade200),
    );
  }
}
