import 'package:flutter/material.dart';
import 'package:todospring/models/task.dart';
import 'package:todospring/models/tasks_data.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final TasksData tasksData;

  const TaskTile({
    Key? key,
    required this.task,
    required this.tasksData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.done ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          tasksData.updateTaskDone(task);
        },
        child: Checkbox(
          value: task.done,
          onChanged: (value) {
            tasksData.updateTaskDone(task);
          },
        ),
      ),

    );
  }
}