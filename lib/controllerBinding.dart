import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_management_project/data/controller/AuthController/forgot_pass_controller.dart';
import 'package:task_management_project/data/controller/AuthController/forgot_pass_otp_controller.dart';
import 'package:task_management_project/data/controller/AuthController/reset_pass_controller.dart';
import 'package:task_management_project/data/controller/AuthController/signIn_controller.dart';
import 'package:task_management_project/data/controller/AuthController/signup_controller.dart';

import 'package:task_management_project/data/controller/TaskController/ProgressingTaskController.dart';
import 'package:task_management_project/data/controller/TaskController/addTask_controller.dart';
import 'package:task_management_project/data/controller/TaskController/cancel_task_screen_controller.dart';
import 'package:task_management_project/data/controller/TaskController/compeleted_task_controller.dart';
import 'package:task_management_project/data/controller/TaskController/counter_status_controller.dart';
import 'package:task_management_project/data/controller/TaskController/delete-task_controller.dart';
import 'package:task_management_project/data/controller/TaskController/mainBottom_navBar_controller.dart';
import 'package:task_management_project/data/controller/TaskController/task_screen_controller.dart';
import 'package:task_management_project/data/controller/TaskController/update_task_controller.dart';
import 'package:task_management_project/data/controller/profile/profile_screen_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(TaskListController());
    Get.put(AddTaskScreenController());
    Get.put(CompletedTaskController());
    Get.put(CancelTaskController());
    Get.put(ProgressingTaskController());
    Get.put(MainBottomNavBarController());
    Get.put(SignUpController());
    Get.put(ForgotPassController());
    Get.put(ForgotPassOtpController());
    Get.put(ResetPassController());
    Get.put(DeleteTaskController());
    Get.put(UpdateTaskController());
    Get.put(TaskCounterController());
    Get.put(ProfileScreenController());
  }
}
//