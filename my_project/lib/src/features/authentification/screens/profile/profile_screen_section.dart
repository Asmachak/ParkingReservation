import 'package:flutter/material.dart';
import 'package:my_project/src/features/authentification/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {

  Map<String, IconData> iconMap = {
    "paiement": Icons.payment,
    "vehicules": Icons.drive_eta_rounded,
    "Conducteurs": Icons.person,
    "réclamations": Icons.report,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded( // Wrap ListView.builder with an Expanded widget
              child: ListView.builder(
                itemCount: iconMap.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = iconMap.keys.elementAt(index);
                  IconData value = iconMap[key]!;

                  return Container(
                    height: 80,
                    child: ListTile(
                      leading: Icon(value , color: Colors.indigo,),
                      title: Text(key , style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20 ,
                        fontFamily: 'RubikFont',
                      ),),
                      trailing: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(key),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), // Make the button circular
                          padding: EdgeInsets.all(10), // Adjust padding for the circular shape
                          backgroundColor: Colors.grey[200],
                        ),
                        child: Icon(Icons.expand_more, color: Colors.black), // Display an icon inside the circular button
                      ),

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String itemName;

  DetailsScreen(this.itemName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName + " Details"),
      ),
      body: Center(
        child: Text("Details of $itemName"),
      ),
    );
  }
}