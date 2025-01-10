import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleService {
  final String apiUrl = 'http://localhost:5000/api/v1/train';

  Future<Map<String, dynamic>> addTrain(Map<String, String> trainData) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse("$apiUrl/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      },
      body: json.encode(trainData),
    );

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonDecode(response.body)};
    } else {
      return {
        "success": false,
        "message": jsonDecode(response.body)["message"]
      };
    }
  }

  Future<Map<String, dynamic>> getSchedules() async {
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
      if (responseBody.containsKey('trains')) {
        final Map<String, dynamic> trains = responseBody['trains'];
        List<Map<String, dynamic>> trainList = [];

        trains.forEach((key, value) {
          trainList.add(value);
        });

        return {"success": true, "data": trainList};
      } else {
        return {
          "success": false,
          "message": "No trains data found",
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
