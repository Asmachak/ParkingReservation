import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/src/features/authentification/controllers/authService.dart';
import 'package:my_project/src/features/authentification/screens/profile/profile_screen.dart';


class signupForm extends StatefulWidget {
  const signupForm({super.key});

  @override
  State<signupForm> createState() => _signupFormState();
}

class _signupFormState extends State<signupForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomController = TextEditingController();

  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = AuthService(); // Initialize the authService here
  }


  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez entrer un nom.";
    } else if (value.length < 4) {
      return "Le nom doit avoir une longueur minimale de 4 caractères.";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez entrer un mot de passe.";
    } else if (value.length < 8 ) {
      return "Le mot de passe doit avoir au moins 8 caractères.";
    } else if (value != passwordController.text) {
      return "Les mots de passe ne correspondent pas.";
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0,15.0,25.0,15.0),
            child: Column(
                children: [
                  TextFormField(
                    controller: nomController,
                    validator: _validateName,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Entrer votre nom et prénom',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) => EmailValidator.validate(value!) ? null : "SVP entrer un email valid ",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Entrer votre email',
                      prefixIcon  : const Icon(Icons.email),
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
                    // mdps validator
                    validator: _validatePassword,
                    maxLines: 1,
                    obscureText: !_showPassword, // indique que le contenu du champ de saisie doit être masqué
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Entrer votre password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword; // Inverser l'état de visibilité du mot de passe
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // mdps validator
                    validator: (value) {
                      if (value != passwordController.text) {
                        return "Les mots de passe ne correspondent pas.";
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: !_showPassword, // indique que le contenu du champ de saisie doit être masqué
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Verifier votre password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword; // Inverser l'état de visibilité du mot de passe
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
                        authService.doSignup(emailController.text, passwordController.text, nomController.text, context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      shape: RoundedRectangleBorder(),
                      backgroundColor: Colors.indigo,
                      side: BorderSide(color: Colors.indigo),
                    ),
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ])));
  }
}
