import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_project/data/controller/TaskController/ProgressingTaskController.dart';

import '../../Utils/Show_Snack_bar.dart';
import '../../Utils/custom_indicator.dart';
import '../../Widget/CustomBodyTaskCard.dart';

class ProgressingTaskScreen extends StatefulWidget {
  const ProgressingTaskScreen({super.key});

  @override
  State<ProgressingTaskScreen> createState() => _ProgressingTaskScreenState();
}

class _ProgressingTaskScreenState extends State<ProgressingTaskScreen> {
  final ProgressingTaskController progressingTaskController =
      Get.find<ProgressingTaskController>();

  @override
  void initState() {
    super.initState();
    getProgressingTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProgressingTaskController>(builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: Center(child: CustomIndicator()),
          child: RefreshIndicator(
            onRefresh: () async {
              getProgressingTask();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                itemCount: controller.taskList.length,
                itemBuilder: (context, index) {
                  return BodyTaskCardSection(
                    taskModel: controller.taskList[index],
                    onRefreshList: getProgressingTask,
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
      }),
    );
  }

  Future<void> getProgressingTask() async {
    bool result = await progressingTaskController.getProgressingTaskScreen();
    if (result == false) {
      CustomSnackbar.showError('Something went wrong',
          message: ProgressingTaskController.errorMessage);
    }
  }
}
//