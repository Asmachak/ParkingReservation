import 'dart:convert';
import '../models/parking.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final parkingControllerProvider = Provider<ParkingController>((ref) => ParkingController(ref.container));


class ParkingController {
  final ProviderContainer _container;

  ParkingController(this._container);

  Future<Parking?> getParkings() async {
    final url = Uri.parse("http://10.0.2.2:8000/getParking");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Parking.fromJson(jsonData);
      } else {
        // Handle error cases
        print("Failed to retrieve parkings. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle any exceptions
      print("Error while fetching parkings: $e");
      return null;
    }
  }
}