import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todospring/Services/database_services.dart';
import 'package:todospring/models/task.dart';
import 'package:todospring/models/tasks_data.dart';
import 'package:todospring/screens/login_screen.dart'; // Import your LoginScreen
import 'package:todospring/screens/register_screen.dart'; // Import your RegisterScreen
import 'package:shared_preferences/shared_preferences.dart';

import '../task_tile.dart';
import 'add_task_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;
  bool isLoggedIn = false; // Track login status

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Check if user is logged in
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('token') != null; // Check if token exists
    });
    if (isLoggedIn) {
      getTasks(); // Fetch tasks only if logged in
    }
  }

  // Fetch tasks from the database
  void getTasks() async {
    tasks = await DatabaseServices.getTasks();
    Provider.of<TasksData>(context, listen: false).tasks = tasks!;
    setState(() {});
  }

  // Logout the user
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user'); // Remove the token from local storage
    setState(() {
      isLoggedIn = false; // Update login status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLoggedIn
              ? 'Todo List (${Provider.of<TasksData>(context).tasks.length})'
              : 'Todo List',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          if (isLoggedIn) // Show Logout button if logged in
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: logout,
            ),
        ],
      ),
      body: isLoggedIn
          ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Consumer<TasksData>(builder: (context, tasksData, child) {
              return Column(
                children: [
                  // Only show the buttons if there are tasks
                  if (tasksData.tasks.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await DatabaseServices.deleteAllTasks();
                            // Optionally, refresh tasks after deletion
                            getTasks();
                          },
                          child: const Text('Delete All Tasks'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await DatabaseServices.markAllTasksAsDone();
                            getTasks();
                          },
                          child: const Text('Mark All Done'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add some space between buttons and task list
                  ],
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasksData.tasks.length,
                      itemBuilder: (context, index) {
                        Task task = tasksData.tasks[index];
                        print(task.toString());
                        return TaskTile(
                          task: task,
                          tasksData: tasksData,
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
      floatingActionButton: isLoggedIn
          ? FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddTaskScreen();
            },
          );
        },
      )
          : null, // Hide the button if not logged in
    );
  }
}