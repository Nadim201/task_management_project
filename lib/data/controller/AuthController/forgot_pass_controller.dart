import 'package:get/get.dart';

import '../../model/network_response.dart';
import '../../services/networkCaller.dart';

class ForgotPassController extends GetxController {
  late bool _inProgress = false;

  bool get inProgress => _inProgress;
  static String? _errorMessage;

  static String? get errorMessage => _errorMessage;

  Future<bool> forgotPass(String url) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().getRequest(url);

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