import 'package:get/get.dart';

import '../../common/utils.dart';
import '../../model/network_response.dart';
import '../../services/networkCaller.dart';

class ResetPassController extends GetxController {
  bool isSuccess = false;
  late bool _inProgress = false;

  bool get inProgress => _inProgress;
  static String? _errorMessage;

  static String? get errorMessage => _errorMessage;

  Future<bool> setPassword(String email, String otp, String pass) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": pass,
    };

    NetworkResponse response = await NetworkCaller().postRequest(
      url: Utils.reset,
      body: requestBody,
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
//