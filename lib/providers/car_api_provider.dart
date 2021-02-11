import 'package:sest_senat/model/car.dart';
import 'package:dio/dio.dart';
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

  // final String _endpoint = "https://api.mocki.io/v1/c72e9f8d";
  // final Dio _dio = Dio();

  // Future<CarResponse> getCar() async {
  //   try {
  //     Response response = await _dio.get(_endpoint);
  //     return CarResponse.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return CarResponse.withError("$error");
  //   }
  // }
  // Future<List<Car>> getAllCars() async {
  //
  //   try {
  //     Response a = await _dio.get(_endpoint);
  //     if (a.isNotEmpty) {
  //       return a.forEach((car) {
  //         DBProvider.db.createCar(Car.fromJson(car));
  //       });
  //
  //     }
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //   }
  // }
}
