class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String password;
  final String gender;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.gender
  });

  factory User.fromMap(Map taskMap) {
    return User(
      id: taskMap['id'],
      firstname: taskMap['firstname'],
      lastname: taskMap['lastname'],
      email: taskMap['email'],
      username: taskMap['username'],
      password: taskMap['password'],
      gender: taskMap['gender'],
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
    };
  }
}
