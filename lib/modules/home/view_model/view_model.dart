import 'package:flutter/cupertino.dart';
import 'package:weather_app/modules/home/model/weather_model.dart';
import 'package:weather_app/modules/home/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();
  WetherModel? weather;

  Future getDetail(place,context) async {
    await _repository.getWeatherDetail(place,context).then((v) {
      weather = v;
    });
    notifyListeners();
  }
}
