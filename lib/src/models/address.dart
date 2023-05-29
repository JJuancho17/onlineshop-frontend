import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {

  int? id;
  String? address;
  String? barrio;
  int? idUser;
  double? lat;
  double? lng;

  Address({
    this.id,
    this.address,
    this.barrio,
    this.idUser,
    this.lat,
    this.lng,
  });



  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    address: json["address"],
    barrio: json["barrio"],
    idUser: json["user"],
    lat: json["lat"],
    lng: json["lng"]
  );
  /*
  static List<Address> fromJsonList(List<dynamic> jsonList) {
    List<Address> toList = [];
    jsonList.forEach((item) {
      Address address = Address.fromJson(item);
      toList.add(address);
    });

    return toList;
  }

   */

  static List<Address> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Address.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "barrio": barrio,
    "user": idUser,
    "lat": lat,
    "lng": lng,
  };
}
