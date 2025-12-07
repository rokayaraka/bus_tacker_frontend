import 'package:bus_tracker/models/reportModel.dart';
import 'package:bus_tracker/providers/get_providers.dart';
import 'package:bus_tracker/widgets/notification.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Report extends ConsumerStatefulWidget {
  const Report({super.key, required this.userID});
  final String userID;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportState();
}

class _ReportState extends ConsumerState<Report> {
  final controller = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  // Remove controller3, use dropdown for department
  String? _selectedDepartment;
  final List<String> _departments = [
    'CSE',
    'SWE',
    'EEE',
    'IT',
    'Other',
  ];
  final controller4 = TextEditingController();
  String? _selectedFileName;
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
                    "Report Issue",
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
                      "First Name    *",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Last Name   *",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),

                    TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Email    *",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),

                    TextField(
                      controller: controller2,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                    Text(
                      "Department    *",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),

                    DropdownButtonFormField<String>(
                      value: _selectedDepartment,
                      items: _departments
                          .map((dept) => DropdownMenuItem(
                                value: dept,
                                child: Text(dept),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDepartment = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                      
                    ),
                    Text(
                      "Description    *",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),

                    TextField(
                      controller: controller4,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                    Text(
                      "Attachment",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),

                    Container(
                      height: 80,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedFileName ?? "Drop files here or,",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final result = await FilePicker.platform
                                  .pickFiles();
                              if (result != null && result.files.isNotEmpty) {
                                setState(() {
                                  _selectedFileName = result.files.single.name;
                                });
                              }
                            },
                            child: Text(
                              "browse",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                          final success = await ref.read(
                            submitReportProvider(
                              ReportModel(userID: widget.userID, firstName: controller.text, lastName: controller1.text, email: controller2.text, department: _selectedDepartment ?? '', issueDescription: controller4.text, attachment: _selectedFileName ?? ''),
                            ).future,
                          );
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('submitted Successful'),
                              ),
                            );
                            // ref.read(userID.notifier).state=success.userID!;
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Submission Failed')),
                            );
                          }
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff053160),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            "Report",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 15),
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
