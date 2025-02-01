// ignore_for_file: deprecated_member_use

import 'package:task_manager/core/utils/sized_box_extension.dart';

import '../../controllers/task_bottomsheet_controller.dart';
import '../../core/constants/string_constants.dart';
import '../../core/reusable_widgets/app_text_form_field.dart';
import '../../core/style/style_constants/color_constants.dart';
// import 'package:afs_task/modules/tasks/providers/tasks_bottomsheet_provider.dart';
import 'package:flutter/material.dart';

class TasksBottomsheet extends StatelessWidget {
  const TasksBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    // TasksBottomsheetProvider tasksBottomsheetProvider = Provider.of<TasksBottomsheetProvider>(context);
    var tasksBottomsheetProvider;
    switch (tasksBottomsheetProvider.state) {
      case TasksBottomsheetState.INITIALIZING:
        tasksBottomsheetProvider.init(context);
        break;
      case TasksBottomsheetState.INITIALIZED:
        break;
      case TasksBottomsheetState.LOADING:
        break;
      case TasksBottomsheetState.FAILED:
        tasksBottomsheetProvider.reinitialzeState(context);
        break;
      case TasksBottomsheetState.SUCCEEDED:
        tasksBottomsheetProvider.reinitialzeState(context);
        break;
    }

    return tasksBottomsheetProvider.isBottomSheetOpened
        ? Container(
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ], color: Colors.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
            child: Form(
                key: tasksBottomsheetProvider.taskFormKey,
                child: ListView(shrinkWrap: true, children: [
                  AppTextFormField(
                    label: StringConstants.taskTitleFieldLabel,
                    textEditingController: tasksBottomsheetProvider.taskTitleController,
                    hintText: StringConstants.taskTitleFieldHint,
                    validator: (input) => tasksBottomsheetProvider.validateTaskTitle(),
                    autoFocus: true,
                    maxLines: 1,
                  ),
                  15.kH,
                  AppTextFormField(
                    label: StringConstants.taskDescriptionFieldLabel,
                    textEditingController: tasksBottomsheetProvider.taskDescriptionController,
                    hintText: StringConstants.taskDescriptionFieldHint,
                    validator: (input) => tasksBottomsheetProvider.validateTaskDescription(),
                    maxLines: 5,
                  ),
                  5.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        StringConstants.isUrgentTaskFieldLabel,
                        style: TextStyle(fontSize: 15, color: ColorConstants.kPrimaryAccentColor),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: ColorConstants.kPrimaryColor,
                        value: tasksBottomsheetProvider.isUrgentTask,
                        onChanged: (value) => tasksBottomsheetProvider.setUrgentTask(value),
                      )
                    ],
                  ),
                  10.kH,
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MaterialButton(
                          elevation: 0,
                          height: 50,
                          color: ColorConstants.kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () => tasksBottomsheetProvider.setTask(),
                          child: tasksBottomsheetProvider.state == TasksBottomsheetState.LOADING
                              ? const SizedBox(
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(tasksBottomsheetProvider.editedTask == null ? StringConstants.addButtonLabel : StringConstants.updateButtonLabel))),
                ])))
        : 0.kH;
  }
}
