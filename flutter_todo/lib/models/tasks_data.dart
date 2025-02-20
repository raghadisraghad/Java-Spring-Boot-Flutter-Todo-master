import 'package:flutter/cupertino.dart';
import 'package:todospring/Services/database_services.dart';
import 'package:todospring/models/task.dart';

class TasksData extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task task) async {
    Task createdTask = await DatabaseServices.addTask(task);
    tasks.add(createdTask);
    notifyListeners();
  }

  void updateTaskDone(Task task) {
    DatabaseServices.markAsDone(task);
    notifyListeners();
  }

  void markAllTasksAsDone() {
    DatabaseServices.markAllTasksAsDone();
    notifyListeners();
  }

  void updateTask(Task task) {
    DatabaseServices.updateTask(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    DatabaseServices.deleteTask(task.id);
    notifyListeners();
  }

  void deleteAllTasks() {
    tasks.clear();
    DatabaseServices.deleteAllTasks();
    notifyListeners();
  }
}