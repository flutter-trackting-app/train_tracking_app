import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<Map<String, String>> trainSchedules = [
    {
      'trainName': 'Express Line 1',
      'startTime': '08:00 AM',
      'endTime': '10:00 AM',
      'estimatedDeparture': '07:45 AM',
    },
    {
      'trainName': 'Rapid Transit',
      'startTime': '09:30 AM',
      'endTime': '11:30 AM',
      'estimatedDeparture': '09:15 AM',
    },
    {
      'trainName': 'City Connector',
      'startTime': '12:00 PM',
      'endTime': '02:00 PM',
      'estimatedDeparture': '11:45 AM',
    },
    {
      'trainName': 'Sunrise Express',
      'startTime': '05:00 PM',
      'endTime': '07:00 PM',
      'estimatedDeparture': '04:45 PM',
    },
    {
      'trainName': 'Express Line 1',
      'startTime': '08:00 AM',
      'endTime': '10:00 AM',
      'estimatedDeparture': '07:45 AM',
    },
    {
      'trainName': 'Rapid Transit',
      'startTime': '09:30 AM',
      'endTime': '11:30 AM',
      'estimatedDeparture': '09:15 AM',
    },
    {
      'trainName': 'City Connector',
      'startTime': '12:00 PM',
      'endTime': '02:00 PM',
      'estimatedDeparture': '11:45 AM',
    },
    {
      'trainName': 'Sunrise Express',
      'startTime': '05:00 PM',
      'endTime': '07:00 PM',
      'estimatedDeparture': '04:45 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Homepage'),
      // ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: trainSchedules.length,
        itemBuilder: (context, index) {
          final train = trainSchedules[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    train['trainName']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Start Time: ${train['startTime']}'),
                  Text('End Time: ${train['endTime']}'),
                  Text('Estimated Departure: ${train['estimatedDeparture']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
