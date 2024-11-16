import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_project/Ui/Screen/onboarding/resetPassScreen.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_in.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';

import '../../../data/common/utils.dart';
import '../../../data/controller/AuthController/forgot_pass_otp_controller.dart';
import '../../Utils/Show_Snack_bar.dart';
import '../../Utils/custom_indicator.dart';

class ForgotPassOtp extends StatefulWidget {
  const ForgotPassOtp({super.key, required this.email});

  static const String name = '/forgotOtpScreen';
  final String email;

  @override
  State<ForgotPassOtp> createState() => _ForgotPassOtpState();
}

class _ForgotPassOtpState extends State<ForgotPassOtp> {
  final forgotPassOtpController = Get.find<ForgotPassOtpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    print('Disposing ForgotPassOtp');
    _pinController.dispose();
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
                      'Pin Verification',
                      style: header1(Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        'A 6 digits verification otp has been sent to your email address',
                        style: header4(Colors.grey)),
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
        PinCodeTextField(
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter Valid pin';
            }
            if (value!.length < 6) {
              return 'Pin must be at least 6 digits';
            }

            return null;
          },
          controller: _pinController,
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              activeColor: AppColor.themeColor,
              selectedFillColor: Colors.white),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(
          height: 30,
        ),
        GetBuilder<ForgotPassOtpController>(builder: (controller) {
          return Visibility(
            visible: !controller.inProgress,
            replacement:  Center(child: CustomIndicator()),
            child: ElevatedButton(
              onPressed: _OnTabNextButton,
              child: const Text('Verify'),
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
        text: "Have account ",
        children: [
          TextSpan(
              text: "Sign in?",
              style: const TextStyle(color: AppColor.themeColor, fontSize: 14),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn),
        ],
      ),
    );
  }

  void _OnTabNextButton() {
    if (_formKey.currentState!.validate()) {
      if (mounted) {
        forgotPass();
      }
    }
  }

  Future<void> forgotPass() async {
    final otp = _pinController.text;
    final email = widget.email;
    String url = "${Utils.pin}${widget.email}/$otp";
    final forgotPassOtpController = ForgotPassOtpController();
    bool result = await forgotPassOtpController.forgotPass(url);
    if (result) {
      Get.off(
        ResetPassScreen(
          email: email,
          otp: otp,
        ),
      );
    } else {
      CustomSnackbar.showError(
          'Oto Sending Error', message: ForgotPassOtpController.errorMessage);
    }
  }

  void _onTapSignIn() {
    Get.to(SignInScreen);
  }
}
//