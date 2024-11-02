import 'package:flutter/material.dart';
import 'package:task_management_project/data/services/networkCaller.dart';
import '../../data/common/utils.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_model.dart';
import '../Utils/color.dart';
import 'Show_Snack_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

class BodyTaskCardSection extends StatefulWidget {
  const BodyTaskCardSection({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<BodyTaskCardSection> createState() => _BodyTaskCardSectionState();
}

class _BodyTaskCardSectionState extends State<BodyTaskCardSection> {
  String selectedStatus = '';
  bool deleteRefreshTask = false;
  bool updateRefreshTask = false;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Card(
        elevation: 1,
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
                '${widget.taskModel.title}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              ReadMoreText(
                '${widget.taskModel.description},',
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.indigoAccent.shade100),
                moreStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              // Text(
              //   ' ${widget.taskModel.description}',
              //   style: const TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.grey),
              // ),
              const SizedBox(height: 8),
              Text(
                DateFormat('MMM d, yyyy, hh:mm a').format(DateTime.tryParse(widget.taskModel.createdDate ?? '') ?? DateTime.now()),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: BorderSide.none,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    backgroundColor: AppColor.themeColor,
                    labelStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    label: Text(widget.taskModel.status.toString()),
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: !updateRefreshTask,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: IconButton(
                          onPressed: () => onTabEdit(context),
                          icon: const Icon(
                            Icons.edit_note,
                            color: AppColor.themeColor,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !deleteRefreshTask,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: IconButton(
                          onPressed: deleteTask,
                          icon: const Icon(
                            Icons.delete_sweep_outlined,
                            color: Colors.red,
                          ),
                        ),
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

  void onTabEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'New',
              'Complete',
              'Cancel',
              'Progressing',
            ].map((status) {
              return Card(
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    updateTask(status);
                    Navigator.pop(context);
                  },
                  title: Text(status),
                  selected: selectedStatus == status,
                  trailing: selectedStatus == status
                      ? Icon(
                          Icons.check_box,
                          color: AppColor.themeColor,
                        )
                      : null,
                ),
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

  Future<void> deleteTask() async {
    deleteRefreshTask = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller().getRequest(
      Utils.deleteTask(widget.taskModel.sId!),
    );

    if (response.isSuccess) {
      widget.onRefreshList();
      showSnackBarMessage(context, 'Item deleted');
    } else {
      deleteRefreshTask = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> updateTask(String status) async {
    updateRefreshTask = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller().getRequest(
      Utils.updateTask(widget.taskModel.sId!, status),
    );

    if (response.isSuccess) {
      widget.onRefreshList();
      showSnackBarMessage(context, 'Item Updated');
    } else {
      deleteRefreshTask = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
//
