import 'package:flutter/material.dart';
import 'package:todospring/models/task.dart';
import 'package:todospring/models/tasks_data.dart';
import 'package:todospring/Screens/edit_task_screen.dart'; // Import the EditTaskScreen

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
    return Column(
      children: [
        ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.done ? TextDecoration.lineThrough : null,
              decorationColor: task.done ? Colors.greenAccent : null,
              decorationThickness: 2.0,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Edit Icon
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(task: task),
                    ),
                  ).then((updatedTask) {
                    if (updatedTask != null) {
                      tasksData.updateTask(updatedTask);
                    }
                  });
                },
              ),
              // Checkbox
              Checkbox(
                value: task.done,
                onChanged: (value) {
                  tasksData.updateTaskDone(task);
                },
                activeColor: Colors.greenAccent,
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.greenAccent),
      ],
    );
  }
}