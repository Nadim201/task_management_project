import 'package:get/get.dart';
import 'package:task_management_project/data/model/task_List_model.dart';
import 'package:task_management_project/data/model/task_model.dart';
import '../../common/utils.dart';
import '../../model/network_response.dart';
import '../../services/networkCaller.dart';

class CompletedTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  static String? _errorMessage;
  List<TaskModel> taskList = [];

  static String? get errorMessage => _errorMessage;

  Future<bool> getCompletedTaskScreen() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    taskList.clear();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Utils.completedTaskList);

    if (response.isSuccess) {
      isSuccess = true;
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);

      taskList = taskListModel.taskList ?? [];
      _inProgress = false;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
//