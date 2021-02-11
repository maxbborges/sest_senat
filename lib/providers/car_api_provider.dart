import 'package:sest_senat/model/car.dart';
import 'package:sest_senat/providers/db_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CarApiProvider {
  Future<List<Car>> getAllCars() async {
    String jsonString = await rootBundle.loadString('assets/cars.json');
    return json.decode(jsonString)['cars'].forEach((car) {
      print (car);
      DBProvider.db.createCar(Car.fromJson(car));
    });
  }
}
