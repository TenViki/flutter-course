import 'package:dio/dio.dart';
import "package:jwt_decoder/jwt_decoder.dart";
import 'package:netglade_onboarding/models/user.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<Map<String, String>> authenticate(
      String username, String password) async {
    final response = await _dio.post('/login', data: {
      'username': username,
      'password': password,
    });

    print("Authenticated");

    if (response.statusCode == 200) {
      print("AUTH RESPONSE");
      print(response.data);
      return {
        'token': response.data['token'],
        'expiration': response.data['expiration'],
      };
    } else {
      print(response);
      throw Exception('Failed to authenticate');
    }
  }

  Future<void> register(String username, String email, String password) async {
    final response = await _dio.post('/register', data: {
      'username': username,
      'email': email,
      'password': password,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to register');
    }
  }

  Future<User> getUser(String token) async {
    Map<String, dynamic> decoded = JwtDecoder.decode(token);

    final username =
        decoded["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"];
    final email = decoded[
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"];
    final id = decoded[
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];

    return User(username: username, email: email, id: id);
  }

  Future<void> logout(String token) async {
    // send logout request
  }
}
