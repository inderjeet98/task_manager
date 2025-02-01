import 'package:flutter/material.dart';

import '../../core/constants/string_constants.dart';
import '../../core/style/style_constants/color_constants.dart';

class TasksScreenHeader extends StatelessWidget {
  final int tasksCount;
  const TasksScreenHeader({super.key, required this.tasksCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            StringConstants.yourTasksTitle,
            style: TextStyle(color: ColorConstants.kPrimaryColor, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            "$tasksCount ${StringConstants.tasksLabel}",
            style: const TextStyle(
              color: ColorConstants.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
