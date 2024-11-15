import 'package:get/get.dart';

import '../../common/utils.dart';
import '../../model/network_response.dart';
import '../../services/networkCaller.dart';

class UpdateTaskController extends GetxController {
  bool isSuccess = false;
  late bool _inProgress = false;

  bool get inProgress => _inProgress;
  static String? _errorMessage;

  static String? get errorMessage => _errorMessage;

  Future<bool> updateTask(String url) async {
    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(url);

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