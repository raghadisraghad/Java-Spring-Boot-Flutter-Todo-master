import 'package:flutter/cupertino.dart';
import 'package:todospring/Services/database_services.dart';
import 'package:todospring/models/user.dart';

class UsersData extends ChangeNotifier {
  List<User> users = [];

  void addUser(User user) async {
    User createdUser = await DatabaseServices.addUser(user);
    users.add(createdUser);
    notifyListeners();
  }

  void updateUser(User user) {
    DatabaseServices.updateUser(user);
    notifyListeners();
  }

  void deleteUser(User user) {
    users.remove(user);
    DatabaseServices.deleteUser(user.id);
    notifyListeners();
  }
}
