import 'package:flutter/material.dart';
import 'package:task_management_project/Ui/Screen/splashScreen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const Splashscreen(),
    );
  }
}
