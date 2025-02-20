// import 'package:flutter/material.dart';
// import 'package:todospring/models/task.dart';
// import 'package:todospring/models/tasks_data.dart';
//
// class UpdateTaskScreen extends StatefulWidget {
//   final Task task;
//   final TasksData tasksData;
//
//   const UpdateTaskScreen({
//     Key? key,
//     required this.task,
//     required this.tasksData,
//   }) : super(key: key);
//
//   @override
//   _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
// }
//
// class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _titleController;
//   late bool _isDone;
//
//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.task.title);
//     _isDone = widget.task.done;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: _titleController,
//               decoration: const InputDecoration(labelText: 'Task Title'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a task title';
//                 }
//                 return null;
//               },
//             ),
//             CheckboxListTile(
//               title: const Text('Done'),
//               value: _isDone,
//               onChanged: (value) {
//                 setState(() {
//                   _isDone = value ?? false;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   // Create an updated task object
//                   Task updatedTask = Task(
//                     id: widget.task.id,
//                     title: _titleController.text,
//                     done: _isDone,
//                     userId: widget.task.userId,
//                     createdDate: widget.task.created_date,
//                   );
//
//                   // Update the task using TasksData
//                   await widget.tasksData.updateTask(updatedTask);
//
//                   // Close the bottom sheet
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text('Update Task'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }