import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/task/completed_task_screen.dart';
import 'package:task_management_project/Ui/Screen/task/task_screen.dart';
import 'package:task_management_project/Ui/Screen/task/progressing_task_screen.dart';
import 'package:task_management_project/Ui/Widget/custom_appBar.dart';

import 'cancel_task_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  final List<Widget> _screenList = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const CancelTaskScreen(),
    const ProgressingTaskScreen()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.task), label: 'New Task'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed '),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),
          NavigationDestination(
              icon: Icon(Icons.incomplete_circle), label: 'Progressing')
        ],
      ),
      body: _screenList[selectedIndex],
    );
  }
}
