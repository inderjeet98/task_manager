import 'package:flutter/material.dart';

import '../../model/task_model.dart';
import 'task_card.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  const TasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskCard(task: tasks[index])),
        SizedBox(
          height: 450,
        ),
      ],
    );
  }
}
