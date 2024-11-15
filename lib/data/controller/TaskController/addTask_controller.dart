import 'package:get/get.dart';
import 'package:task_management_project/data/common/utils.dart';
import 'package:task_management_project/data/model/network_response.dart';
import 'package:task_management_project/data/services/networkCaller.dart';



class AddTaskScreenController extends GetxController {
  late bool _inProgress = false;


  bool get inProgress => _inProgress;
  static String? _errorMessage;

  static String? get errorMessage => _errorMessage;

  Future<bool> addTaskNow(String title, String description, String status) async {
    bool isSuccess=false;
    _inProgress = true;
    update();
    Map<String, dynamic> bodyRequest = {
      "title": title,
      "description": description,
      "status": status
    };

    final NetworkResponse response = await NetworkCaller().postRequest(
      url: Utils.addTask,
      body: bodyRequest,
    );
    _inProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess=true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
//