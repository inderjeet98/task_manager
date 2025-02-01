import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/task_list_controller.dart';
import 'package:task_manager/core/utils/sized_box_extension.dart';

import '../../core/constants/string_constants.dart';
import '../../core/style/style_constants/color_constants.dart';
import '../widgets/task_bottom_sheet.dart';
import '../widgets/tasks_floating_action_button.dart';
import '../widgets/tasks_list.dart';
import '../widgets/tasks_screen_header.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskListController _taskListController = Get.put(TaskListController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskListController>(
        init: _taskListController,
        builder: (newController) {
          return Scaffold(
              bottomSheet: const TasksBottomsheet(),
              floatingActionButton: const TasksFloatingActionButton(),
              body: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(children: [
                buildUserInfo(),
                GetBuilder<TaskListController>(
                  init: _taskListController,
                  builder: (newController) => buildScreenBody(newController),
                )
              ]))));
        });
  }

  buildUserInfo() {
    return Container(
        // color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 100,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          012.kW,
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringConstants.welcomeTitle, style: TextStyle(color: ColorConstants.kPrimaryColor, fontSize: 26, fontWeight: FontWeight.bold)),
              Text(StringConstants.greatDay, style: TextStyle(color: ColorConstants.kPrimaryColor, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          )
        ]));
  }

  buildScreenBody(TaskListController tasksListController) {
    switch (tasksListController.state) {
      case TasksListState.LOADING:
        tasksListController.initialize();
        return buildLoadingScreen();
      case TasksListState.LOADED:
        return buildTasks(tasksListController);
      case TasksListState.RELOADING:
        tasksListController.reinitialzeState(context);
        return buildTasks(tasksListController);
    }
  }

  buildTasks(TaskListController tasksListProvider) {
    return tasksListProvider.tasks.isEmpty
        ? buildEmptyTasksList()
        : Column(
            children: [TasksScreenHeader(tasksCount: tasksListProvider.tasks.length), TasksList(tasks: tasksListProvider.tasks)],
          );
  }

  buildLoadingScreen() => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator()));

  buildEmptyTasksList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        SizedBox(width: 100, height: 100, child: Image.asset("assets/images/empty.png")),
        20.kH,
        const Text(
          StringConstants.emptyTasksLabel,
          style: TextStyle(color: ColorConstants.kPrimaryColor),
        ),
      ],
    );
  }
}
