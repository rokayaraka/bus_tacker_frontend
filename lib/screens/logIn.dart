import 'package:bus_tracker/models/logInmodel.dart';
import 'package:bus_tracker/providers/auth.dart';
import 'package:bus_tracker/screens/home.dart';
import 'package:bus_tracker/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogIn extends ConsumerStatefulWidget {
  const LogIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  final controller = TextEditingController();
  final controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFF9),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
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
                "Login",
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: Text("forget password?"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          final userID = controller.text;
                          final password = controller1.text;
                          final success = await ref.read(
                            loginProvider(
                              LoginParams(userID, password),
                            ).future,
                          );
                          if (success.status==true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('logged in Successful'),
                              ),
                              
                            );
                            // ref.read(userID.notifier).state=success.userID!;
                            print(success.userID!);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home(userID: success.userID!)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login Failed')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0DA3BD),
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: Text("or Register"),
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
