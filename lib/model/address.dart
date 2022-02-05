import 'dart:convert';

class Address {

  String country;
  String country_code;
  String phone;
  String phone_code;
  String phone_init;
  String state;
  String city;
  String address1;
  String address2;


  Address({
    required this.city,
    required this.country_code,
    required this.state,
    required this.address1,
    required this.address2,
    required this.country,
    required this.phone,
    required this.phone_code,
    required this.phone_init,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    city: json["city"],
    country_code: json["country_code"],
    country: json["country"],
    phone: json["phone"],
    address1: json["address1"],
    address2: json["address2"],
    state: json["state"],
    phone_code: json["phone_code"],
    phone_init: json["phone_init"],
  );

  Map<String, dynamic> toMap() => {
    "city": city,
    "country": country,
    "country_code": country_code,
    "phone": phone,
    "address1":address1,
    "address2":address2,
    "state":state,
    "phone_code":phone_code,
    "phone_init":phone_init,
  };
}