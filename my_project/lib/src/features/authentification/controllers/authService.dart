import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/src/features/authentification/controllers/reservationController.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';
import 'package:my_project/src/features/authentification/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:my_project/src/features/authentification/controllers/JWThandler.dart';

class AuthService {
  final JWThandler jwtHandler = JWThandler();


  Future<void> doLogin(String email, String pass, BuildContext context) async {
    String url = "http://10.0.2.2:8000/login";
    Map<String, String> body = {"adresse": email, "mdps": pass};

    try {
      final response = await http.post(Uri.parse(url), body: body);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('jwt', jsonResponse);
        print("Login successful!");

        // Fetch user data using JWThandler
        await jwtHandler.fetchData();
        await jwtHandler.fetchResData();

        // Navigate to the profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      } else {
        // Show error message to user using SnackBar or Dialog
        final errorMessage = "Email ou password invalid . Veuillez ressayer.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage),
            backgroundColor: Colors.red,),
        );

        print("Login failed. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      // Show error message to user using SnackBar or Dialog
      final errorMessage = "An error occurred. Please try again later.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage),
          backgroundColor: Colors.red,),
      );

      print("Error occurred: $e");
    }
  }

  Future<void> doSignup(String email, String password , String nom , BuildContext context) async {
    String url = "http://10.0.2.2:8000/signup";
    Map<String, String> body = {
      "adresse": email,
      "mdps": password,
      "nom": nom,
      "imageUrl" : "image"
    };

    try {
      final response = await http.post(Uri.parse(url), body: body);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201) {
        var jsonResponse = response.body;

        await doLogin(email, password, context);
      } else {
        print("Signup failed. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        // Handle signup failure, show error to user if needed
      }
    } catch (e) {
      print("Error occurred: $e");
      // Handle error, show error to user if needed
    }
  }



}