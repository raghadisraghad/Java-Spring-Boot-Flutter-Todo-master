import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todospring/models/tasks_data.dart';
import 'package:todospring/models/users_data.dart';

import 'Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksData>(create: (context) => TasksData()),
        ChangeNotifierProvider<UsersData>(create: (context) => UsersData()), // Add this line
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
