import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/src/common_widgets/date_picker.dart';
import 'package:my_project/src/common_widgets/drop_down_widget.dart';
import 'package:my_project/src/common_widgets/time_picker.dart';
import 'package:my_project/src/features/authentification/controllers/JWThandler.dart';
import 'package:my_project/src/features/authentification/controllers/reservationController.dart';
import 'package:my_project/src/features/authentification/models/parking.dart';
import 'package:my_project/src/features/authentification/models/user.dart';
import 'package:my_project/src/features/authentification/screens/profile/home/Home_screen.dart';
import 'package:my_project/src/features/authentification/screens/profile/home/details_parking.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/src/features/authentification/screens/profile/reservation/reservation_screen.dart';
import 'package:intl/intl.dart';

class Reserver_parking extends StatefulWidget {
  const Reserver_parking({super.key});

  @override
  State<Reserver_parking> createState() => _Reserver_parkingState();
}

class _Reserver_parkingState extends State<Reserver_parking> {
  Parkings ? selectedParking;

  DateTime selectedDateEntre = DateTime.now();
  DateTime selectedTimeEntre = DateTime.now();
  DateTime selectedDateSortie = DateTime.now();
  DateTime selectedTimeSortie = DateTime.now();
  String user = "";
  int selectedParkingId = 0;// Initialize with default value



  Future<void> addReservation(String startDate, String endDate, String id_parking, String id_user_res, BuildContext context) async {
    String url = "http://10.0.2.2:8000/reservation";
    Map<String, String> body = {
      "start_date": startDate,
      "end_date": endDate,
      "id_parking_res": id_parking,
      "id_user_res": id_user_res
    };

    try {
      final response = await http.post(Uri.parse(url), body: body);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201) {
        var jsonResponse = response.body;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reservation added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print("add parking failed. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reservation failed to be added !'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reservation failed to be added !'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  final JWThandler jwtHandler = JWThandler();
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
          final userID =  decodedToken['mdps'];
          setState(() {
            print("id====>$userID");
          user = userID ;
          print(user);});
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

    double screenWidth = MediaQuery.of(context).size.width;
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeSection()),
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
                            "Réserver Parking",
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
                padding: const EdgeInsets.fromLTRB(50.0,8,20,20),
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
                          Text(
                            "Réservation",
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
                      child: Row(
                        children: [
                          Text(
                            "Abonnements",
                            style: TextStyle(
                              fontSize: 20,
                              color:Colors.white,
                            ),
                          ),
                        ],
                      ), ),
                    SizedBox(width: 10,),
                  ],
                ),

              ),
              Center(
                child: Text("Durée de réservation" , style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(height:15),
              const Text("Entrée" ,
                style: TextStyle(
                color: Colors.black54,
                  fontSize: 22,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold
              ),
                textAlign:TextAlign.start,
              ),

              SizedBox(height:15),

              Row(
                children: [
                  SizedBox(width: screenWidth*0.05,),
                  Container(child: DatePicker(
                    onDateSelected: (newDate){
                      setState(() {
                        selectedDateEntre = newDate as DateTime;
                      });
                    },
                  ),
                    width:screenWidth*0.48 ,),
                  SizedBox(width: screenWidth*0.04,),
                  Container(width: screenWidth*0.4,child: TimePicker(
                    onTimeSelected: (newTime) {
                    setState(() {
                      selectedTimeEntre = newTime as DateTime;
                    });}),),
                ],
              ),
              SizedBox(height:15),
              const Text("Sortie" ,
                style: TextStyle(
                color: Colors.black54,
                  fontSize: 22,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold
              ),
                textAlign:TextAlign.start,
              ),
              SizedBox(height:15),
              Row(
                children: [
                  SizedBox(width: screenWidth*0.05,),
                  Container(child:DatePicker(
                    onDateSelected: (newDate){
                      setState(() {
                        selectedDateSortie = newDate as DateTime;
                      });
                    },
                  ),width:screenWidth*0.48 ,),
                  SizedBox(width: screenWidth*0.04,),
                  Container(child: TimePicker(
                      onTimeSelected: (newTime) {
                        setState(() {
                          selectedTimeSortie = newTime as DateTime;
                          print(selectedTimeSortie.hour);
                        });}),width: screenWidth*0.4,),
                ],
              ),
              SizedBox(height:15),
              const Text("Choisir un parking" ,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold
                ),
                textAlign:TextAlign.start,
              ),
              SizedBox(height:25),
              ProviderScope(
                child: Consumer(
                  builder: (context, ref, _) {
                    final parkingsAsyncValue = ref.watch(parkingDataProvider);
                    return parkingsAsyncValue.when(
                      data: (parkings) {
                        return DropdownButton<Parkings>(
                          value: selectedParking,
                          onChanged: (newValue) {
                            setState(() {
                              selectedParking = newValue;
                              selectedParkingId = selectedParking?.idParking ?? 0;
                              print(selectedParking?.idParking);
                            });
                          },
                          items: parkings?.listeDesParking?.map((parking) {
                            return DropdownMenuItem<Parkings>(
                              value: parking,
                              child: Container(
                                //padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      parking.nomParking ?? '',
                                      style: TextStyle(fontSize: 25, color: Colors.black),
                                    ),
                                   // Spacer(), // Adds space between text and image
                                    Image.network(
                                      parking.imageParking ?? '',
                                      width: 100,
                                     // height: 300,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList() ?? [],
                          style: TextStyle(fontSize: 24, color: Colors.black), // Style for the selected item
                          icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                          isExpanded: true, // Make the dropdown menu expand to fill available width
                          underline: Container(), // Remove the default underline
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (error, stackTrace) => Text('Error fetching parkings: $error'),
                    );
                  },
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                     addReservation(
                         DateFormat('yyyy-MM-dd HH:mm:ss').format(
                       DateTime(
                         selectedDateEntre.year,
                         selectedDateEntre.month,
                         selectedDateEntre.day,
                         selectedTimeEntre.hour,
                         selectedTimeEntre.minute,
                       ),
                     ),
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(
                       DateTime(
                         selectedDateSortie.year,
                         selectedDateSortie.month,
                         selectedDateSortie.day,
                         selectedTimeSortie.hour,
                         selectedTimeSortie.minute,
                       ),
                     ),


                     selectedParkingId.toString(),
                        "3", // Replace with the actual user ID
                         context,
                    );
                  },
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
        ),
      ),
    );
  }
}
