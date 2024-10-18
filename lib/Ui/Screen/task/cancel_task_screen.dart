import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_management_project/Ui/Widget/Show_Snack_bar.dart';
import 'package:task_management_project/data/common/utils.dart';
import 'package:task_management_project/data/model/network_response.dart';
import 'package:task_management_project/data/model/task_List_model.dart';
import 'package:task_management_project/data/services/networkCaller.dart';

import '../../../data/model/task_model.dart';
import '../../Widget/CustomBodyTaskCard.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool isLoading = false;
  List<TaskModel> taskList = [];

  @override
  void initState() {
    super.initState();
    getCancelTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: !isLoading,
        replacement: const Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: () async {
            getCancelTask();
          },
          child: ListView.separated(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return BodyTaskCardSection(
                taskModel: taskList[index],
                deleteId: () {
                  taskList.removeAt(index);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getCancelTask() async {
    isLoading = true;
    setState(() {});
    taskList.clear();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Utils.cancelTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);

      taskList = taskListModel.taskList ?? [];

      isLoading = false;
      setState(() {});
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
