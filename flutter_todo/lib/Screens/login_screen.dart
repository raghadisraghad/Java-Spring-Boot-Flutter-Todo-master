import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For local storage
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert'; // For JSON encoding/decoding
import 'package:todospring/Services/globals.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _usernameController = TextEditingController(); // Controller for username
  final _passwordController = TextEditingController(); // Controller for password
  String _errorMessage = ''; // To display error messages
  bool _obscurePassword = true; // To toggle password visibility

  // Function to handle login
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Prepare the request body
      final Map<String, String> requestBody = {
        'username': _usernameController.text,
        'password': _passwordController.text,
      };

      try {
        // Send a POST request to the backend
        var url = Uri.parse('$baseURL/auth/login');
        var body = json.encode(requestBody);
        http.Response response = await http.post(
          url,
          headers: headers,
          body: body,
        );

        // Check the response status code
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          String token = data['token'];
          Map<String, dynamic> user = data['user'];
          // Save the token in local storage
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('user', jsonEncode(user));

          // Navigate back to the home screen
          Navigator.pop(context); // Close the login screen
        } else {
          // Handle errors
          setState(() {
            _errorMessage = 'Invalid username or password';
          });
        }
      } catch (e) {
        // Handle network or server errors
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword; // Toggle password visibility
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword, // Hide password
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48), backgroundColor: Colors.greenAccent, // Button color
                  textStyle: const TextStyle(fontSize: 18), // Button text style
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
