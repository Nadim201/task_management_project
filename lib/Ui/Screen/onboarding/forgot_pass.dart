import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Widget/Show_Snack_bar.dart';

import '../../../data/common/utils.dart';
import '../../../data/model/network_response.dart';
import '../../../data/services/networkCaller.dart';
import '../../Utils/color.dart';
import '../../Widget/backgroundImage.dart';
import 'forgot_pass_otp.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});
  static const String name='/forgotPassScreen';

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emController = TextEditingController();
  bool isLoading = false;

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
        Visibility(
          visible: !isLoading,
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
          letterSpacing: 0.5,
        ),
        text: "Have account ",
        children: [
          TextSpan(
            text: "Sign in?",
            style: const TextStyle(color: AppColor.themeColor, fontSize: 14),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
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
      isLoading = true;
    });

    final emailText = _emController.text.trim();
    String url = "${Utils.forgot}$emailText";

    NetworkResponse response = await NetworkCaller().getRequest(url);

    setState(() {
      isLoading = false;
    });
    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPassOtp(
            email: emailText,
          ),
        ),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }
}
