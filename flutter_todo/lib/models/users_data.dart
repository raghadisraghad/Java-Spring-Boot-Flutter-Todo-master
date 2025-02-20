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

  Future<bool> updateUser(User user) async {
    bool success = await DatabaseServices.updateUser(user);
    if (success) {
      notifyListeners();
    }
    return success;
  }

  Future<bool> deleteUser(User user) async {
    bool success = await DatabaseServices.deleteUser(user.id);
    if (success) {
      users.remove(user);
      notifyListeners();
    }
    return success;
  }
}
