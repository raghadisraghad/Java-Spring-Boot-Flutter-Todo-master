import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todospring/models/task.dart';
import 'package:todospring/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';

class DatabaseServices {

  static Future<Task> addTask(Task task) async {
    var body = json.encode(task.toMap());
    var url = Uri.parse('$baseURL/tasks');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    Task createdTask = Task.fromMap(responseMap);

    return createdTask;
  }

  static Future<List<Task>> getTasks(String userId, String token) async {
    try {
      var url = Uri.parse('$baseURL/tasks/user/$userId');
      print("Sending request to: $url"); // Debugging
      print("Token: $token"); // Debugging

      http.Response response = await http.get(
        url,
        headers: {
          "Authorization": 'Bearer $token',
        },
      );

      print("Response status code: ${response.statusCode}"); // Debugging
      print("Response body: ${response.body}"); // Debugging

      if (response.statusCode == 200) {
        List<dynamic> responseList = jsonDecode(response.body);
        List<Task> tasks = [];
        for (Map<String, dynamic> taskMap in responseList) {
          Task task = Task.fromMap(taskMap);
          tasks.add(task);
        }
        print("Tasks: $tasks"); // Debugging
        return tasks;
      } else {
        print("Failed to fetch tasks: ${response.statusCode}"); // Debugging
        throw Exception('Failed to fetch tasks');
      }
    } catch (e) {
      print("Error fetching tasks: $e"); // Debugging
      throw e;
    }
  }

  static Future<Task> getTask(int id) async {
    var url = Uri.parse('$baseURL/tasks/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    Task task = jsonDecode(response.body);
    return task;
  }

  static Future<http.Response> updateTask(Task task) async {
    var body = json.encode(task.toMap());
    var url = Uri.parse('$baseURL/tasks');
    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteTask(int id) async {
    var url = Uri.parse('$baseURL/tasks/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<User> addUser(User user) async {
    var body = json.encode(user.toMap());
    var url = Uri.parse('$baseURL/users');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    User createdTask = User.fromMap(responseMap);

    return createdTask;
  }

  static Future<List<User>> getUsers() async {
    var url = Uri.parse('$baseURL/users');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<User> tasks = [];
    for (Map taskMap in responseList) {
      User task = User.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  static Future<User> getUser(int id) async {
    var url = Uri.parse('$baseURL/users/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    User task = jsonDecode(response.body);
    return task;
  }

  static Future<http.Response> updateUser(User user) async {
    var body = json.encode(user);
    var url = Uri.parse('$baseURL/users');
    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteUser(int id) async {
    var url = Uri.parse('$baseURL/users/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

}
