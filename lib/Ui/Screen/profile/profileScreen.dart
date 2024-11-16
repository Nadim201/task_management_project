import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_project/Ui/Utils/custom_toaste_message.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';
import 'package:task_management_project/Ui/Widget/custom_appBar.dart';

import 'package:task_management_project/data/controller/auth_controller.dart';
import 'package:task_management_project/data/controller/profile/profile_screen_controller.dart';

import '../../Utils/color.dart';
import '../../Utils/custom_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emTEController = TextEditingController();
  final TextEditingController _firstTEController = TextEditingController();
  final TextEditingController _lastTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final controller = Get.find<ProfileScreenController>();

  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    final userData = AuthController.userData;
    _emTEController.text = userData?.email ?? '';
    _firstTEController.text = userData?.firstName ?? '';
    _lastTEController.text = userData?.lastName ?? '';
    _mobileTEController.text = userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.themeColor,
        title: Text('Update Profile'),
      ),
      body: Backgroundimage(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPhotoSection(),
                  const SizedBox(height: 24),
                  Text('Get Started With', style: header1(Colors.black)),
                  const SizedBox(height: 16),
                  buildFormFields(),
                  const SizedBox(height: 16),
                  buildUpdateButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildFormFields() {
    return Column(
      children: [
        TextFormField(
          enabled: false,
          controller: _emTEController,
          decoration: const InputDecoration(
            hintText: 'Email',
            label: Text('Email'),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _firstTEController,
          decoration: const InputDecoration(
            hintText: 'First Name',
            label: Text('Name'),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Enter a valid Name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _lastTEController,
          decoration: const InputDecoration(
            hintText: 'Last Name',
            label: Text('Name'),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Enter a valid name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _mobileTEController,
          decoration: const InputDecoration(
            hintText: 'Mobile',
            label: Text('Number'),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Enter a valid number';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passTEController,
          decoration: const InputDecoration(
            hintText: 'Password',
            label: Text('Password'),
          ),
        ),
      ],
    );
  }

  buildUpdateButton() {
    return GetBuilder<ProfileScreenController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: Center(child: CustomIndicator()),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              updateProfile();
            }
          },
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      );
    });
  }

  GestureDetector buildPhotoSection() {
    return GestureDetector(
      onTap: pickImage,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFA3C6FF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: CircleAvatar(
                backgroundImage: selectedImage != null
                    ? FileImage(File(selectedImage!.path))
                    : AuthController.userData?.photo != null
                        ? MemoryImage(
                            base64Decode(AuthController.userData!.photo!))
                        : const AssetImage(
                                'assets/images/pexels-photo-771742.jpg')
                            as ImageProvider,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColor.themeColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      setState(() {
        selectedImage = pickImage;
      });
    }
  }

  Future<void> updateProfile() async {
    final bool result = await controller.updateProfile(
        email: _emTEController.text,
        firstName: _firstTEController.text,
        lastName: _lastTEController.text,
        mobile: _mobileTEController.text,
        photo: AuthController.userData?.photo,
        selectedImage: selectedImage,
        password: _passTEController.text);

    if (result) {
      ToastMessage.showToast('Update success');
    } else {
      ToastMessage.errorToast('Update fail');
    }
  }
}
//
