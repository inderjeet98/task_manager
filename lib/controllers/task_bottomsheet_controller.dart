import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/localstorage.dart';
import '../model/response.dart';
import '../model/task_model.dart';
import 'task_list_controller.dart';

enum TasksBottomsheetState { INITIALIZING, INITIALIZED, LOADING, FAILED, SUCCEEDED }

class TaskBottomsheetController extends GetxController {
  TasksListState state = TasksListState.LOADING;
  List<Task> tasks = [];
  // late TasksBottomsheetProvider tasksBottomsheetProvider;
  // late TasksListProvider tasksListProvider;
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  var taskFormKey = GlobalKey<FormState>();
  var isUrgentTask = false;
  Task? editedTask;
  ResponseModel? latestResponse;
  bool isBottomSheetOpened = false;

  updateState(TasksListState state) {
    this.state = state;
    update();
  }

  getTasks() async {
    latestResponse = await LocalStorage().getTasks();
    if (latestResponse!.isOperationSuccessful) {
      tasks = latestResponse!.data;
      updateState(TasksListState.LOADED);
    } else {
      updateState(TasksListState.LOADED);
    }
  }
}
