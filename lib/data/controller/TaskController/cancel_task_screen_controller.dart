
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_management_project/data/model/network_response.dart';
import 'package:task_management_project/data/model/task_List_model.dart';
import 'package:task_management_project/data/model/task_model.dart';
import 'package:task_management_project/data/services/networkCaller.dart';

import '../../common/utils.dart';


class CancelTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  static String? _errorMessage;
  List<TaskModel> taskList = [];

  static String? get errorMessage => _errorMessage;

  Future<bool> getCancelTaskScreen() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    taskList.clear();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Utils.cancelTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      taskList = taskListModel.taskList ?? [];
      _inProgress = false;
      isSuccess=true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
//