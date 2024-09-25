import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/sign_up_screen.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Backgroundimage(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Get Start With',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
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
    //Todo:implement ontab next button
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
