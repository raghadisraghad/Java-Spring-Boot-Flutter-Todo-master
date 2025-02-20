import 'package:intl/intl.dart';

class Task {
  final int id;
  final String title;
  bool done;
  final int userId;
  final DateTime created_date;

  Task({
    required this.id,
    required this.title,
    this.done = false,
    required this.userId,
    DateTime? createdDate, // Optional parameter
  }) : created_date = createdDate ?? DateTime.now();

  String get formattedCreatedDate {
    return DateFormat('yyyy-MM-dd').format(created_date);
  }

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['title'],
      done: taskMap['done'],
      userId: taskMap['user']['id'],
      createdDate: DateTime.parse(taskMap['created_date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
      'user': {
        'id': userId,
      },
      'created_date': created_date.toIso8601String(),
    };
  }

  void toggle() {
    done = !done;
  }
}
