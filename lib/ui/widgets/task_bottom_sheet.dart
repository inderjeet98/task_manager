// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
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
    return GetBuilder<TaskBottomsheetController>(
        init: TaskBottomsheetController(),
        builder: (newController) {
          switch (newController.state) {
            case TasksBottomsheetState.INITIALIZING:
              newController.init(context);
              break;
            case TasksBottomsheetState.INITIALIZED:
              break;
            case TasksBottomsheetState.LOADING:
              break;
            case TasksBottomsheetState.FAILED:
              newController.reinitialzeState(context);
              break;
            case TasksBottomsheetState.SUCCEEDED:
              newController.reinitialzeState(context);
              break;
          }

          return newController.isBottomSheetOpened
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
                      key: newController.taskFormKey,
                      child: ListView(shrinkWrap: true, children: [
                        AppTextFormField(
                          label: StringConstants.taskTitleFieldLabel,
                          textEditingController: newController.taskTitleController,
                          hintText: StringConstants.taskTitleFieldHint,
                          validator: (input) => newController.validateTaskTitle(),
                          autoFocus: true,
                          maxLines: 1,
                        ),
                        15.kH,
                        AppTextFormField(
                          label: StringConstants.taskDescriptionFieldLabel,
                          textEditingController: newController.taskDescriptionController,
                          hintText: StringConstants.taskDescriptionFieldHint,
                          validator: (input) => newController.validateTaskDescription(),
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
                              value: newController.isUrgentTask,
                              onChanged: (value) => newController.setUrgentTask(value),
                            )
                          ],
                        ),
                        5.kH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              StringConstants.isTaskCompletedFieldLabel,
                              style: TextStyle(fontSize: 15, color: ColorConstants.kPrimaryAccentColor),
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: ColorConstants.kPrimaryColor,
                              value: newController.isTaskCompleted,
                              onChanged: (value) => newController.setStatusTask(value),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                onPressed: () => newController.setTask(),
                                child: newController.state == TasksBottomsheetState.LOADING
                                    ? const SizedBox(width: 50, child: CircularProgressIndicator())
                                    : Text(newController.editedTask == null ? StringConstants.addButtonLabel : StringConstants.updateButtonLabel))),
                      ])))
              : 0.kH;
        });
  }
}
