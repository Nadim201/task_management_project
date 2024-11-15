import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/utils.dart';
import '../../model/network_response.dart';
import '../../model/user_data.dart';
import '../../services/networkCaller.dart';
import '../auth_controller.dart';

class ProfileScreenController extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;
  static String? _errorMessage;

  static String? get errorMessage => _errorMessage;
  bool isSuccess = false;

  Future<bool> updateProfile(
      {required String email,
      required String firstName,
      required String lastName,
      required String mobile,
      String? photo,
      XFile? selectedImage,
      String? password}) async {
    _inProgress = true;
    update();

    final Map<String, dynamic> reqBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
    };

    if (password != null) {
      reqBody['password'] = password;
    }

    if (selectedImage != null) {
      List<int> imageByte = await selectedImage.readAsBytes();
      String convertImage = base64Encode(imageByte);
      reqBody['photo'] = convertImage;
    }

    final NetworkResponse response = await NetworkCaller()
        .postRequest(url: Utils.updateProfile, body: reqBody);

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(reqBody);
      AuthController.saveUserData(userModel);
      debugPrint("Base64 Image: ${AuthController.userData!.photo}");
      isSuccess = true;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
//