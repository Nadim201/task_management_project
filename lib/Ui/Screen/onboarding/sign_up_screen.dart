import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_in.dart';
import 'package:task_management_project/data/controller/AuthController/signIn_controller.dart';
import 'package:task_management_project/data/controller/AuthController/signup_controller.dart';

import '../../Utils/color.dart';
import '../../Utils/custom_indicator.dart';
import '../../Widget/backgroundImage.dart';
import '../../Widget/show_snackBar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignInController signInController = Get.find<SignInController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTeController = TextEditingController();
  final TextEditingController _firstNameTeController = TextEditingController();
  final TextEditingController _lastNameTeController = TextEditingController();
  final TextEditingController _numberTeController = TextEditingController();
  final TextEditingController _passTeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Backgroundimage(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join With Us...',
                    style: header1(Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildSignInFormSection(),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: buildHaveAccountSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInFormSection() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTeController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              label: Text('Email'),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.email),
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _firstNameTeController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your first name',
              label: Text('First Name'),
              fillColor: Colors.white,
              filled: true,
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _lastNameTeController,
            decoration: const InputDecoration(
              hintText: 'Enter your last name',
              label: Text('Last Name'),
              fillColor: Colors.white,
              filled: true,
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _numberTeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter your number',
              label: Text('Number'),
              fillColor: Colors.white,
              filled: true,
            ),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter your number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passTeController,
            obscureText: true,
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
                return 'Enter your password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          GetBuilder<SignUpController>(builder: (controller) {
            return Visibility(
              visible: !controller.inProgress,
              replacement: const  Center(child: CustomIndicator()),
              child: ElevatedButton(
                onPressed: _OnTabNextButton,
                child: const Icon(Icons.arrow_circle_right),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
        text: "Have account? ",
        children: [
          TextSpan(
              text: "Sign in?",
              style: const TextStyle(color: AppColor.themeColor, fontSize: 14),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn),
          // Pass context to the method
        ],
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }

  Future<void> _OnTabNextButton() async {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    final signUpController = SignUpController();
    final bool result = await signUpController.signUp(
        _emailTeController.text,
        _firstNameTeController.text,
        _lastNameTeController.text,
        _numberTeController.text,
        _passTeController.text);

    if (result) {
      _clear();
      Get.offAllNamed(SignInScreen.name);
    } else {
      CustomSnackbar.showError(
          'Oto Sending Error', message: SignUpController.errorMessage);
    }
  }

  void _clear() {
    _emailTeController.clear();
    _firstNameTeController.clear();
    _lastNameTeController.clear();
    _numberTeController.clear();
    _passTeController.clear();
  }
}
//