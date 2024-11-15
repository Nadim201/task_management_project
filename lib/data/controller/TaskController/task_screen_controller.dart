import 'package:get/get.dart';
import 'package:task_management_project/data/common/utils.dart';
import 'package:task_management_project/data/model/network_response.dart';
import 'package:task_management_project/data/model/task_List_model.dart';
import 'package:task_management_project/data/model/task_model.dart';
import 'package:task_management_project/data/services/networkCaller.dart';

class TaskListController extends GetxController {
  late bool _inProgress = false;


  bool get inProgress => _inProgress;
  static String? _errorMessage;
  late List<TaskModel> _taskList = [];

  List<TaskModel> get taskList => _taskList;


  static String? get errorMessage => _errorMessage;

  Future<bool> getNewTaskScreen() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    _taskList.clear();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Utils.newTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
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