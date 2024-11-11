import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/controller/compeleted_task_controller.dart';
import '../../Widget/CustomBodyTaskCard.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    getNewTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskController>(builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const Center(child: CircularProgressIndicator()),
          child: RefreshIndicator(
            onRefresh: () async {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                itemCount: controller.taskList.length,
                itemBuilder: (context, index) {
                  return BodyTaskCardSection(
                    taskModel: controller.taskList[index],
                    onRefreshList: getNewTaskScreen,
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

  Future<void> getNewTaskScreen() async {
    bool result = await completedTaskController.getCompletedTaskScreen();
    if (result == false) {
      Get.snackbar(
          'Something went wrong',
          CompletedTaskController.errorMessage ??
              'An unexpected error occurred.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.indigoAccent,
          colorText: Colors.white);
    }
  }
}
