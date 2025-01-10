import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_tracking_app/notifications_page.dart';
import 'package:train_tracking_app/popups/add_schedule_popup.dart';
import 'package:train_tracking_app/services/schedule_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> trainSchedules = [];

  Future<void> fetchSchedules() async {
    final scheduleService = ScheduleService();
    final response = await scheduleService.getSchedules();
    await Future.delayed(Duration(seconds: 1));

    if (response["success"]) {
      List<dynamic> schedules = response["data"];
      setState(() {
        print("Setting schedules...");
        trainSchedules = [
          {
            "delay_time": 16,
            "delayed": "true",
            "departureTime": "11.00pm",
            "destination": "kandy",
            "distance": 50,
            "id": "-OGAYVK7aMIF32HEJNMO",
            "name": "train2",
            "origin": "mathara"
          },
          {
            "delay_time": 50,
            "delayed": "true",
            "departureTime": "5.00pm",
            "destination": "colombo",
            "distance": 30,
            "id": "-OGAcqQmaz7N4UidhHOw",
            "name": "train1",
            "origin": "galle"
          },
          {
            "delay_time": "15",
            "delayed": "true",
            "departureTime": "08:00 AM",
            "destination": "North Point",
            "distance": "120",
            "id": "-OGD0hsd5LEXk6YOQoj7",
            "name": "Express Line 1",
            "origin": "Central Station"
          },
          {
            "delay_time": "",
            "delayed": "false",
            "departureTime": "8.00 AM",
            "destination": "matara",
            "distance": "10",
            "id": "-OGD48MrtYCh8ZP60yR3",
            "name": "test",
            "origin": "galle"
          },
          {
            "delay_time": "30",
            "delayed": "true",
            "departureTime": "10.00 AM",
            "destination": "colombo",
            "distance": "20",
            "id": "-OGDMUu0C4g2kVr41iqh",
            "name": "train 2",
            "origin": "matara"
          }
        ];
        // trainSchedules = schedules.map((schedule) {
        //   return {
        //     'name': schedule['name'],
        //     'startTime': schedule['departureTime'],
        //     'endTime': 'N/A',
        //     'estimatedDeparture': schedule['departureTime'],
        //     'delayed': schedule['delayed'],
        //     'delay_time': schedule['delay_time'].toString(),
        //   };
        // }).toList();
      });
    } else {
      Fluttertoast.showToast(
        msg: response["message"] ?? "Operation failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<SharedPreferences> getLocalStorage() async {
    return SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<SharedPreferences>(
      future: getLocalStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final prefs = snapshot.data!;
          String? token = prefs.getString('token');
          String? userRole = prefs.getString('userRole');

          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: userRole == "admin"
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const AddSchedulePopup(),
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              size: 20,
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationsPage()),
                        );
                      },
                      child: const Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              )),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(token ?? 'Hello User!'),
                    accountEmail: Text(userRole ?? 'user@example.com'),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notifications'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Current Schedules",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(trainSchedules.length.toString()),
                  ),
                  Expanded(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      train['name']!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    train['delayed'] == "true"
                                        ? Row(
                                            children: [
                                              const Icon(
                                                Icons.lock_clock,
                                                size: 30,
                                                color: Colors.redAccent,
                                              ),
                                              const SizedBox(width: 5),
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

        return const Center(child: Text('Unexpected error occurred.'));
      },
    );
  }
}
