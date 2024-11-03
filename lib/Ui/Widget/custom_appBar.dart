import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/profile/profileScreen.dart';

import '../../data/controller/auth_controller.dart';
import '../Screen/onboarding/sign_in.dart';
import '../Utils/color.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final bool isProfile;

  const CustomAppbar({super.key, this.isProfile = false});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  String? fullName;
  String? email;
  String? photo;

  void _loadUserData() {
    setState(() {
      fullName = AuthController.userData?.fullName;
      email = AuthController.userData?.email;
      photo = AuthController.userData?.photo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isProfile) {
          return;
        }
        Navigator.push(
          context, // in this section what to do i do not understand
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        ).then((_) => _loadUserData());
      },
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor.themeColor,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: CircleAvatar(
                backgroundImage: AuthController.userData?.photo != null
                    ? MemoryImage(
                        base64Decode(
                          AuthController.userData!.photo!,
                        ),
                      )
                    : const AssetImage('assets/images/pexels-photo-771742.jpg'),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName! ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
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
                (predicate) => false,
              );
            },
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
