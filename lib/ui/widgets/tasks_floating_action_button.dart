import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/task_bottomsheet_controller.dart';

import '../../core/style/style_constants/color_constants.dart';

class TasksFloatingActionButton extends StatelessWidget {
  const TasksFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskBottomsheetController>(builder: (newController) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: ColorConstants.kPrimaryColor,
            splashColor: ColorConstants.kPrimaryAccentColor,
            focusColor: ColorConstants.kPrimaryAccentColor,
            hoverColor: ColorConstants.kPrimaryAccentColor,
            foregroundColor: ColorConstants.kPrimaryAccentColor,
            onPressed: () => newController.toggleBottomSheet(),
            child: Icon(
              newController.isBottomSheetOpened ? Icons.close_rounded : Icons.add_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      );
    });
  }
}
