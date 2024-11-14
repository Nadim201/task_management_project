import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_project/Ui/Utils/Show_Snack_bar.dart';

import '../../../data/controller/TaskController/cancel_task_screen_controller.dart';

import '../../Widget/CustomBodyTaskCard.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final CancelTaskController cancelTaskController =
      Get.find<CancelTaskController>();

  @override
  void initState() {
    super.initState();
    getCancelTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelTaskController>(builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const Center(child: CircularProgressIndicator()),
          child: RefreshIndicator(
            onRefresh: () async {
              getCancelTask();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                itemCount: controller.taskList.length,
                itemBuilder: (context, index) {
                  return BodyTaskCardSection(
                    taskModel: controller.taskList[index],
                    onRefreshList: getCancelTask,
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

  Future<void> getCancelTask() async {
    bool result = await cancelTaskController.getCancelTaskScreen();
    if (result == false) {
      CustomSnackbar.showError('Task Cancel Failed',
          message: CancelTaskController.errorMessage);
    }
  }
}
