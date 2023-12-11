import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomOutlinedButton extends StatelessWidget {

  final String buttonText; // Le texte à afficher dans le bouton.
  final int buttonIndex; // L'index du bouton pour l'identifier.
  final int selectedButtonIndex; // L'index du bouton sélectionné.
  final Function(int) onButtonPressed; // Fonction appelée lorsque le bouton est pressé.

  const CustomOutlinedButton({
    Key? key,
    required this.buttonText,
    required this.buttonIndex,
    required this.selectedButtonIndex,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onButtonPressed(buttonIndex),
      style: OutlinedButton.styleFrom(
        backgroundColor: selectedButtonIndex == buttonIndex ? Colors.indigo : Colors.white,
        side: BorderSide(
          color: Colors.indigo,
          width: 2.0,
        ),
        primary: selectedButtonIndex == buttonIndex ? Colors.white : Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 20,
          color: selectedButtonIndex == buttonIndex ? Colors.white : Colors.indigo,
        ),
      ),
    );
  }
}