class Parking {
  List<Parkings>? listeDesParking;

  Parking({this.listeDesParking});

  Parking.fromJson(Map<String, dynamic> json) {
    if (json['liste_des_parking'] != null) {
      listeDesParking = <Parkings>[];
      json['liste_des_parking'].forEach((v) {
        listeDesParking!.add(new Parkings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listeDesParking != null) {
      data['liste_des_parking'] =
          this.listeDesParking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parkings {
  int? idParking;
  String? nomParking;
  String? adresseParking;
  String? imageParking;
  String? description;
  String? heureOuverture;
  int? tarifPlace;

  Parkings(
      {required this.idParking,
        required this.nomParking,
        required this.adresseParking,
        required this.imageParking,
        required this.description,
        required this.heureOuverture,
        required this.tarifPlace});

  Parkings.fromJson(Map<String, dynamic> json) {
    idParking = json['id_parking'];
    nomParking = json['nom_parking'];
    adresseParking = json['adresse_parking'];
    imageParking = json['image_parking'];
    description = json['description'];
    heureOuverture = json['heure_ouverture'];
    tarifPlace = json['tarif_place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_parking'] = this.idParking;
    data['nom_parking'] = this.nomParking;
    data['adresse_parking'] = this.adresseParking;
    data['image_parking'] = this.imageParking;
    data['description'] = this.description;
    data['heure_ouverture'] = this.heureOuverture;
    data['tarif_place'] = this.tarifPlace;
    return data;
  }
}
