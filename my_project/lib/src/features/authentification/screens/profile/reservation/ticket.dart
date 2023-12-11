import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketReservation extends StatefulWidget {
  final Reservation reservation;

  const TicketReservation({Key? key, required this.reservation}) : super(key: key);
  @override
  State<TicketReservation> createState() => _TicketReservationState();
}

class _TicketReservationState extends State<TicketReservation> {
  @override
  Widget build(BuildContext context) {

    double widthScr = MediaQuery.of(context).size.width ;
    double heightScr = MediaQuery.of(context).size.height ;

    DateTime dateTimeEnd = DateTime.parse(widget.reservation!.endDate!);

    String datePartEnd = "${dateTimeEnd.day}/${dateTimeEnd.month}/${dateTimeEnd.year}";

    DateTime dateTimeStart = DateTime.parse(widget.reservation!.startDate!);

    String datePartStart = "${dateTimeStart.day}/${dateTimeStart.month}/${dateTimeStart.year}";

    Duration difference = dateTimeEnd.difference(dateTimeStart);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(Duration.minutesPerHour);
    int seconds = difference.inSeconds.remainder(Duration.secondsPerMinute);

    String formattedDifference = "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";





    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
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
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Voir Ticket",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,20,15,0),
                child: TicketWidget(
                    width: widthScr * 0.8 ,
                    height: heightScr * 0.8,
                    isCornerRounded: true,
                    color: Colors.indigo.shade50,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,20,15,8),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(image: NetworkImage('https://img.abyssale.com/574bfa75-c880-46be-97ae-599473818958'),
                                    width: widthScr * 0.4 ,
                                  ),
                                ),
                              ),
                            ),
                            Text("0455355" ,
                              style: TextStyle(
                                fontSize: 20,
                              ),),
                            SizedBox(
                              height: 45,
                            ),

                            DottedLine(
                              dashLength: 5,
                              dashGapLength: 9,
                              lineThickness: 2,
                              dashColor: Colors.grey,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0,0,15,10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Nom Parking" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text(widget.reservation.parking!.nomParking ?? 'Unknown'
                                        , style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text("Nom" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text("Nom" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0,0,15,10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Vehicule" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text("vehicule" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text("matricule" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text("matricule" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0,0,15,10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Numéro réservation" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text(widget.reservation.idReservation.toString() ?? 'Unknown' , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text("Durée" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text( formattedDifference.toString() , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0,0,15,10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Date Entrée" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text( datePartStart ?? 'Unknown' , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text("Date Sortie" , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                      ),),
                                      Text( datePartEnd ?? 'Unknown' , style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            )


                          ],

                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}