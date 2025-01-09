import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://localhost:5000/api/v1";

  Future<Map<String, dynamic>> signUp(
      String username, String email, String password, String userRole) async {
    final url = Uri.parse("$baseUrl/register");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userName": username,
          "email": email,
          "password": password,
          "userRole": userRole
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)["message"]
        };
      }
    } catch (error) {
      return {"success": false, "message": error.toString()};
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)["message"]
        };
      }
    } catch (error) {
      return {"success": false, "message": error.toString()};
    }
  }
}
