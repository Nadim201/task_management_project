import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/task/add_task_screen.dart';
import 'package:task_management_project/Ui/Utils/color.dart';
import 'package:task_management_project/Ui/Widget/CustomBodyTaskCard.dart';
import 'package:task_management_project/Ui/Widget/task_summary_card.dart';
import 'package:task_management_project/data/model/task_List_model.dart';

import '../../../data/common/utils.dart';
import '../../../data/model/network_response.dart';
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
  List<TaskModel> taskList = [];

  late final TaskModel taskModel;

  @override
  void initState() {
    super.initState();
    getNewTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          getNewTaskScreen();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: totalCounterTaskSection(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Visibility(
                visible: !isLoading,
                replacement: const Center(child: CircularProgressIndicator()),
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
    );
  }

  Widget totalCounterTaskSection() {
    return const Row(
      children: [
        TaskSummaryCard(
          title: 'Completed',
          counter: 08,
        ),
        TaskSummaryCard(
          title: 'Completed',
          counter: 03,
        ),
        TaskSummaryCard(
          title: 'Completed',
          counter: 04,
        ),
        TaskSummaryCard(
          title: 'Completed',
          counter: 09,
        ),
      ],
    );
  }

  void _onTabAddTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) => const AddTaskScreen()),
    );
  }

  void onTaskDelete(int index) {
    setState(() {
      getNewTaskScreen();
    });
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
      isLoading = false;
      setState(() {});
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
