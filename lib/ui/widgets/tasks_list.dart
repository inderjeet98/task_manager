import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/task_bottomsheet_controller.dart';
import '../../model/task_model.dart';
import 'task_card.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  const TasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final TaskBottomsheetController taskBottomsheetController = Get.put(TaskBottomsheetController());
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskCard(task: tasks[index])),
        SizedBox(
          height: taskBottomsheetController.isBottomSheetOpened ? 450 : 100,
        ),
      ],
    );
  }
}
