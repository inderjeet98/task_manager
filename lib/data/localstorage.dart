import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../core/constants/string_constants.dart';
import '../model/response.dart';
import '../model/task_model.dart';

class LocalStorage {
  static Database? _database;
  static final LocalStorage db = LocalStorage();

  LocalStorage();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Function to delete the database
  Future<void> deleteWholeDatabase() async {
    String path = join(await getDatabasesPath(), 'task.db');

    // Close the database if it's open
    Database database = await openDatabase(path);
    if (database.isOpen) {
      await database.close();
    }

    // Delete the database file
    await deleteDatabase(path);
    await openDatabase(path);
  }

  initDB() async {
    try {
      String documentsDirectory = await getDatabasesPath();
      // final path = join(documentsDirectory.path, 'TPartyMasterr.db');
      final path = join(documentsDirectory, 'task.db');
      await openDatabase(path, version: 2, onOpen: (db) {}, onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE t_task('
            'TaskId INTEGER PRIMARY KEY,'
            'TaskTitle TEXT,'
            'Description TEXT,'
            'Status TEXT,'
            'StartDate TEXT,'
            'EndDate TEXT,'
            'Active TEXT,'
            ')');
      });
      return ResponseModel(message: "", isOperationSuccessful: true);
    } catch (e) {
      return ResponseModel(message: e.toString(), isOperationSuccessful: false);
    }
  }

  createTask(Task task) async {
    // await deleteAllTPartyMasters();
    final db = await database;
    final res = await db!.insert('t_task', task.toJson());

    return res;
  }

  Future<ResponseModel> getTasks() async {
    try {
      List taskList = await getTaskList();
      return ResponseModel(message: "", isOperationSuccessful: true, data: taskList);
    } catch (e) {
      return ResponseModel(message: e.toString(), isOperationSuccessful: false);
    }
  }

  Future<List<Task>> getTaskList() async {
    var db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('t_task');
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  Future<ResponseModel> addTask(Task task) async {
    try {
      await createTask(task);
      return ResponseModel(
        message: StringConstants.taskAddedSuccufully,
        isOperationSuccessful: true,
      );
    } catch (e) {
      return ResponseModel(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Future<ResponseModel> updateTask(Task task) async {
    try {
      await _database!.update('t_task', task.toJson(), where: 'TaskId = ?', whereArgs: [task.TaskId]);
      return ResponseModel(
        message: StringConstants.taskEditedSuccufully,
        isOperationSuccessful: true,
      );
    } catch (e) {
      return ResponseModel(message: e.toString(), isOperationSuccessful: false);
    }
  }

  static Future<ResponseModel> deleteTask(Task task) async {
    try {
      await _database!.delete('t_task', where: 'TaskId=?', whereArgs: [task.TaskId]);
      return ResponseModel(
        message: StringConstants.taskDeletedSuccufully,
        isOperationSuccessful: true,
      );
    } catch (e) {
      return ResponseModel(message: e.toString(), isOperationSuccessful: false);
    }
  }
}
