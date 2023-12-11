import 'package:jwt_decode/jwt_decode.dart';
import 'package:my_project/src/features/authentification/models/reservation.dart';
import 'package:my_project/src/features/authentification/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JWThandler {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt'); // Assuming you've stored the token as 'jwt'
  }

  Future<Map<String, dynamic>> getDecodedToken(String token) async {
    try {
      final Map<String, dynamic> decodedToken = Jwt.parseJwt(token); // Use Jwt.parseJwt to decode token
      return decodedToken;
    } catch (e) {
      print("Error decoding token: $e");
      return {};
    }
  }

  Future<UserDetails?> fetchData() async {
    UserDetails? user;
    List<Reservation> listDeReservation ;
    try {
      final token = await getToken();

      if (token != null) {
        final decodedToken = await getDecodedToken(token);

        if (decodedToken.isNotEmpty) {
          final userId = decodedToken['id'];
          final userEmail = decodedToken['adresse'];
          final userImage = decodedToken['imageUrl'];
          final userName = decodedToken['nom'];
          final reservations = decodedToken['reservations'];

          print("User Image: $userImage");
          print("User Email: $userEmail");
          print("User Name: $userName");
          print("reservations:$reservations");

          user = UserDetails(userName, userImage, userEmail);
          listDeReservation = reservations ;

          print("liste res = $listDeReservation");
        }
      } else {
        print("Token not available");
      }
    } catch (e) {
      print("Error fetching data: $e");
      // Handle errors
    }
    return user;
  }


  Future<List<Reservation>?> fetchResData() async {
    List<Reservation>? listDeReservation; // Change to nullable
    try {
      final token = await getToken();

      if (token != null) {
        final decodedToken = await getDecodedToken(token);

        if (decodedToken.isNotEmpty) {
          final reservations = decodedToken['reservations'];

          print("reservations: $reservations");

          // Convert the decoded reservations data into a list of Reservation objects
          if (reservations is List) {
            listDeReservation = reservations.map((data) => Reservation.fromJson(data)).toList();
          }

          print("liste res = $listDeReservation");
        }
      } else {
        print("Token not available");
      }
    } catch (e) {
      print("Error fetching data: $e");
      // Handle errors
    }
    return listDeReservation;
  }
}
