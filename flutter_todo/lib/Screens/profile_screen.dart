import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todospring/models/user.dart';
import 'package:todospring/models/users_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    Map<String, dynamic> userMap = userJson != null ? jsonDecode(userJson) : {};
    setState(() {
      user = User(
        id: userMap['id'] ?? 0,
        firstname: userMap['firstname'] ?? '',
        lastname: userMap['lastname'] ?? '',
        email: userMap['email'] ?? '',
        username: userMap['username'] ?? '',
        password: userMap['password'] ?? '',
        gender: userMap['gender'] ?? '',
        created_date: userMap['created_date'] ?? '',
      );
      _firstnameController.text = user.firstname;
      _lastnameController.text = user.lastname;
      _emailController.text = user.email;
      _usernameController.text = user.username;
      _passwordController.text = user.password;
      _genderController.text = user.gender; // Initially set to avoid error
    });
  }

  void updateProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      User updatedUser = User(
        id: user.id,
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        gender: user.gender, // Keep gender unchanged
        created_date: user.created_date,
      );

      bool isUpdated = await Provider.of<UsersData>(context, listen: false)
          .updateUser(updatedUser);

      if (isUpdated) {
        loadUserData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  void deleteProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDeleted = await Provider.of<UsersData>(context, listen: false)
        .deleteUser(user);

    if (isDeleted) {
      await prefs.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete profile')),
      );
    }
    Navigator.pop(context); // Navigate back to the home screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Account Created: ${user.formattedCreatedDate}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstnameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                readOnly: true, // Make gender field unchangeable
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => updateProfile(context),
                child: const Text('Update Profile'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool? confirmDeleteProfile = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Profile'),
                        content: const Text('Are you sure you want to delete your profile? This action cannot be undone.'),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmDeleteProfile == true) {
                    deleteProfile(); // Call the delete function
                  }
                },
                child: const Text('Delete Profile'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
