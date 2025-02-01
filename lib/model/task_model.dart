// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  String? TaskId;
  String? TaskTitle;
  String? Description;
  String? Status;
  String? StartDate;
  String? EndDate;
  String? Active;
  bool isUrgent;

  Task({
    this.TaskId,
    this.TaskTitle,
    this.Description,
    this.Status,
    this.StartDate,
    this.EndDate,
    this.Active,
    required this.isUrgent,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        TaskId: json["TaskId"],
        TaskTitle: json["TaskTitle"],
        Description: json["Description"],
        Status: json["Status"],
        StartDate: json["StartDate"],
        EndDate: json["EndDate"],
        Active: json["Active"],
        isUrgent: json["isUrgent"],
      );

  Map<String, dynamic> toJson() => {
        "TaskId": TaskId,
        "TaskTitle": TaskTitle,
        "Description": Description,
        "Status": Status,
        "StartDate": StartDate,
        "EndDate": EndDate,
        "Active": Active,
        "isUrgent": isUrgent,
      };
}
