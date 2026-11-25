import 'package:dio/dio.dart';

class ApiService {
  static const String _baseUrl = 'https://lab13yaskovets.requestcatcher.com/test';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<void> login(String login, String password) async {
    await _dio.post(
      '/login',
      data: {
        'action': 'login',
        'login': login,
        'password': password,
      },
    );
  }

  Future<void> signUp(String userName, String email, String password) async {
    await _dio.post(
      '/signup',
      data: {
        'action': 'signup',
        'userName': userName,
        'email': email,
        'password': password,
      },
    );
  }

  Future<void> resetPassword(String loginOrEmail) async {
    await _dio.post(
      '/reset-password',
      data: {
        'action': 'reset_password',
        'loginOrEmail': loginOrEmail,
      },
    );
  }
}