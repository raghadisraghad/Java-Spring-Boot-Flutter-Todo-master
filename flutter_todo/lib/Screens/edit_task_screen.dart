import 'package:flutter/material.dart';
import 'package:todospring/models/task.dart';
import 'package:todospring/Services/database_services.dart';
import 'package:todospring/Utils/Token.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late bool _isDone;
  late int _userId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _isDone = widget.task.done;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: Colors.greenAccent, // Maintain your color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: const Text('Done'),
              value: _isDone,
              activeColor: Colors.blueAccent, // Maintain your color
              onChanged: (value) {
                setState(() {
                  _isDone = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var token = await Token.getToken();
                    if (token != null) {
                      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
                      _userId = int.parse(decodedToken['sub']);
                      // Update the task in the database
                      Task updatedTask = Task(
                        id: widget.task.id,
                        title: _titleController.text,
                        done: _isDone,
                        userId: _userId,
                      );
                      await DatabaseServices.updateTask(updatedTask);
                      // Pop the screen and return the updated task
                      Navigator.pop(context, updatedTask);
                    }
                  },
                  child: const Text('Update'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Just close the screen without saving
                  },
                  child: const Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
