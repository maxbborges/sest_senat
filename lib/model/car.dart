import 'dart:convert';

// List<Car> carfromJson(String str) =>
//     List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

// String carToJson(List<Car> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// (json["cars"] as List).map((i) => new Car.fromJson(i)).toList(),
Car carFromJson(String str) {
  final jsonData = json.decode(str);
  return Car.fromJson(jsonData);
}

String carToJson(Car data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Car {
  final int id;
  final String model;
  final String brand;
  final int year;
  final int price;
  final String photo;

  Car({this.id, this.model, this.brand, this.year, this.price, this.photo});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      model: json["model"],
      brand: json["brand"],
      year: json["year"],
      price: json["price"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "model": model,
        "brand": brand,
        "year": year,
        "price": price,
        "photo": photo,
      };
}

class CarResponse {
  final List<Car> results;
  final String error;

  CarResponse(this.results, this.error);

  CarResponse.fromJson(Map<String, dynamic> json)
      : results =
            (json['cars'] as List).map((i) => new Car.fromJson(i)).toList(),
        error = "";

  CarResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}
