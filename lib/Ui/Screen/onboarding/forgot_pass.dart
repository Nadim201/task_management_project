import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_project/Ui/Screen/onboarding/forgot_pass_otp.dart';
import 'package:task_management_project/Ui/Utils/Show_Snack_bar.dart';
import 'package:task_management_project/data/controller/AuthController/forgot_pass_controller.dart';

import '../../../data/common/utils.dart';
import '../../Utils/color.dart';
import '../../Widget/backgroundImage.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  static const String name = '/forgotPassScreen';

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  void dispose() {
    super.dispose();
    _emController.dispose();
  }

  final forgotPassController = Get.find<ForgotPassController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emController = TextEditingController();

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
                // Wrap in Form widget
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Email Address',
                      style: header1(Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'A 6 digits verification OTP will be sent to your email address',
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
          controller: _emController,
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            label: Text('Email'),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.email),
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter your correct email';
            }
            String pattern = r'^[^@]+@[^@]+\.[^@]+$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 30,
        ),
        GetBuilder<ForgotPassController>(builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ElevatedButton(
              onPressed: onTabNextButton,
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
          letterSpacing: 0.5,
        ),
        text: "Have account ",
        children: [
          TextSpan(
            text: "Sign in?",
            style: const TextStyle(color: AppColor.themeColor, fontSize: 14),
            recognizer: TapGestureRecognizer()
              ..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void onTabNextButton() {
    if (_formKey.currentState!.validate()) {
      forgotPass();
    }
  }

  Future<void> forgotPass() async {
    final email = _emController.text;
    String url = "${Utils.forgot}$email";
    final forgotPassController = ForgotPassController();
    bool result = await forgotPassController.forgotPass(url);
    if (result) {
      Get.off(
        ForgotPassOtp(
          email: email,
        ),
      );
    } else {
      CustomSnackbar.showError(
          'Oto Sending Error', message: ForgotPassController.errorMessage);
    }
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }
}
