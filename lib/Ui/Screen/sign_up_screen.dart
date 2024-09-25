import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/sign_in.dart';

import '../Utils/color.dart';
import '../Widget/backgroundImage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 28),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildSignInFormSection(),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: buildHaveAccountSection(),
                ),
              ],
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
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            label: Text('Email'),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Enter your first name',
            label: Text('First Name'),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your last name',
            label: Text('Last Name'),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter your number',
            label: Text('Number'),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
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
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: _OnTabNextButton,
          child: const Icon(Icons.arrow_circle_right),
        ),
      ],
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

  void _OnTabNextButton() {
    //Todo:implement ontab next button
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }
}
