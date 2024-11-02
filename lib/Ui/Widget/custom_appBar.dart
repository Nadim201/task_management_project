import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/profile/profileScreen.dart';
import 'package:task_management_project/data/model/user_data.dart';

import '../../data/controller/auth_controller.dart';
import '../Screen/onboarding/sign_in.dart';
import '../Utils/color.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.isProfile = false});

  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfile) {
          return;
        }
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
      },
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.themeColor,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              child: Icon(
                Icons.manage_accounts_rounded,
                size: 40,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName() ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
                Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => const SignInScreen()),
                  (predicate) => false);
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
