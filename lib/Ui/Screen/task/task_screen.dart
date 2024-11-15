import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_project/Ui/Screen/task/add_task_screen.dart';
import 'package:task_management_project/Ui/Utils/Show_Snack_bar.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/CustomBodyTaskCard.dart';
import 'package:task_management_project/Ui/Widget/task_summary_card.dart';
import 'package:task_management_project/data/controller/TaskController/counter_status_controller.dart';

import '../../../data/controller/TaskController/task_screen_controller.dart';

import '../../../data/model/task_counter_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  // late final StatusModel statusModel;
  TaskListController taskScreenController = Get.find<TaskListController>();
  TaskCounterController taskCounterController =
      Get.find<TaskCounterController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNewTaskScreen();
      getStatusCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await getNewTaskScreen();
            await getStatusCounter();
          },
          child: Column(
            children: [
              buildSummarySection(),
              Expanded(
                child: GetBuilder<TaskListController>(builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ListView.separated(
                      itemCount: controller.taskList.length,
                      itemBuilder: (context, index) {
                        return BodyTaskCardSection(
                          onRefreshList: (){
                            getNewTaskScreen();
                            getStatusCounter();
                          },
                          taskModel: controller.taskList[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.themeColor,
          onPressed: _onTabAddTask,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Padding buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<TaskCounterController>(builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement:
              const Center(child: Center(child: CircularProgressIndicator())),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.taskCounterList
                  .map(
                    (task) => TaskSummaryCard(
                      title: task.sId!,
                      counter: task.sum ?? 0,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }),
    );
  }

  //Using ListViewBuilder
  // Padding buildSummarySection() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8),
  //     child: Visibility(
  //       child: SizedBox(
  //         height: 100,
  //         child: ListView.builder(
  //           itemCount: _statusTaskCounterList.length,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, index) {
  //             final StatusModel task = _statusTaskCounterList[index];
  //             return TaskSummaryCard(title: task.sId!, counter: task.sum ?? 0);
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //Using For in loop
  // Padding buildSummarySection() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Visibility(
  //       visible: !TaskCounterListProgressing,
  //       replacement: const Center(child: CircularProgressIndicator()),
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: _getTaskSummaryCardList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // List<TaskSummaryCard> _getTaskSummaryCardList() {
  //   List<TaskSummaryCard> taskSummaryCard = [];
  //   for (StatusModel task in _statusTaskCounterList) {
  //     taskSummaryCard
  //         .add(TaskSummaryCard(title: task.sId!, counter: task.sum ?? 0));
  //   }
  //   return taskSummaryCard;
  // }

  Future<void> _onTabAddTask() async {
    final bool shouldRefresh = await Get.toNamed(
      AddTaskScreen.name,
    );
    if (shouldRefresh == true) {
      await getNewTaskScreen();
      await getStatusCounter();
    }
  }

  Future<void> getNewTaskScreen() async {
    final bool result = await taskScreenController.getNewTaskScreen();
    if (!result) {
      CustomSnackbar.showError('TaskList In Error',
          message: taskCounterController
              .errorMessage); // Use taskScreenController's errorMessage
    }
  }

  Future<void> getStatusCounter() async {
    final bool result = await taskCounterController.getStatusCounter();
    if (result == false) {
      CustomSnackbar.showError('TaskCounterList In Error',
          message: taskCounterController
              .errorMessage); // Use taskCounterController's errorMessage
    }
  }
}



