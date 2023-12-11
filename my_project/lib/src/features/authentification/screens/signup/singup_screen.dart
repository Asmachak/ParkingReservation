import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/src/features/authentification/screens/signup/signup_form.dart';
import 'package:my_project/src/features/authentification/screens/welcome/welcome_screen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              Row(
                children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,25,0,0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                          size: 40 ),
                        onPressed: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomeScreen()),
                        );
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 100,
                height: 50,
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
              signupForm()]

        ),
      ),
    );
  }


}
