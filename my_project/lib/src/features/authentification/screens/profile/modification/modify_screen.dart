import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/src/common_widgets/date_picker.dart';
import 'package:my_project/src/common_widgets/drop_down_widget.dart';
import 'package:my_project/src/features/authentification/controllers/parkingController.dart';
import 'package:my_project/src/features/authentification/models/parking.dart';

final parkingDataProvider = FutureProvider<Parking?>((ref) async {
  return ref.watch(parkingControllerProvider).getParkings();
});
class ModifyScreen extends StatefulWidget {
  const ModifyScreen({super.key});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  final TextEditingController emailController = TextEditingController(text: 'Initial Value');
  final TextEditingController nameController = TextEditingController(text: 'Initial Value');
  final TextEditingController phoneController = TextEditingController(text: 'Initial Value');
  final TextEditingController adresseController = TextEditingController(text: 'Initial Value');
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;

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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Modifier mon profile" ,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20 ,
                          fontFamily: 'RubikFont',
                        ),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: Image.network(
                        "https://static.vecteezy.com/system/resources/previews/011/675/374/original/man-avatar-image-for-profile-png.png",
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                      Positioned(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ModifyScreen();
                                },
                              ),
                            );
                            // Handle photo modification here
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: Colors.indigo,
                            padding: EdgeInsets.all(5),
                            minimumSize: Size(25, 25),
                          ),
                          child: Icon(Icons.edit, color: Colors.white , size: 15,),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              MyDropdownButton(
                items: {
                  'Professionel': Icons.business,
                  'Personnel': Icons.person,
                },
              ),
              SizedBox( height: 10,),
              Container(
                width: screenWidth * 0.9,
                child: TextFormField(
                  controller: emailController,
                  validator: (value) =>
                  EmailValidator.validate(value!) ? null : "SVP entrer un email valide",
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Entrer votre email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust the padding here
                  ),
                ),
              ),
              SizedBox( height: 10,),
              Container(
                width: screenWidth * 0.9,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Entrer votre nom',
                    prefixIcon: const Icon(Icons.person_2_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust the padding here
                  ),
                ),
              ),
              SizedBox( height: 10,),
              Container(
                width: screenWidth * 0.9,
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'Entrer votre numéro',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust the padding here
                  ),
                ),
              ),
              SizedBox( height: 10,),
              MyDropdownButton(
                items: {
                  'Homme': Icons.man,
                  'Femme': Icons.woman,
                },
              ),
              SizedBox( height: 10,),
              //DatePicker(),
              SizedBox( height: 10,),
              Container(
                width: screenWidth * 0.9,
                child: TextFormField(
                  controller: adresseController,
                  decoration: InputDecoration(
                    hintText: 'Entrer votre adresse',
                    prefixIcon: const Icon(Icons.place),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust the padding here
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.9,
                child: TextFormField(
                  controller: passwordController,
                  // mdps validator
                  validator: _validatePassword,
                  maxLines: 1,
                  obscureText: !_showPassword, // indique que le contenu du champ de saisie doit être masqué
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Entrer votre ancien password',
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.9,
                child: TextFormField(
                  controller: passwordController,
                  // mdps validator
                  validator: _validatePassword,
                  maxLines: 1,
                  obscureText: !_showPassword, // indique que le contenu du champ de saisie doit être masqué
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Entrer votre nouveau password',
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
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.9,
                child: TextFormField(
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
                    hintText: 'Confirmer votre password',
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
              ),
              const SizedBox(height: 10.0,),
              ElevatedButton(
                onPressed: () {
                  print("Modifer profile pressed");
                },
                child: Text("Modifier votre profile" ,
                style: TextStyle(
                  fontSize: 20,
                ),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.indigo,
                  side: BorderSide(color: Colors.indigo),
                  padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 20),

                ),
              ),
              const SizedBox(height: 10.0,),



            ],
          ),
        ),
      ),
    );
  }
}
