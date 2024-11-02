import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/task/MainBottomNavBar.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_up_screen.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/Show_Snack_bar.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';
import 'package:task_management_project/data/common/utils.dart';
import 'package:task_management_project/data/model/login_model.dart';
import 'package:task_management_project/data/model/network_response.dart';
import 'package:task_management_project/data/model/user_data.dart';
import 'package:task_management_project/data/services/networkCaller.dart';

import '../../../data/controller/auth_controller.dart';
import 'forgot_pass.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  bool _inProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Backgroundimage(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Start With',
                      style: header1(Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildSignInFormSection(),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _onTapForgatePass,
                            child: const Text(
                              'Forgot password?',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                          buildSignUpSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _emailTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            label: Text('Email'),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.email),
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter your valid email';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _passwordTEController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            label: const Text('Password'),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.visibility_off_outlined),
            ),
            prefixIcon: const Icon(Icons.password),
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter your valid email';
            }
            if (value!.length <= 6) {
              return 'Enter a password 6 more character ';
            }

            return null;
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Visibility(
          visible: !_inProgress,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ElevatedButton(
            onPressed: _OnTabNextButton,
            child: const Icon(Icons.arrow_circle_right),
          ),
        ),
      ],
    );
  }

  Widget buildSignUpSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
        text: "Don't have an account? ",
        children: [
          TextSpan(
              text: "Sign up?",
              style: const TextStyle(color: AppColor.themeColor, fontSize: 14),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp),
          // Pass context to the method
        ],
      ),
    );
  }

  void _OnTabNextButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text
    };
    NetworkResponse response =
        await NetworkCaller().postRequest(url: Utils.login, body: requestBody);
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (builder) => const MainBottomNavBar(),
          ),
          (predicate) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapForgatePass() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPass(),
      ),
    );
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }
}
