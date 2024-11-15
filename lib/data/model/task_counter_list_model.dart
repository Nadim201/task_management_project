import 'package:task_management_project/data/model/task_counter_model.dart';

class TaskStatusCountModel {
  String? status;
  List<StatusModel>? taskStatusCountList;

  TaskStatusCountModel({this.status, this.taskStatusCountList});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountList = <StatusModel>[];
      json['data'].forEach((v) {
        taskStatusCountList!.add(StatusModel.fromJson(v));
      });
    }
  }
}
//