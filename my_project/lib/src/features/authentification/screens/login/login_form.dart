import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:my_project/src/features/authentification/controllers/JWThandler.dart';
import 'package:my_project/src/features/authentification/controllers/authService.dart';
import 'package:my_project/src/features/authentification/screens/profile/profile_screen.dart';
import 'package:my_project/src/features/authentification/screens/signup/singup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final JWThandler jwtHandler = JWThandler();
  bool _showPassword = false; // State variable for password visibility
  bool isLoading = false;
  var jsonResponse;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService(); // Initialize the authService here
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) =>
              EmailValidator.validate(value!) ? null : "SVP entrer un email valid ",
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'Entrer votre email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'SVP entrer votre password';
                }
                return null;
              },
              maxLines: 1,
              obscureText: !_showPassword, // Use the _showPassword state variable here
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    // Update the _showPassword state when the icon is pressed
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //  dynamic result = await Navigator.pushNamed(context, '/profile');
                  authService.doLogin(emailController.text, passwordController.text, context);
                }
               /*Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) {
                  return const ProfilePage();
                },
                ));*/
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.indigo,
                side: BorderSide(color: Colors.indigo),
              ),
              child: const Text(
                'Se Connecter',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous n'étes pas inscrit ?",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    _formKey.currentState?.reset();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Signup();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
