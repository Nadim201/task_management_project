import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_project/Ui/Screen/onboarding/resetPassScreen.dart';
import 'package:task_management_project/Ui/Screen/onboarding/sign_in.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';

import '../../../data/common/utils.dart';
import '../../../data/model/network_response.dart';
import '../../../data/services/networkCaller.dart';
import '../../Widget/Show_Snack_bar.dart';

class ForgotPassOtp extends StatefulWidget {
  const ForgotPassOtp({super.key, required this.email});

  final String email;

  @override
  State<ForgotPassOtp> createState() => _ForgotPassOtpState();
}

class _ForgotPassOtpState extends State<ForgotPassOtp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinController = TextEditingController();

  late bool _isLoading = false;

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
        Visibility(
          visible: !_isLoading,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ElevatedButton(
            onPressed: _OnTabNextButton,
            child: const Text('Verify'),
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
      forgotPass();
    }
  }

  Future<void> forgotPass() async {
    setState(() {
      _isLoading = true;
    });

    final otp = _pinController.text;
    final email = widget.email;
    print('check pintext value: $otp');
    String url = "${Utils.pin}${widget.email}/$otp";

    NetworkResponse response = await NetworkCaller().getRequest(url);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (response.isSuccess) {
      showSnackBarMessage(context, response.responseData['data']);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassScreen(email: email, otp: otp),
        ),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }
}
