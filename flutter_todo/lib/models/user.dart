import 'package:intl/intl.dart';

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String password;
  final String gender;
  final DateTime created_date;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.gender,
    DateTime? createdDate, required created_date,
  }) : created_date = createdDate ?? DateTime.now();

  String get formattedCreatedDate {
    return DateFormat('yyyy-MM-dd').format(created_date);
  }

  factory User.fromMap(Map userMap) {
    return User(
      id: userMap['id'],
      firstname: userMap['firstname'],
      lastname: userMap['lastname'],
      email: userMap['email'],
      username: userMap['username'],
      password: userMap['password'],
      gender: userMap['gender'],
      createdDate: DateTime.parse(userMap['created_date']), created_date: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'username': username,
      'password': password,
      'gender': gender,
      'created_date': created_date.toIso8601String(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'username': username,
      'password': password,
      'gender': gender,
      'created_date': created_date.toIso8601String(),
    };
  }
}
