class User {
  String? name;
  String? id;
  String? phone;
  String ? email;
  List <String>? favorite;

  User(
      {required this.name, required this.email, required this.phone, required this.id,required this.favorite});

  User.fromFireStore(Map<String, dynamic>?fireStoreMap){
    name = fireStoreMap?["name"];
    id = fireStoreMap?["id"];
    phone = fireStoreMap?["phone"];
    email = fireStoreMap?["email"];
    favorite=List<String>.from(fireStoreMap?["favorite"]) ;///theres a problem happened while parsing list from map you should define return before parsing
  }

  Map<String, dynamic>  toFireStore() {
    return {
      "name":name,
          "id":id,
          "phone":phone,
          "email":email,
          "favorite":favorite
    };
  }
}