import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../common/utils.dart';
import '../../model/network_response.dart';
import '../../model/task_counter_list_model.dart';
import '../../model/task_counter_model.dart';
import '../../services/networkCaller.dart';

class TaskCounterController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<StatusModel> _taskCounterList = [];

  bool get inProgress => _inProgress;
  List<StatusModel> get taskCounterList => _taskCounterList;
  String? get errorMessage => _errorMessage;

  Future<bool> getStatusCounter() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    _taskCounterList.clear();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Utils.taskStatusCount);

    if (response.isSuccess) {

      final TaskStatusCountModel taskStatusCountModel =
      TaskStatusCountModel.fromJson(response.responseData);
      _taskCounterList = taskStatusCountModel.taskStatusCountList ?? [];
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
//