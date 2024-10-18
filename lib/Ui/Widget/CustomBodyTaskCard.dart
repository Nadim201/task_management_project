import 'package:flutter/material.dart';
import 'package:task_management_project/data/services/networkCaller.dart';

import '../../data/common/utils.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_model.dart';
import '../Utils/color.dart';
import 'Show_Snack_bar.dart';

class BodyTaskCardSection extends StatefulWidget {
  const BodyTaskCardSection({
    super.key,
    required this.taskModel,
    required this.deleteId,
  });

  final TaskModel taskModel;
  final VoidCallback deleteId;

  @override
  State<BodyTaskCardSection> createState() => _BodyTaskCardSectionState();
}

class _BodyTaskCardSectionState extends State<BodyTaskCardSection> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ${widget.taskModel.title}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                ' ${widget.taskModel.description}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                ' ${widget.taskModel.createdDate}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    side: BorderSide.none,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    backgroundColor: AppColor.themeColor,
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    label: Text(widget.taskModel.status.toString()),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => onTabEdit(context),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          await onTabDelete();
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTabDelete() async {
    await deleteTask(widget.taskModel.sId.toString());
    widget.deleteId();
  }

  Future<void> deleteTask(String id) async {
    isLoading = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller().getRequest(Utils.deleteTask + id);

    isLoading = false;
    setState(() {});

    if (response.isSuccess) {
      showSnackBarMessage(context, 'Item deleted');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void onTabEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                ['New', 'Complete', 'Cancel', 'Progressing'].map((status) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  updateTaskStatus(widget.taskModel.sId.toString(), status);
                },
                title: Text(status),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    setState(() {
      isLoading = true;
    });

    final String url = '${Utils.baseUrl}/updateTaskStatus/$taskId/$newStatus';

    final NetworkResponse response = await NetworkCaller().getRequest(url);

    setState(() {
      isLoading = false;
    });

    if (response.isSuccess) {
      showSnackBarMessage(context, 'Task status updated to $newStatus');
      setState(() {
        widget.taskModel.status = newStatus;
      });
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
