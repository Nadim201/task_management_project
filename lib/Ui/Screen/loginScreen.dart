import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Widget/TextFromFiled.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';
import 'package:task_management_project/Ui/Widget/elevatedButton.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Backgroundimage(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Login Screen',
                    style: textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomTextFormField(
                    hintText: 'Enter your email',
                    label: 'Email',
                    icon: Icons.email,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomTextFormField(
                    hintText: 'Enter your password',
                    label: 'Password',
                    icon: Icons.password,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomElevatedbutton(
                    onPressed: () {},
                    title: 'Submit',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
