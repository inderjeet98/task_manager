import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/task_list_controller.dart';

import '../core/constants/string_constants.dart';
import '../core/style/style_constants/color_constants.dart';
import '../data/localstorage.dart';
import '../model/response.dart';
import '../model/task_model.dart';

// ignore: constant_identifier_names
enum TasksBottomsheetState { INITIALIZING, INITIALIZED, LOADING, FAILED, SUCCEEDED }

class TaskBottomsheetController extends GetxController {
  TasksBottomsheetState state = TasksBottomsheetState.LOADING;
  List<Task> tasks = [];
  // late TasksBottomsheetProvider tasksBottomsheetProvider;
  final TaskListController _taskListController = Get.put(TaskListController());
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  var taskFormKey = GlobalKey<FormState>();

  final Rx<bool> _isUrgentTask = Rx<bool>(false);
  bool get isUrgentTask => _isUrgentTask.value;
  final Rx<bool> _isTaskCompleted = Rx<bool>(false);
  bool get isTaskCompleted => _isTaskCompleted.value;
  final Rx<bool> _isBottomSheetOpened = Rx<bool>(false);
  bool get isBottomSheetOpened => _isBottomSheetOpened.value;

  Task? editedTask;
  ResponseModel? latestResponse;

  updateState(TasksBottomsheetState state) {
    this.state = state;
    update();
  }

  init(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => updateState(TasksBottomsheetState.INITIALIZED));
  }

  setTask() async {
    if (taskFormKey.currentState!.validate()) {
      updateState(TasksBottomsheetState.LOADING);
      if (editedTask == null) {
        var taskList = await LocalStorage.db.getTaskList();
        int taskId = (taskList.length + 1);
        // Add New Task
        latestResponse = await LocalStorage.db.addTask(Task(
            TaskId: taskId,
            TaskTitle: taskTitleController.text,
            Description: taskDescriptionController.text,
            isUrgent: _isUrgentTask.value.toString(),
            Status: _isTaskCompleted.value ? 'Completed' : 'Pending'));
      } else {
        // Update Task
        editedTask!.TaskTitle = taskTitleController.text;
        editedTask!.Description = taskDescriptionController.text;
        editedTask!.isUrgent = _isUrgentTask.value.toString();
        editedTask!.Status = _isTaskCompleted.value ? 'Completed' : 'Pending';
        latestResponse = await LocalStorage.updateTask(editedTask!);
        if (latestResponse!.isOperationSuccessful) {
          _isBottomSheetOpened.value = false;
        }
      }
      if (latestResponse!.isOperationSuccessful) {
        _taskListController.updateState(TasksListState.RELOADING);
        close();
        updateState(TasksBottomsheetState.SUCCEEDED);
      } else {
        updateState(TasksBottomsheetState.FAILED);
      }
    }
    update();
  }

  validateTaskTitle() {
    if (taskTitleController.text.isEmpty) {
      return StringConstants.taskTitleFieldError;
    }
    return null;
  }

  validateTaskDescription() {
    if (taskDescriptionController.text.isEmpty) {
      return StringConstants.taskDescriptionFieldError;
    }
    return null;
  }

  open({Task? task}) {
    _setStateData(task: task);
    _isBottomSheetOpened.value = true;
    update();
  }

  close() {
    _isBottomSheetOpened.value = false;
    _setStateData();
    updateState(TasksBottomsheetState.INITIALIZED);
  }

  toggleBottomSheet() {
    _isBottomSheetOpened.value ? close() : open();
    update();
  }

  setUrgentTask(bool? value) {
    if (value != null) {
      _isUrgentTask.value = value;
      update();
    }
  }

  setStatusTask(bool? value) {
    if (value != null) {
      _isTaskCompleted.value = value;
      update();
    }
  }

  _setStateData({Task? task}) {
    editedTask = task;
    if (editedTask != null) {
      taskTitleController.text = editedTask!.TaskTitle.toString();
      taskDescriptionController.text = editedTask!.Description.toString();
      _isUrgentTask.value = editedTask!.isUrgent == 'true' ? true : false;
      _isTaskCompleted.value = editedTask!.Status == 'Completed' ? true : false;
    } else {
      taskTitleController.text = '';
      taskDescriptionController.text = '';
      _isUrgentTask.value = false;
      _isTaskCompleted.value = false;
      editedTask = null;
      if (latestResponse != null) {
        latestResponse!.message = '';
      }
    }
  }

  reinitialzeState(BuildContext context) {
    if (latestResponse != null && latestResponse!.message.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.showSnackbar(GetSnackBar(
          messageText:
              Text(latestResponse!.message, style: const TextStyle(fontFamily: "Poppins", fontSize: 11, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 60, 60, 60))),
          duration: const Duration(seconds: 3),
          backgroundColor: ColorConstants.kPrimaryColor,
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 70),
          borderRadius: 6.0,
          barBlur: 3.0,
        ));
        _setStateData();
        updateState(TasksBottomsheetState.INITIALIZED);
      });
    }
  }
}
