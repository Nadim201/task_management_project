import 'package:flutter/material.dart';

import '../../../data/common/utils.dart';
import '../../../data/model/network_response.dart';
import '../../../data/model/task_List_model.dart';
import '../../../data/model/task_model.dart';
import '../../../data/services/networkCaller.dart';
import '../../Widget/CustomBodyTaskCard.dart';
import '../../Widget/Show_Snack_bar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool isLoading = false;
  List<TaskModel> taskList = [];

  @override
  void initState() {
    super.initState();
    getNewTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: !isLoading,
        replacement: const Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: () async {},
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

  Future<void> getNewTaskScreen() async {
    isLoading = true;
    setState(() {});
    taskList.clear();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Utils.completedTaskList);

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
