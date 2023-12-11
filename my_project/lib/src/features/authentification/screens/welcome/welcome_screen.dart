import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:my_project/src/features/authentification/screens/login/login_screen.dart';
import 'package:my_project/src/features/authentification/screens/signup/singup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage("assets/images/welcome.png"),
                height: height * 0.4,
              ),
              Center(
                child: Text(
                  "Bienvenue dans notre application",
                  textAlign: TextAlign.center, // Correctly set the textAlign property
                  style: GoogleFonts.roboto(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              /*Text(
                "Réserver votre place et Surveiller votre voiture en toute sécurité",
                textAlign: TextAlign.center, // Correctly set the textAlign property
                style: GoogleFonts.roboto(
                  fontSize: 15.0,
                ),
              ),*/
              Padding(
              padding: const EdgeInsets.fromLTRB(30.0,50,30,50),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                        },
                        child: Text(
                          "Se Connecter",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          foregroundColor: Colors.indigo,
                          side: BorderSide(color: Colors.indigo),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                        },
                        child: Text("S'inscrire"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Colors.indigo,
                          side: BorderSide(color: Colors.indigo),
                          padding: EdgeInsets.symmetric(vertical: 15),
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
