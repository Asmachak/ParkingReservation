import 'package:my_project/src/features/authentification/models/parking.dart';
import 'package:my_project/src/features/authentification/models/user.dart';

class Reservations {
  List<Reservation>? listeDesReservations;

  Reservations({this.listeDesReservations});

  Reservations.fromJson(Map<String, dynamic> json) {
    if (json['liste_des_reservations'] != null) {
      listeDesReservations = <Reservation>[];
      json['liste_des_reservations'].forEach((v) {
        listeDesReservations!.add(new Reservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listeDesReservations != null) {
      data['liste_des_reservations'] =
          this.listeDesReservations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservation {
  int? idReservation;
  String? startDate;
  String? endDate;
  Parkings? parking;
  UserDetails ? user;

      Reservation(
      {this.idReservation,
        this.startDate,
        this.endDate,
        this.parking,
        this.user});

  Reservation.fromJson(Map<String, dynamic> json) {
    idReservation = json['id_reservation'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    parking = json['parking'] != null ? new Parkings.fromJson(json['parking']) : null;
    user = json['user'] != null ? new UserDetails.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_reservation'] = this.idReservation;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.parking != null) {
      data['parking'] = this.parking!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}