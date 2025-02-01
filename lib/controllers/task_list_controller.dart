import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/style/style_constants/color_constants.dart';
import '../data/localstorage.dart';
import '../model/task_model.dart';
import '../model/response.dart';

enum TasksListState { LOADING, RELOADING, LOADED }

class TaskListController extends GetxController {
  TasksListState state = TasksListState.LOADING;
  List<Task> tasks = [];
  late ResponseModel latestResponse;

  initialize() async {
    latestResponse = await LocalStorage().init();
    if (latestResponse.isOperationSuccessful) {
      getTasks();
    } else {
      updateState(TasksListState.LOADED);
    }
  }

  deleteTask(Task task) async {
    latestResponse = await LocalStorage.deleteTask(task);
    if (latestResponse.isOperationSuccessful) {
      updateState(TasksListState.RELOADING);
    } else {
      updateState(TasksListState.LOADED);
    }
  }

  updateState(TasksListState state) {
    this.state = state;
    update();
  }

  reinitialzeState(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (latestResponse.message.isNotEmpty) {
        Get.showSnackbar(GetSnackBar(
          messageText:
              Text(latestResponse.message, style: const TextStyle(fontFamily: "Poppins", fontSize: 11, fontWeight: FontWeight.w500, color: ColorConstants.kSecondaryColorAccent)),
          duration: const Duration(seconds: 3),
          backgroundColor: ColorConstants.kPrimaryColor,
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 70),
          borderRadius: 6.0,
          barBlur: 3.0,
        ));
        latestResponse.message = '';
      }
      getTasks();
    });
  }

  getTasks() async {
    latestResponse = await LocalStorage().getTasks();
    if (latestResponse.isOperationSuccessful) {
      tasks = latestResponse.data;
      updateState(TasksListState.LOADED);
    } else {
      updateState(TasksListState.LOADED);
    }
  }
}
