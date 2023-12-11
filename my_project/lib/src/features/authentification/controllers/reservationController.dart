import 'dart:convert';
import 'package:my_project/src/features/authentification/controllers/JWThandler.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';
import 'package:my_project/src/features/authentification/models/user.dart';

import '../models/parking.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';


//final reservationControllerProvider = Provider<ReservationController>((ref) => ReservationController(ref.container, ref.read(jwtHandlerProvider)));

class ReservationController {
  final ProviderContainer _container;

  ReservationController(this._container, this.jwtHandler);

  final JWThandler jwtHandler ;

  Future<Reservations?> getReservation() async {
    final url = Uri.parse("http://10.0.2.2:8000/reservation");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Reservations.fromJson(jsonData);
      } else {
        // Handle error cases
        print("Failed to retrieve reservations. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle any exceptions
      print("Error while fetching reservations: $e");
      return null;
    }
  }


  Future<void> addReservation({
    required DateTime selectedEntranceDate,
    required DateTime selectedExitDate,
    required Parkings selectedParking,
  }) async {
    final url = Uri.parse("http://10.0.2.2:8000/reservation");


    // Format the selected dates and parking ID
    String entranceDate = selectedEntranceDate.toIso8601String();
    String exitDate = selectedExitDate.toIso8601String();
    int parkingId = selectedParking?.idParking ?? 0;

    final userData = await jwtHandler.fetchData();

   print(userData);

    Map<String, dynamic> reservationData = {
      "start_date": entranceDate,
      "end_date": exitDate,
      "id_parking_res": parkingId,
     // "id_user_res": userId,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(reservationData),
      );

      if (response.statusCode == 201) {
        // Reservation added successfully
        print("Reservation added successfully!");
      } else {
        print("Failed to add reservation. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }






}