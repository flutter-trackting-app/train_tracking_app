import 'dart:convert';
import 'package:http/http.dart' as http;

class ScheduleService {
  final String apiUrl = 'http://localhost:5000/api/v1';

  Future<http.Response> addTrain(Map<String, String> trainData) async {
    final response = await http.post(
      Uri.parse("$apiUrl/"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(trainData),
    );
    return response;
  }
}
