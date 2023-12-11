import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:my_project/src/features/authentification/screens/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: 100,
                height: 100,
              ),
              const Center(
                child: Text(
                  "Bienvenue!\n\nConnectez-vous pour continuer!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LatoFont',
                  ),
                ),
              ),
              const SizedBox(
                width: 100,
                height: 80,
              ),
              Column(
                children: [
                  ElevatedButton.icon(
                    icon: Image.asset(
                      "assets/images/google.png",
                      height: 25.0,
                      width: 25.0,
                    ),
                    label: Text(
                      'Se connecter avec Google',
                      style: TextStyle(color: Colors.black87, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200],
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                    ),
                    onPressed: () async {
                      //Provider.of<LoginController>(context , listen: false).googleLogin();
                      print("I'm Google and i'm pressed");
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/images/facebook.jpg',
                      height: 25.0,
                      width: 25.0,
                    ),
                    label: Text(
                      'Se connecter avec Facebook',
                      style: TextStyle(color: Colors.black87, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200],
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Ou bien",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              LoginForm(), // Using the extracted LoginForm widget here
            ],
          ),
        ),
      ),
    );
  }
}
