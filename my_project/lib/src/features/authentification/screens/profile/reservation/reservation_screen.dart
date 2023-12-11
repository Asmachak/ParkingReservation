import 'package:flutter/material.dart';
import 'package:my_project/src/common_widgets/outlined_button.dart';
import 'package:my_project/src/features/authentification/controllers/JWThandler.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';
import 'package:my_project/src/features/authentification/screens/profile/reservation/reservation_list.dart';
import 'package:my_project/src/features/authentification/screens/profile/reservation/reserver_parking.dart';
import 'package:my_project/src/features/authentification/screens/profile/reservation/timer_reservation.dart';

class ReservationSection extends StatefulWidget {
    const ReservationSection({
    Key? key,
  }) : super(key: key);

  @override
  _ReservationSectionState createState() => _ReservationSectionState();
}

class _ReservationSectionState extends State<ReservationSection> {
  int _selectedButtonIndex = 0;
  final JWThandler jwtHandler = JWThandler();
  List<Reservation> liste = [];

  @override
  void initState() {
    super.initState();
    fetchReservationData();
  }

  Future<void> fetchReservationData() async {
    try {
      final reservations = await JWThandler().fetchResData();
      if (reservations != null) {
        setState(() {
          liste = reservations;
        });
        print(reservations[0].parking);
        print(liste[0].parking);
        print(liste[0].user?.nom);

      }
    } catch (e) {
      print("Error fetching reservation data: $e");
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              children: [
                Text(
                  'Mes Réservations',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(90.0, 0, 0, 0),
                  child: Icon(
                    Icons.history,
                    size: 35.0,
                  ),
                )
              ],
            ),
          ),

          // Use the reservationsList passed from AuthService
        ReservationList(listees: liste),

         Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Reserver_parking()),
              );},
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.indigo[50]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide.none,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Réserver un parking",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
