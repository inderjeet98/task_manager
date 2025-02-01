import 'package:flutter/material.dart';

import '../../core/constants/string_constants.dart';
import '../../core/style/style_constants/color_constants.dart';
import '../../model/task_model.dart';

class TaskCardPopupMenu extends StatefulWidget {
  final Task task;
  const TaskCardPopupMenu({super.key, required this.task});

  @override
  State<TaskCardPopupMenu> createState() => _TaskCardPopupMenuState();
}

class _TaskCardPopupMenuState extends State<TaskCardPopupMenu> {
  List<String> list = <String>[
    StringConstants.editTaskMenuItemLabel,
    StringConstants.deleteTaskMenuItemLabel,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TasksBottomsheetProvider tasksBottomsheetProvider = Provider.of<TasksBottomsheetProvider>(context);
    // TasksListProvider tasksListProvider = Provider.of<TasksListProvider>(context);

    return PopupMenuButton(
      icon: const Icon(Icons.more_horiz_rounded, color: ColorConstants.kPrimaryColor),
      itemBuilder: (context) => [
        const PopupMenuItem<String>(value: StringConstants.editTaskMenuItemLabel, child: Text(StringConstants.editTaskMenuItemLabel)),
        const PopupMenuItem<String>(
            value: StringConstants.deleteTaskMenuItemLabel, child: Text(StringConstants.deleteTaskMenuItemLabel, style: TextStyle(color: ColorConstants.kErrorColor))),
      ],
      splashRadius: 0.1,
      onSelected: (value) {
        if (value == StringConstants.editTaskMenuItemLabel) {
          // tasksBottomsheetProvider.open(task: widget.task);
        } else if (value == StringConstants.deleteTaskMenuItemLabel) {
          // tasksListProvider.deleteTask(widget.task);
        }
      },
    );
  }
}
