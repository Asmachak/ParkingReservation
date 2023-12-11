import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';


class TimerReservation extends StatefulWidget {
  final Reservation reservation;

  const TimerReservation({Key? key, required this.reservation})
      : super(key: key);

  @override
  State<TimerReservation> createState() => _TimerReservationState();
}


class _TimerReservationState extends State<TimerReservation> {
  //final int duration = 3 * 60 * 60; // 3 hours in seconds


  List<String> questions = [
    "je veux un service" ,
    "je veux faire une reclamation" ,
    "je veux savoir l'état de mon voiture"
  ];



  @override
  Widget build(BuildContext context) {

    DateTime dateTimeEnd = DateTime.parse(widget.reservation!.endDate!);
    DateTime dateTimeStart = DateTime.parse(widget.reservation!.startDate!);
    Duration difference = dateTimeEnd.difference(dateTimeStart);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(Duration.minutesPerHour);
    int seconds = difference.inSeconds.remainder(Duration.secondsPerMinute);
    final int duration = hours * 3600 + minutes*60+ seconds ;

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
                          child: Image(
                            image: AssetImage('assets/images/images.jpg'),
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Minuterie",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "IL VOUS RESTE",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                //fontFamily: 'Poppins',
                              ),
                            ),
                            CountdownTimer(
                              endTime: DateTime.now().millisecondsSinceEpoch +
                                  duration * 1000,
                              widgetBuilder: (_, CurrentRemainingTime? time) {
                                if (time == null) {
                                  // Timer has finished
                                  return Text('Countdown Complete');
                                }

                                // Format the remaining time
                                final String hours =
                                '${time.hours}'.padLeft(2, '0');
                                final String minutes =
                                '${time.min}'.padLeft(2, '0');
                                final String seconds =
                                '${time.sec}'.padLeft(2, '0');

                                // Display the remaining time
                                return Text(
                                  '$hours:$minutes:$seconds',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: 52, width: 353),
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Prolonger la réservation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      // fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width : 300.0,
                child: Divider(
                  color: Colors.black,
                  height: 1.0,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10.0, 20.0, 10.0, 10.0),
                        child: Image.asset(
                          'assets/images/chatbot.png',
                          width: 120.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Bonjour! Comment puis-je vous aider aujourd'hui?",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPage(),
                              ),
                            );
                          },
                          child : Padding(
                            padding: const EdgeInsets.all(5.0),
                            child:Bubble(
                              margin: BubbleEdges.only(top: 10),
                              alignment: Alignment.centerRight,
                              nip: BubbleNip.rightTop,
                              color: Colors.indigo, // Change this to the blue color you want
                              child: Text(
                                questions[index],
                                style: TextStyle(color: Colors.white, fontSize: 18.0),
                              ),
                            ),

                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('This is a new page'),
      ),
    );
  }
}







