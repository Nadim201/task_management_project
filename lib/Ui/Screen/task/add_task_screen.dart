import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_management_project/Ui/Widget/backgroundImage.dart';
import 'package:task_management_project/Ui/Widget/custom_appBar.dart';

import 'package:task_management_project/data/controller/addTask_controller.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static String name = '/addTaskScreen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _subTEController = TextEditingController();
  final TextEditingController _desTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool refreshPreviewPage = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, refreshPreviewPage);
      },
      child: Scaffold(
        appBar: const CustomAppbar(),
        body: Backgroundimage(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text('Add New Task',
                        style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 30)),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _subTEController,
                      decoration: const InputDecoration(hintText: 'Subject'),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Form is blank';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _desTEController,
                      maxLines: 6,
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Form is blank';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: _onTabSubmit,
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTabSubmit() async {
    if (_formKey.currentState!.validate()) {
      addTask();
    }
  }

  Future<void> addTask() async {
    var addTaskScreenController = AddTaskScreenController();
    final bool result = await addTaskScreenController.addTaskNow(
        _subTEController.text, _desTEController.text, "New");
    if (result) {
      refreshPreviewPage = true;
      _clearTextFiled();
      Get.snackbar(
        'Task Added Successfully',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigoAccent,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Task Add Failed',
        AddTaskScreenController.errorMessage ?? 'An unexpected error occurred.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _clearTextFiled() {
    _subTEController.clear();
    _desTEController.clear();
  }

  @override
  void dispose() {
    _subTEController.dispose();
    _desTEController.dispose();
    super.dispose();
  }
}
