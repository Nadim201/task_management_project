import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_management_project/Ui/Screen/task/completed_task_screen.dart';
import 'package:task_management_project/Ui/Screen/task/task_screen.dart';
import 'package:task_management_project/Ui/Screen/task/progressing_task_screen.dart';
import 'package:task_management_project/Ui/Widget/custom_appBar.dart';

import '../../../data/controller/TaskController/mainBottom_navBar_controller.dart';
import 'cancel_task_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  static const String name = '/mainBottomNavBar';

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  MainBottomNavBarController controller =
      Get.find<MainBottomNavBarController>();

  final List<Widget> _screenList = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelTaskScreen(),
    const ProgressingTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      bottomNavigationBar: GetBuilder<MainBottomNavBarController>(
        builder: (controller) {
          return NavigationBar(
            selectedIndex: controller.selectedIndex,
            onDestinationSelected: (int index) {
              controller.updateIndex(index);
            },
            destinations: [
              NavigationDestination(icon: Icon(Icons.task), label: 'New Task'),
              NavigationDestination(
                  icon: Icon(Icons.done), label: 'Completed '),
              NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),
              NavigationDestination(
                  icon: Icon(Icons.incomplete_circle), label: 'Progressing')
            ],
          );
        },
      ),
      body: GetBuilder<MainBottomNavBarController>(
        builder: (controller) {
          return _screenList[controller.selectedIndex];
        },
      ),
    );
  }
}
//