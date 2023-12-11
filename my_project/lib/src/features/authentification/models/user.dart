class UserDetails {
  String? nom ;
  String? email ;
  String? photoURL ;

  UserDetails(this.nom, this.email, this.photoURL);

  // create map
  UserDetails.fromJson(Map<String,dynamic> json){
    nom = json['nom'];
    photoURL = json['imageUrl'];
    email = json['adresse'];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['nom']=this.nom;
    data['imageUrl']=this.email;
    data['adresse']=this.photoURL;
    return data ;
  }
}