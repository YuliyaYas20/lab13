import 'package:flutter/material.dart';
import 'api_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = ApiService();

  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Message'),
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),

                  // Поле 1: Ім'я
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'User Name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Поле обов'язкове до заповнення";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Поле 2: Email / Login
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email / Login',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Поле обов'язкове до заповнення";
                      }
                      if (!_emailRegex.hasMatch(value.trim())) {
                        return 'Введіть коректну адресу email (напр. user@mail.com)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Поле 3: Пароль
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Поле обов'язкове до заповнення";
                      }
                      if (value.length < 7) {
                        return 'Пароль повинен містити не менше 7 символів';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _apiService.signUp(
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text,
                          );
                          if (!context.mounted) return;
                          _showMessage(context, 'Registration successful');
                        } catch (e) {
                          if (!context.mounted) return;
                          _showMessage(context, 'Помилка відправки: $e');
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 8),

                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}