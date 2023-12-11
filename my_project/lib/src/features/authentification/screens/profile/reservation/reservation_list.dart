import 'package:flutter/material.dart';
import 'package:my_project/src/common_widgets/outlined_button.dart';
import 'package:my_project/src/features/authentification/models/parking.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';
import 'package:my_project/src/features/authentification/screens/profile/reservation/ticket.dart';
import 'package:my_project/src/features/authentification/screens/profile/reservation/timer_reservation.dart';

class ReservationList extends StatefulWidget {
  final List<Reservation> listees;
  //final Function(String) onCardTap;


  const ReservationList({
    Key? key,
    required this.listees,
    //required this.onCardTap,
  }) : super(key: key);

  @override
  State<ReservationList> createState() => _ReservationList();
}

class _ReservationList extends State<ReservationList> {
  int _selectedButtonIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });
  }

  void _onMinuterieButtonPressed(int index) {
    final selectedReservation = widget.listees[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimerReservation(reservation: selectedReservation),
      ),
    );
  }


  void _onTicketButtonPressed(int index) {
    final selectedReservation = widget.listees[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketReservation(reservation: selectedReservation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.listees.length,
        itemBuilder: (context, index) {
          final imageUrl = widget.listees[index].parking?.imageParking ?? '';
          if (imageUrl == null) {
            return Container();
          }
          return InkWell(
            //onTap: () => widget.onCardTap(widget.listees[index].parking!.nomParking ?? 'Unknown'),
            onTap: () {
              print(widget.listees[index].parking);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 130,
                            width: 130,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 8),
                                child: Text(
                                  widget.listees[index].parking!.nomParking ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                                child: Text(
                                  "adresse parking",
                                 // widget.listees[index].parking!.adresseParking!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 8,
                      endIndent: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed:() => _onMinuterieButtonPressed(index) ,
                          style: OutlinedButton.styleFrom(
                            backgroundColor:  Colors.indigo,
                            side: BorderSide(
                              color: Colors.indigo,
                              width: 2.0,
                            ),
                            primary:  Colors.white10 ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            "Voir Minuterie",
                            style: TextStyle(
                              fontSize: 20,
                              color:Colors.white,
                            ),
                          ), ),
                        OutlinedButton(
                          onPressed:() => _onTicketButtonPressed(index) ,
                          style: OutlinedButton.styleFrom(
                            backgroundColor:  Colors.white10,
                            side: BorderSide(
                              color: Colors.indigo,
                              width: 2.0,
                            ),
                            primary:  Colors.indigo ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            "Voir ticket",
                            style: TextStyle(
                              fontSize: 20,
                              color:Colors.indigo,
                            ),
                          ), )
                      ],
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}