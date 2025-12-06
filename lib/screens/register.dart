import 'package:bus_tracker/models/logInmodel.dart';
import 'package:bus_tracker/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final controller = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFF9),
     appBar: AppBar(
        backgroundColor: Color(0xffFFFFF9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Text(
                "DIU",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Bus ',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Tracker ',
                      style: TextStyle(
                        color: Color(0xff0C3F0F),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Opacity(
                opacity: 0.4,
                child: Image.asset(
                  "assets/bus.jpg",
                  height: 300,
                  width: double.infinity,
                ),
              ),
              Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User ID:",
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
                        fillColor: Color(0xffFCFED3),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Password:",
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
                        fillColor: Color(0xffFCFED3),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Confirm Password:",
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
                        fillColor: Color(0xffFCFED3),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          final userID = controller.text;
                          final password = controller1.text;
                          final confirmPassword = controller2.text;
                          if (password != confirmPassword) {
                           ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Passwords do not match'),
                              ),
                            );
                            return;
                          }
                          final success = await ref.read(
                            registerProvider(
                              LoginParams(userID, password),
                            ).future,
                          );
                          if (success) {
                           ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration Successful'),
                              ),
                              
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration Failed'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff6A9F4C),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          side: BorderSide(width: 1.0, color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
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
