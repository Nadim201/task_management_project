import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Widget/Show_Snack_bar.dart';
import 'package:task_management_project/data/common/utils.dart';
import 'package:task_management_project/data/model/network_response.dart';
import 'package:task_management_project/data/model/task_List_model.dart';
import 'package:task_management_project/data/model/task_model.dart';
import 'package:task_management_project/data/services/networkCaller.dart';

import '../../Widget/CustomBodyTaskCard.dart';

class ProgressingTaskScreen extends StatefulWidget {
  const ProgressingTaskScreen({super.key});

  @override
  State<ProgressingTaskScreen> createState() => _ProgressingTaskScreenState();
}

class _ProgressingTaskScreenState extends State<ProgressingTaskScreen> {
  bool isLoading = false;
  List<TaskModel> taskList = [];

  @override
  void initState() {
    super.initState();
    getProgressingTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: !isLoading,
        replacement: const Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: () async {
            getProgressingTask();
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

  Future<void> getProgressingTask() async {
    isLoading = true;
    setState(() {});
    taskList.clear();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Utils.progressingTaskList);

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
