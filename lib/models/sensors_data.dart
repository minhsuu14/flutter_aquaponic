import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorData {
  double? temp;
  double? hum;
  bool? lux;
  DateTime? date;

  SensorData({this.temp, this.hum, this.lux});
}

class SensorDataProvider with ChangeNotifier {
  List<SensorData> _data = [];

  List<SensorData> get data {
    return [..._data];
  }

  Future<void> fetchTempData() async {
    var url = Uri.parse(
        'https://aquaponic-project-2e7ac-default-rtdb.firebaseio.com/sensor.json');
    try {
      final response = await http.get(url);
      final tempData = json.decode(response.body) as Map<String, dynamic>;
      List<SensorData> loadedData = [];
      tempData.forEach((dataId, data) {
        loadedData.add(SensorData(
          temp: data['temperature'],
          hum: data['humidity'],
          lux: data['lux'],
        ));
      });
      _data = loadedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
