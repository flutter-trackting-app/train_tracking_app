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

  List<dynamic> trainSchedules = [];

  Future<List<dynamic>> fetchSchedules() async {
    final scheduleService = ScheduleService();
    final response = await scheduleService.getSchedules();
    await Future.delayed(Duration(seconds: 1));

    if (response["success"]) {
      List<dynamic> schedules = response["data"];
      return schedules;
    } else {
      Fluttertoast.showToast(
        msg: response["message"] ?? "Operation failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch the schedules asynchronously
    _loadSchedules();
  }

  // Function to load the schedules
  Future<void> _loadSchedules() async {
    List<dynamic> schedules = await fetchSchedules();
    setState(() {
      trainSchedules = schedules; // Update trainSchedules with the fetched data
    });
  }

  Future<SharedPreferences> getLocalStorage() async {
    return SharedPreferences.getInstance();
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
                                                train['delay_time'].toString()!,
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
                                  'Origin: ${train['origin']}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  'Destination: ${train['destination']}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  'Start Time: ${train['departureTime']}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                // Text(
                                //   'End Time: ${train['endTime']}',
                                //   style: const TextStyle(color: Colors.grey),
                                // ),
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
