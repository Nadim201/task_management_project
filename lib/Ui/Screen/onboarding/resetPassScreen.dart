import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_in.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';

import 'package:task_management_project/data/controller/AuthController/reset_pass_controller.dart';

import '../../Utils/Show_Snack_bar.dart';
import '../../Utils/custom_indicator.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final resetPassScreenController = Get.find<ResetPassController>();
  final TextEditingController _setPassController = TextEditingController();
  final TextEditingController _conPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    _setPassController.dispose();
    _conPassController.dispose();
    super.dispose();
  }

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set Password',
                      style: header1(Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Minimum password length should be 8 characters',
                      style: header4(Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildSignInFormSection(),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: buildSignUpSection(),
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
          controller: _setPassController,
          decoration: const InputDecoration(
            hintText: 'Enter your password',
            label: Text('Password'),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.password),
            suffixIcon: Icon(Icons.visibility_off_outlined),
          ),
          obscureText: true, // Ensure password obscuring
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter a valid password';
            }
            if (value!.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _conPassController,
          decoration: const InputDecoration(
            hintText: 'Confirm your password',
            label: Text('Confirm Password'),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.password),
            suffixIcon: Icon(Icons.visibility_off_outlined),
          ),
          obscureText: true, // Ensure password obscuring
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter a valid password';
            }
            if (value != _setPassController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 30,
        ),
        GetBuilder<ResetPassController>(builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement:  Center(child: CustomIndicator()),
            child: ElevatedButton(
              onPressed: _OnTabNextButton,
              child: const Icon(Icons.arrow_circle_right),
            ),
          );
        }),
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
        text: "Have an account? ",
        children: [
          TextSpan(
              text: "Sign in",
              style: const TextStyle(color: AppColor.themeColor, fontSize: 14),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn),
        ],
      ),
    );
  }

  void _OnTabNextButton() {
    if (_formKey.currentState!.validate()) {
      setPassword();
    }
  }

  Future<void> setPassword() async {
    if (_setPassController.text != _conPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final resetPassScreenController = ResetPassController();
    bool result = await resetPassScreenController.setPassword(
        widget.email, widget.otp, _setPassController.text);
    if (result) {
      Get.off(const SignInScreen());
      _setPassController.clear();
      _conPassController.clear();
    } else {
      CustomSnackbar.showError('Oto Sending Error',
          message: ResetPassController.errorMessage);
    }
  }

  void _onTapSignIn() {
    Get.to(
      SignInScreen(),
    );
  }
}
//