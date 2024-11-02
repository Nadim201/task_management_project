import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_project/Ui/Widget/Show_Snack_bar.dart';
import 'package:task_management_project/Ui/Widget/backgroundImage.dart';
import 'package:task_management_project/Ui/Widget/custom_appBar.dart';
import 'package:task_management_project/data/common/utils.dart';
import 'package:task_management_project/data/controller/auth_controller.dart';
import 'package:task_management_project/data/model/network_response.dart';
import 'package:task_management_project/data/model/user_data.dart';
import 'package:task_management_project/data/services/networkCaller.dart';

import '../../Utils/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  final TextEditingController _emTEController = TextEditingController();
  final TextEditingController _firstTEController = TextEditingController();
  final TextEditingController _lastTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool updateProfileProgress = false;
  XFile? selectedImage;

  void setData() {
    _emTEController.text = AuthController.userData?.email ?? '';
    _firstTEController.text = AuthController.userData?.firstName ?? '';
    _lastTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        isProfile: true,
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
                Text(
                  'Get Start With',
                  style: header1(Colors.black),
                ),
                const SizedBox(
                  height: 16,
                ),
                buildPhotoSection(),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    TextFormField(
                      enabled: false,
                      controller: _emTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        label: Text('Email'),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                        label: Text('Name'),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                        label: Text('Name'),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                        label: Text('Number'),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        label: Text('Password'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: !updateProfileProgress,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateProfile();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  GestureDetector buildPhotoSection() {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 100,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: const Text(
                'Photo',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              selectedPhotoTitle(),
              style: const TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String selectedPhotoTitle() {
    if (selectedImage != null) {
      return selectedImage!.name;
    }
    return 'Select Photo';
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      selectedImage = pickImage;
      setState(() {});
    }
  }

  Future<void> updateProfile() async {
    updateProfileProgress = true;
    setState(() {});

    final Map<String, dynamic> reqBody = {
      "email": _emTEController.text.trim(),
      "firstName": _firstTEController.text.trim(),
      "lastName": _lastTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if (_passTEController.text.isNotEmpty) {
      reqBody['password'] = _passTEController.text;
    }
    if (selectedImage != null) {
      List<int> imageByte = await selectedImage!.readAsBytes();
      String convertImage = base64Encode(imageByte);
      reqBody['photo'] = convertImage;
    }
    final NetworkResponse response = await NetworkCaller()
        .postRequest(url: Utils.updateProfile, body: reqBody);

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(reqBody);
      AuthController.saveUserData(userModel);
      showSnackBarMessage(context, 'Profile has been updated');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    updateProfileProgress = false;
    setState(() {});
  }
}
