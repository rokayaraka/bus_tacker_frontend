import 'package:bus_tracker/models/bus.dart';
import 'package:bus_tracker/providers/get_providers.dart';
import 'package:bus_tracker/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveTrack extends ConsumerStatefulWidget {
  const LiveTrack({super.key, required this.userID, required this.bus});
  final String userID;
  final BusModel bus;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiveTrackState();
}

class _LiveTrackState extends ConsumerState<LiveTrack> {
  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final buses = await ref.read(fetchBusesProvider([]).future);
    setState(() {
      busList = buses;
    });
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back, size: 30),
                  ),
                  Text(
                    "Live Track",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  NotificationButton(),
                  Column(
                    children: [
                      Icon(Icons.person, size: 30, color: Colors.deepPurple),
                      Text(
                        widget.userID,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xffFEFEC3),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bus Information",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.bus.busName}-   ${widget.bus.busNumber}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Route: ${widget.bus.route}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Capacity: ${widget.bus.capacity}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}