import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/src/features/authentification/models/parking.dart';
import 'package:my_project/src/features/authentification/screens/profile/home/Home_screen.dart';
import 'package:my_project/src/features/authentification/screens/profile/profile_screen.dart';
class MyData {
  final String imageUrl;
  final String title;

  MyData(this.imageUrl, this.title);
}
class DetailsParking extends StatefulWidget {
  final Parkings parking ;
  const DetailsParking({Key? key, required this.parking}) : super(key: key);

  @override
  State<DetailsParking> createState() => _DetailsParkingState();
}

class _DetailsParkingState extends State<DetailsParking> {
  @override
  Widget build(BuildContext context) {
    double widthScr = MediaQuery.of(context).size.width ;
    double heightScr = MediaQuery.of(context).size.height ;
    final List<MyData> myList = [
    MyData("assets/images/icon1.png", "Gonfleurs de panne 1"),
    MyData("assets/images/icon2.png", "Gonfleurs de panne 2"),
    MyData("assets/images/icon3.png", "Gonfleurs de panne 3"),
      MyData("assets/images/icon4.png", "Gonfleurs de panne 3"),
      MyData("assets/images/icon5.png", "Gonfleurs de panne 3"),
    // Ajoutez plus d'éléments à votre liste ici
    ];

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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
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
                            "Details Parking",
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
                padding: const EdgeInsets.fromLTRB(8.0,15,8,8),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      image: NetworkImage(widget.parking.imageParking!,),
                      width: widthScr * 0.9,

                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0,0,0,0),
                  child: Text(
                    widget.parking.nomParking!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "Poppins"
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0,0,0,0),
                  child: Text(
                    widget.parking.adresseParking!,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        color: Colors.grey
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      OutlinedButton(
                        onPressed:() {} ,
                        style: OutlinedButton.styleFrom(
                          backgroundColor:  Colors.white10,
                          side: BorderSide(
                            color: Colors.indigo,
                            width: 2.0,
                          ),
                          primary:  Colors.white10 ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.room , color: Colors.indigo,),
                            Text(
                              "2.7 km",
                              style: TextStyle(
                                fontSize: 20,
                                color:Colors.indigo,
                              ),
                            ),
                          ],
                        ), ),
                      SizedBox(width: 10,),
                      OutlinedButton(
                        onPressed:() {} ,
                        style: OutlinedButton.styleFrom(
                          backgroundColor:  Colors.white10,
                          side: BorderSide(
                            color: Colors.indigo,
                            width: 2.0,
                          ),
                          primary:  Colors.white10 ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time_filled , color: Colors.indigo,),
                            Text(
                              "24h/24 , 7/7",
                              style: TextStyle(
                                fontSize: 20,
                                color:Colors.indigo,
                              ),
                            ),
                          ],
                        ), ),
                      SizedBox(width: 10,),
                      OutlinedButton(
                        onPressed:() {} ,
                        style: OutlinedButton.styleFrom(
                          backgroundColor:  Colors.white10,
                          side: BorderSide(
                            color: Colors.indigo,
                            width: 2.0,
                          ),
                          primary:  Colors.white10 ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.directions_car_filled , color: Colors.indigo,),
                            Text(
                              "Voitures ",
                              style: TextStyle(
                                fontSize: 20,
                                color:Colors.indigo,
                              ),
                            ),
                          ],
                        ), ),

                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0,0,0,0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: "Poppins"
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0,0,0,0),
                  child: Text(
                    widget.parking.description!,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        color: Colors.grey
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                  child: Text(
                    "Services disponibles",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),

              Container(
                  height: 300,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 2, color: Colors.transparent),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(width: 2, color: Colors.indigo),
                            ),
                            child: Image.asset(myList[index].imageUrl, width: 80),
                          ),
                          SizedBox(height: 5), // Espacement entre l'image et le texte
                          Flexible(
                            child: Text(
                              myList[index].title,
                              style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )


              ),


              Accordion(
              maxOpenSections: 2,
              headerBackgroundColorOpened: Colors.black54,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
              AccordionSection(
              isOpen: true,
              headerBackgroundColor: Colors.indigo,
              headerBackgroundColorOpened: Colors.indigo,
              headerBorderRadius: 15,
              header: Text('Entrée dans le parking',style: TextStyle(
                  color: Colors.white , fontSize: 32
              ), ),
              content: Text("_loremIpsum",style: TextStyle(
                  color: Colors.black , fontSize: 20
              ),),
              contentHorizontalPadding: 30,
              contentBorderWidth: 1,
              // onOpenSection: () => print('onOpenSection ...'),
              // onCloseSection: () => print('onCloseSection ...'),
            ),
              AccordionSection(
                  isOpen: false,
                  headerBackgroundColor: Colors.indigo,
                  headerBackgroundColorOpened: Colors.indigo,
                  header: Text("Heures d'ouverture",style: TextStyle(
                      color: Colors.white , fontSize: 32
                  ), ),
                  content: Text(widget.parking.heureOuverture!,style: TextStyle(
                      color: Colors.black , fontSize: 20
                  ),),
                  contentHorizontalPadding: 30,
                  contentBorderWidth: 1,
                  // onOpenSection: () => print('onOpenSection ...'),
                  // onCloseSection: () => print('onCloseSection ...'),
                ),
              AccordionSection(
                  isOpen: false,
                  headerBackgroundColor: Colors.indigo,
                  headerBackgroundColorOpened: Colors.indigo,
                  header: Text("Tarif sur place ",style: TextStyle(
                      color: Colors.white , fontSize: 32
                  ), ),
                  content: Text('${widget.parking.tarifPlace.toString()} Euro',style: TextStyle(
                      color: Colors.black , fontSize: 20
                  ),  ),
                  contentHorizontalPadding: 30,
                  contentBorderWidth: 1,
                  // onOpenSection: () => print('onOpenSection ...'),
                  // onCloseSection: () => print('onCloseSection ...'),
                ),
                AccordionSection(
                  isOpen: false,
                  headerBackgroundColor: Colors.indigo,
                  headerBackgroundColorOpened: Colors.indigo,
                  header: Text("Tarif abonnement",style: TextStyle(
                      color: Colors.white , fontSize: 32
                  ), ),
                  content: Text("_loremIpsum",style: TextStyle(
                      color: Colors.black , fontSize: 20
                  ),),
                  contentHorizontalPadding: 30,
                  contentBorderWidth: 1,
                  // onOpenSection: () => print('onOpenSection ...'),
                  // onCloseSection: () => print('onCloseSection ...'),
                ),

                    ])
                    ]
          ),
        ),
      ),
    );
  }
}
