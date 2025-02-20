import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todospring/models/task.dart';
import 'package:todospring/models/user.dart';
import 'package:todospring/Utils/Token.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';

class DatabaseServices {

  static Future<Task> addTask(Task task) async {
    var token = await Token.getToken();
    if (token == null) {
      throw Exception('No token found. Please log in.');
    }

    var body = json.encode(task.toMap());
    var url = Uri.parse('$baseURL/tasks');

    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return Task.fromMap(responseMap);
    } else {
      throw Exception('Failed to add task: ${response.statusCode}');
    }
  }

  static Future<List<Task>> getTasks() async {
    var token = await Token.getToken();
    if (token == null) {
      throw Exception('No token found. Please log in.');
    }
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken['sub'];
    var url = Uri.parse('$baseURL/tasks/user/$userId');

    http.Response response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      });

    if (response.statusCode == 200) {
      List<dynamic> responseList = jsonDecode(response.body);
      return responseList.map((taskMap) => Task.fromMap(taskMap)).toList();
    } else {
      throw Exception('Failed to fetch tasks: ${response.statusCode}');
    }
  }

  static Future<Task> getTask(int id) async {
    var url = Uri.parse('$baseURL/tasks/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    Task task = jsonDecode(response.body);
    return task;
  }

  static Future<http.Response> updateTask(Task task) async {
    var token = await Token.getToken();
    if (token == null) {
      throw Exception('No token found. Please log in.');
    }
    var body = json.encode(task.toMap());
    var url = Uri.parse('$baseURL/tasks');
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
    return response;
  }

  static Future<http.Response> markAsDone(Task task) async {
    var token = await Token.getToken();
    if (token == null) {
      throw Exception('No token found. Please log in.');
    }
    task.toggle();
    var body = json.encode(task.toMap());
    var url = Uri.parse('$baseURL/tasks');
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
    return response;
  }

  static Future<http.Response> markAllTasksAsDone() async {
    var token = await Token.getToken();
    if (token == null) {
      throw Exception('No token found. Please log in.');
    }
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken['sub'];
    var url = Uri.parse('$baseURL/tasks/done/$userId');
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      }
    );
    return response;
  }

  static Future<http.Response> deleteTask(int id) async {
    var token = await Token.getToken();
    if (token == null) {
      throw Exception('No token found. Please log in.');
    }
    var url = Uri.parse('$baseURL/tasks/$id');
    http.Response response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return response;
  }

  static Future<http.Response> deleteAllTasks() async {
    var token = await Token.getToken();
    if (token == null) {
      throw Exception('No token found. Please log in.');
    }
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken['sub'];
    var url = Uri.parse('$baseURL/tasks/all/$userId');
    http.Response response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return response;
  }

  static Future<User> addUser(User user) async {
    var body = json.encode(user.toJson());
    var url = Uri.parse('$baseURL/users');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
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
    var token = await Token.getToken();
    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    User task = jsonDecode(response.body);
    return task;
  }

  static Future<bool> updateUser(User user) async {
    var body = json.encode(user);
    var url = Uri.parse('$baseURL/users');
    var token = await Token.getToken();
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    Map<String, dynamic> user2 = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.setString('user', jsonEncode(user2));

    return response.statusCode == 200 || response.statusCode == 204;
  }

  static Future<bool> deleteUser(int id) async {
    var url = Uri.parse('$baseURL/users/$id');
    var token = await Token.getToken();
    http.Response response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return response.statusCode == 200 || response.statusCode == 204;
  }

}
