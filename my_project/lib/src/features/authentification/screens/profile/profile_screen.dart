import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';
import 'package:my_project/src/features/authentification/models/user.dart';
import 'package:my_project/src/features/authentification/controllers/JWThandler.dart';
import 'package:my_project/src/features/authentification/screens/login/login_screen.dart';
import 'package:my_project/src/features/authentification/screens/profile/home/Home_screen.dart';
import 'package:my_project/src/features/authentification/screens/profile/modification/modify_screen.dart';
import 'package:my_project/src/features/authentification/screens/profile/profile_screen_section.dart';
import 'package:my_project/src/features/authentification/screens/profile/reservation/reservation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserDetails user = UserDetails('', '', '');
  int _selectedIndex = 0;
  final JWThandler jwtHandler = JWThandler();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> doLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }

  void _onAvatarTap() async {
    setState(() {
      _selectedIndex = 2; // Assuming the ProfileSection is at index 2
    });
  }

  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the page is initially loaded
  }

 void _fetchUserData() async {
    try {
      final token = await jwtHandler.getToken();

      if (token != null) {
        final decodedToken = await jwtHandler.getDecodedToken(token);

        if (decodedToken.isNotEmpty) {
          final userName = decodedToken['nom'];
          final userEmail = decodedToken['adresse'];
          final userImageUrl = decodedToken['imageUrl'];

          setState(() {
            user = UserDetails(userName, userEmail, userImageUrl);
          });

          print(user.photoURL);
        }
      } else {
        print("Token not available");
      }
    } catch (e) {
      print("Error fetching data: $e");
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                if (_selectedIndex == 0 || _selectedIndex == 2) // Render header only on the home page and profile page
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 10, 0, 0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: _onAvatarTap,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    "https://static.vecteezy.com/system/resources/previews/011/675/374/original/man-avatar-image-for-profile-png.png",
                                    width: 60.0,
                                    height: 60.0,
                                  ),
                                ),
                                if (_selectedIndex == 2)
                                  Positioned(
                                    bottom: -15,  // Adjust this value for proper alignment
                                    right: 0,
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 25.0, 50.0, 0.0),
                            child: Column(
                              children: [
                                Text(
                                  user.nom ?? '',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'RubikFont',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                  height: 10,
                                ),
                                if (_selectedIndex == 2)
                                  Text(
                                    user.email ?? '',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'RubikFont',
                                      color: Colors.black54,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await doLogout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.logout,
                              color: Colors.black54,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 100,
                  height: 20,
                ),
                Container(
                  width: 350.0,
                  child: Divider(
                    color: Colors.black54,
                    height: 1.0,
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      HomeSection(),
                      ReservationSection(),
                      ProfileSection(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Réservations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
}