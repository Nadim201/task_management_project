import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/task/add_task_screen.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/CustomBodyTaskCard.dart';
import 'package:task_management_project/Ui/Widget/task_summary_card.dart';
import 'package:task_management_project/data/model/task_List_model.dart';

import '../../../data/common/utils.dart';
import '../../../data/model/network_response.dart';
import '../../../data/model/task_counter_list_model.dart';
import '../../../data/model/task_counter_model.dart';
import '../../../data/model/task_model.dart';
import '../../../data/services/networkCaller.dart';
import '../../Widget/Show_Snack_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool isLoading = false;
  bool taskCounterStatusProgressing = false;
  List<TaskModel> taskList = [];
  List<StatusModel> _statusTaskCounterList = [];

  late final TaskModel taskModel;
  late final StatusModel statusModel;

  @override
  void initState() {
    super.initState();
    getNewTaskScreen();
    getStatusCounter();
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
                child: Visibility(
                  visible: !isLoading,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.separated(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return BodyTaskCardSection(
                        taskModel: taskList[index],
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
      child: Visibility(
        visible: !taskCounterStatusProgressing,
        replacement:
            const Center(child: Center(child: CircularProgressIndicator())),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: _statusTaskCounterList
                  .map((task) =>
                      TaskSummaryCard(title: task.sId!, counter: task.sum ?? 0))
                  .toList()),
        ),
      ),
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
    final bool shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) => const AddTaskScreen()),
    );
    if (shouldRefresh == true) {
      getNewTaskScreen();
      getStatusCounter();
    }
  }

  Future<void> getNewTaskScreen() async {
    isLoading = true;
    setState(() {});
    taskList.clear();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Utils.newTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      taskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> getStatusCounter() async {
    taskCounterStatusProgressing = true;
    setState(() {});
    _statusTaskCounterList.clear();
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Utils.taskStatusCount); // Use a different API if needed

    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _statusTaskCounterList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    taskCounterStatusProgressing = false;
    setState(() {});
  }
}
