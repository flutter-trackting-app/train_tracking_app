import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  final List<Map<String, String>> trainSchedules = [
    {
      'trainName': 'Express Line 1',
      'startTime': '08:00 AM',
      'endTime': '10:00 AM',
      'estimatedDeparture': '07:45 AM',
      'delayed': "true",
      'delay_time': "15 min"
    },
    {
      'trainName': 'Rapid Transit',
      'startTime': '09:30 AM',
      'endTime': '11:30 AM',
      'estimatedDeparture': '09:15 AM',
      'delayed': "true",
      'delay_time': "30 min"
    },
    {
      'trainName': 'City Connector',
      'startTime': '12:00 PM',
      'endTime': '02:00 PM',
      'estimatedDeparture': '11:45 AM',
      'delayed': "false",
      'delay_time': "0"
    },
    {
      'trainName': 'Sunrise Express',
      'startTime': '05:00 PM',
      'endTime': '07:00 PM',
      'estimatedDeparture': '04:45 PM',
      'delayed': "true",
      'delay_time': "10 min"
    },
    {
      'trainName': 'Express Line 1',
      'startTime': '08:00 AM',
      'endTime': '10:00 AM',
      'estimatedDeparture': '07:45 AM',
      'delayed': "false",
      'delay_time': "0"
    },
    {
      'trainName': 'Rapid Transit',
      'startTime': '09:30 AM',
      'endTime': '11:30 AM',
      'estimatedDeparture': '09:15 AM',
      'delayed': "false",
      'delay_time': "0"
    },
    {
      'trainName': 'City Connector',
      'startTime': '12:00 PM',
      'endTime': '02:00 PM',
      'estimatedDeparture': '11:45 AM',
      'delayed': "false",
      'delay_time': "0"
    },
    {
      'trainName': 'Sunrise Express',
      'startTime': '05:00 PM',
      'endTime': '07:00 PM',
      'estimatedDeparture': '04:45 PM',
      'delayed': "true",
      'delay_time': "45 min"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // Use Expanded widget to take the remaining height
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: trainSchedules.length,
                itemBuilder: (context, index) {
                  final train = trainSchedules[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  train['trainName']!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                train['delayed'] == "true"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.lock_clock,
                                            size: 30,
                                            color: Colors.redAccent,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            train['delay_time']!,
                                            style: const TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Start Time: ${train['startTime']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'End Time: ${train['endTime']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Estimated Departure: ${train['estimatedDeparture']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
