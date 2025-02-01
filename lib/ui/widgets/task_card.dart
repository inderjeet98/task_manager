import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/task_bottomsheet_controller.dart';

import '../../core/utils/sized_box_extension.dart';
import '../../core/style/style_constants/color_constants.dart';
import '../../model/task_model.dart';
import 'task_card_popup_menu.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskBottomsheetController>(
        init: TaskBottomsheetController(),
        builder: (newController) {
          return Stack(
            children: [
              Card(
                color: task.Status == 'Completed' ? ColorConstants.kPrimaryAccentColor : null,
                elevation: 0,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.visible,
                              task.TaskTitle.toString(),
                              style: const TextStyle(color: ColorConstants.kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          20.kW,
                        ],
                      ),
                      10.kH,
                      Text(
                        task.Description.toString(),
                        style: const TextStyle(color: ColorConstants.kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              task.isUrgent == 'true'
                  ? Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(6),
                      decoration: const ShapeDecoration(
                        color: ColorConstants.kErrorColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                      ),
                    )
                  : Container(),
              Align(alignment: Alignment.topRight, child: Padding(padding: const EdgeInsets.only(right: 5), child: TaskCardPopupMenu(task: task))),
            ],
          );
        });
  }
}
