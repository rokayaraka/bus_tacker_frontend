import 'package:bus_tracker/models/bus.dart';
import 'package:bus_tracker/models/other.dart';
import 'package:bus_tracker/providers/get_providers.dart';
import 'package:bus_tracker/screens/home.dart';
import 'package:bus_tracker/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewSchedule extends ConsumerStatefulWidget {
  const ViewSchedule({super.key, required this.userID});
  final String userID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewScheduleState();
}

class _ViewScheduleState extends ConsumerState<ViewSchedule> {
  String? _selectedTime;
  String? _selectedRoute;
  List<BusModel> _busList = [];
  List<RouteModel> _routes = [];
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
                    "View Schedule",
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
                      ),
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
                      "Select Time",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final timeAsync = ref.watch(fetchDeparturesProvider);
                        return timeAsync.when(
                          data: (times) {
                            return DropdownButtonFormField<String>(
                              value: _selectedTime,
                              items: times
                                  .map(
                                    (time) => DropdownMenuItem(
                                      value: time.departureTime,
                                      child: Text(
                                        time.departureTime,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedTime = value;
                                });
                              },
                              dropdownColor: Color(0xff053160),
                              icon: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 40,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Color(0xff053160),
                              ),
                            );
                          },
                          loading: () =>
                              CircularProgressIndicator(strokeWidth: 2),
                          error: (err, stack) => Text('Error: $err'),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Select Route",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final routeAsync = ref.watch(fetchRoutesProvider);
                        return routeAsync.when(
                          data: (routes) {
                            _routes = routes;
                            print(routes.length);
                            return DropdownButtonFormField<String>(
                              value: _selectedRoute,
                              items: routes
                                  .map(
                                    (route) => DropdownMenuItem(
                                      value: route.routeName,
                                      child: Text(
                                        route.routeName,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedRoute = value;
                                });
                              },
                              dropdownColor: Color(0xff053160),
                              icon: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 40,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Color(0xff053160),
                              ),
                            );
                          },
                          loading: () =>
                              CircularProgressIndicator(strokeWidth: 2),
                          error: (err, stack) => Text('Error: $err'),
                        );
                      },
                    ),

                    //elevated button
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            final routeID = _routes
                                .where(
                                  (route) => route.routeName == _selectedRoute,
                                )
                                .first
                                .routeID;
                            if (_selectedRoute != null &&
                                _selectedTime != null) {
                              final buses = await ref.read(
                                fetchBusesProvider([
                                  routeID.toString(),
                                  _selectedTime!,
                                ]).future,
                              );
                              setState(() {
                                _busList = buses;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0DB3C2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            "Browse",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _busList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 30),
                              Text(
                                "Bus Available",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _busList.length,
                                itemBuilder: (context, index) {
                                  final bus = _busList[index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 0,
                                    ),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Color(0xffCDCEF2),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${bus.busName}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                          child: Text(
                                            "View on map",

                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(onPressed: (){

                              }, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff91A908),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              child: Text("Set Reminder",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                              ),
                              ),
                              // SizedBox(height: 10),
                               ElevatedButton(onPressed: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home(userID: widget.userID)));
                              }, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff0A3C61),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              child: Text("Return To Home",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )
                              ),
                              ),
                              SizedBox(height: 10),

                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(height: 80),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/nodata.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                    Positioned(
                                      left: 50,
                                      bottom: 0,
                                      child: Text(
                                        "No Data!",
                                        style: TextStyle(
                                          fontSize: 30,

                                          color: Color(0xff615C5C),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
