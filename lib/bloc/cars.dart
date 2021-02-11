import 'package:sest_senat/model/car.dart';
import 'package:sest_senat/repository/car_repository.dart';
import 'package:rxdart/rxdart.dart';

// class CarBloc {
//   final CarRepository _repository = CarRepository();
//   final BehaviorSubject<CarResponse> _subject = BehaviorSubject<CarResponse>();
//
//   getCar() async {
//     CarResponse response = await _repository.getCar();
//     _subject.sink.add(response);
//   }
//
//   dispose() {
//     _subject.close();
//   }
//
//   BehaviorSubject<CarResponse> get subject => _subject;
// }
//
// final bloc = CarBloc();
