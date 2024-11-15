import 'package:get/get.dart';

import '../../common/utils.dart';
import '../../model/login_model.dart';
import '../../model/network_response.dart';
import '../../services/networkCaller.dart';
import '../auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  static String? _errorMessage;

 static String? get errorMessage => _errorMessage;



  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    NetworkResponse response =
        await NetworkCaller().postRequest(url: Utils.login, body: requestBody);
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
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