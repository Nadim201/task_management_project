import 'package:get/get.dart';

import '../../common/utils.dart';
import '../../model/network_response.dart';
import '../../services/networkCaller.dart';

class SignUpController extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;
  static String? _errorMessage;

  static String? get errorMessage => _errorMessage;

  Future<bool> signUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> bodyRequest = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    NetworkResponse response = await NetworkCaller()
        .postRequest(url: Utils.registration, body: bodyRequest);

    _inProgress = false;
    update();
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
