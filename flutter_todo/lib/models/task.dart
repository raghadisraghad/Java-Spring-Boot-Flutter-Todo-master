class Task {
  final int id;
  final String title;
  bool done;
  final int userId;

  Task({
    required this.id,
    required this.title,
    this.done = false,
    required this.userId,
  });

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['title'],
      done: taskMap['done'],
      userId: taskMap['user']['id'],
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
    };
  }

  void toggle() {
    done = !done;
  }
}
