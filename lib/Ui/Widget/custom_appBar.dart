import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/profile/profileScreen.dart';

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
        title: const Row(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.manage_accounts_rounded,
                size: 40,
              ),
              radius: 20,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nadim Mahmud',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
                Text(
                  'flutterrun1@gmail.com',
                  style: TextStyle(
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
