import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final String apiUrl = 'http://localhost:5000/api/v1/train/notifications';

  Future<Map<String, dynamic>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("$apiUrl/"),
      headers: {
        'Authorization': '$token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('notifications')) {
        final Map<String, dynamic> notifications =
            responseBody['notifications'];
        List<Map<String, dynamic>> trainList = [];

        notifications.forEach((key, value) {
          trainList.add(value);
        });

        return {"success": true, "data": trainList};
      } else {
        return {
          "success": false,
          "message": "No notifications data found",
        };
      }
    } else {
      return {
        "success": false,
        "message": jsonDecode(response.body)["message"] ?? "Unknown error",
      };
    }
  }
}
