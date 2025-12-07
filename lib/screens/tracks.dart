import 'package:bus_tracker/models/bus.dart';
import 'package:bus_tracker/providers/get_providers.dart';
import 'package:bus_tracker/screens/liveTrack.dart';
import 'package:bus_tracker/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Track extends ConsumerStatefulWidget {
  const Track({super.key, required this.userID});
  final String userID;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackState();
}

class _TrackState extends ConsumerState<Track> {
 List<BusModel> busList = [];
 String? _selectedBus;
 BusModel? selectedBus;
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
                    "Track Bus",
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
                      "Select Time",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: DropdownButtonFormField<String>(
                              value: _selectedBus,
                              items: busList
                                  .map(
                                    (route) => DropdownMenuItem(
                                      value: route.busName,
                                      child: Text(
                                        route.busName,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedBus = value;
                                  selectedBus = busList.firstWhere(
                                      (bus) => bus.busName == value);
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
                            ),

                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color:Color(0xffD9D9D9) ,
                            child: IconButton(
                              onPressed: (){
                               if(selectedBus!=null){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LiveTrack(userID: widget.userID,bus: selectedBus!)));
                               }
                               else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select a bus to track.'),
                                  ),
                                );
                               }
                            }, 
                            icon: Icon(Icons.search, size: 30, color: const Color.fromARGB(255, 10, 10, 10),)
                            ),
                          ),
                          ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                    Image.asset(
                      "assets/nodata.png",
                      height: 150,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No data !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 30,

                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
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